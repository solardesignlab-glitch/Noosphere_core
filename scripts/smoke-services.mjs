const API_URL = "http://localhost:4000";

async function request(path, options = {}) {
  const res = await fetch(`${API_URL}${path}`, {
    ...options,
    headers: {
      "Content-Type": "application/json",
      ...(options.headers || {}),
    },
  });

  const text = await res.text();
  const data = text ? JSON.parse(text) : null;

  if (!res.ok) {
    throw new Error(`${res.status} ${res.statusText}: ${text}`);
  }

  return data;
}

async function main() {
  const login = await request("/api/auth/login", {
    method: "POST",
    body: JSON.stringify({
      email: "owner@atmosfera.local",
      password: "AtmosferaOwner2026!",
    }),
  });

  const token = login.token || login.accessToken || login.data?.token;

  if (!token) {
    throw new Error("Login response does not contain a token");
  }

  const auth = { Authorization: `Bearer ${token}` };

  const created = await request("/api/services", {
    method: "POST",
    headers: auth,
    body: JSON.stringify({
      name: "Smoke Haircut",
      description: "Smoke test service",
      price: 1500,
      durationMinutes: 45,
    }),
  });

  const service = created.service || created;

console.log("CREATED SERVICE RESPONSE:", JSON.stringify(created, null, 2));

  if (!service?.id) {
    throw new Error("Created service response does not contain id");
  }

  if (service.duration_minutes !== 45) {
    throw new Error(`Expected duration_minutes=45, got ${service.duration_minutes}`);
  }

  console.log("PASS: create service with duration");

  const updated = await request(`/api/services/${service.id}`, {
    method: "PUT",
    headers: auth,
    body: JSON.stringify({
      name: "Smoke Haircut Updated",
      description: "Smoke test service updated",
      price: 1800,
      durationMinutes: 60,
    }),
  });

  const updatedService = updated.service || updated;

  if (updatedService.duration_minutes !== 60) {
    throw new Error(`Expected duration_minutes=60, got ${updatedService.duration_minutes}`);
  }

  console.log("PASS: update service duration");

  const list = await request("/api/services", { headers: auth });
  const items = Array.isArray(list) ? list : list.services || [];

  if (!items.some((item) => item.id === service.id && item.duration_minutes === 60)) {
    throw new Error("Updated service duration not found in list");
  }

  console.log("PASS: list services includes duration");

  await request(`/api/services/${service.id}`, {
    method: "DELETE",
    headers: auth,
  });

  console.log("PASS: delete service");
  console.log("\nALL SERVICES TESTS PASSED");
}

main().catch((error) => {
  console.error("SERVICE SMOKE FAILED:", error.message);
  process.exit(1);
});