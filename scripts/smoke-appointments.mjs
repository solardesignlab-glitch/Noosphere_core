const API = process.env.API_URL || "http://localhost:4000";

const EMAIL = process.env.TEST_EMAIL;
const PASSWORD = process.env.TEST_PASSWORD;

if (!EMAIL || !PASSWORD) {
  console.error("Укажите TEST_EMAIL и TEST_PASSWORD");
  process.exit(1);
}

let failures = 0;

function check(name, condition, details = "") {
  if (condition) {
    console.log(`PASS: ${name}`);
  } else {
    failures += 1;
    console.error(`FAIL: ${name} ${details}`);
  }
}

async function api(path, options = {}) {
  const response = await fetch(`${API}${path}`, {
    ...options,
    headers: {
      "Content-Type": "application/json",
      ...(token ? { Authorization: `Bearer ${token}` } : {}),
      ...(options.headers || {})
    }
  });

  let data = null;

  try {
    data = await response.json();
  } catch {
    data = null;
  }

  return { status: response.status, data };
}

let token = "";

const login = await fetch(`${API}/api/auth/login`, {
  method: "POST",
  headers: { "Content-Type": "application/json" },
  body: JSON.stringify({ email: EMAIL, password: PASSWORD })
});

const loginData = await login.json();
token = loginData.token || loginData.access_token;

check("login", login.status === 200 && Boolean(token), JSON.stringify(loginData));

if (!token) process.exit(1);

const suffix = Date.now();

const client = await api("/api/clients", {
  method: "POST",
  body: JSON.stringify({
    name: `Smoke Client ${suffix}`,
    phone: "+70000000000",
    email: `smoke-${suffix}@example.com`
  })
});

check("create client", client.status === 201, JSON.stringify(client.data));
const clientId = client.data?.client?.id;

const master = await api("/api/masters", {
  method: "POST",
  body: JSON.stringify({
    name: `Smoke Master ${suffix}`,
    specialty: "Smoke Test"
  })
});

check("create master", master.status === 201, JSON.stringify(master.data));
const masterId = master.data?.master?.id;

const service = await api("/api/services", {
  method: "POST",
  body: JSON.stringify({
    name: `Smoke Service ${suffix}`,
    price: 1000,
    duration_minutes: 60
  })
});

check("create service", service.status === 201, JSON.stringify(service.data));
const serviceId = service.data?.service?.id;

if (!clientId || !masterId || !serviceId) {
  console.error("Не удалось создать тестовые сущности");
  process.exit(1);
}

const start = new Date();
start.setMinutes(0, 0, 0);
start.setDate(start.getDate() + 1);

const end = new Date(start.getTime() + 60 * 60 * 1000);

const appointment = await api("/api/appointments", {
  method: "POST",
  body: JSON.stringify({
    client_id: clientId,
    master_id: masterId,
    service_id: serviceId,
    starts_at: start.toISOString(),
    ends_at: end.toISOString(),
    notes: "Smoke test"
  })
});

check("create appointment", appointment.status === 201, JSON.stringify(appointment.data));
const appointmentId = appointment.data?.appointment?.id;

const conflict = await api("/api/appointments", {
  method: "POST",
  body: JSON.stringify({
    client_id: clientId,
    master_id: masterId,
    service_id: serviceId,
    starts_at: new Date(start.getTime() + 30 * 60 * 1000).toISOString(),
    ends_at: new Date(start.getTime() + 90 * 60 * 1000).toISOString()
  })
});

check("appointment conflict rejected", conflict.status === 409, JSON.stringify(conflict.data));

const updated = await api(`/api/appointments/${appointmentId}`, {
  method: "PUT",
  body: JSON.stringify({
    client_id: clientId,
    master_id: masterId,
    service_id: serviceId,
    starts_at: start.toISOString(),
    ends_at: end.toISOString(),
    status: "completed",
    notes: "Smoke test completed"
  })
});

check("update appointment", updated.status === 200, JSON.stringify(updated.data));
check("status updated", updated.data?.appointment?.status === "completed");

const list = await api("/api/appointments");
check("list appointments", list.status === 200 && Array.isArray(list.data?.appointments));

if (appointmentId) {
  const deleted = await api(`/api/appointments/${appointmentId}`, { method: "DELETE" });
  check("delete appointment", deleted.status === 200, JSON.stringify(deleted.data));
}

if (clientId) await api(`/api/clients/${clientId}`, { method: "DELETE" });
if (masterId) await api(`/api/masters/${masterId}`, { method: "DELETE" });
if (serviceId) await api(`/api/services/${serviceId}`, { method: "DELETE" });

console.log(failures === 0 ? "\nALL TESTS PASSED" : `\n${failures} TEST(S) FAILED`);
process.exit(failures === 0 ? 0 : 1);