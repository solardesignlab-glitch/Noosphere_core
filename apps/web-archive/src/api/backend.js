const BACKEND_URL = "http://localhost:4000";

export function getToken() {
  return localStorage.getItem("atmosfera_token");
}

export function setToken(token) {
  if (token) {
    localStorage.setItem("atmosfera_token", token);
  } else {
    localStorage.removeItem("atmosfera_token");
  }
}

export async function backendRequest(path, options = {}) {
  const token = getToken();

  const response = await fetch(`${BACKEND_URL}${path}`, {
    ...options,
    headers: {
      ...(token ? { Authorization: `Bearer ${token}` } : {}),
      ...(options.body instanceof FormData
        ? {}
        : { "Content-Type": "application/json" }),
      ...(options.headers || {})
    }
  });

  if (response.status === 401) {
    setToken(null);
    localStorage.removeItem("atmosfera_user");
    window.location.href = window.location.origin;
    throw new Error("Требуется вход в систему");
  }

  if (!response.ok) {
    let detail = `Ошибка запроса: ${response.status}`;

    try {
      const data = await response.json();
      detail = data.detail || data.error || detail;
    } catch {
      /* ignore */
    }

    throw new Error(detail);
  }

  return response.json();
}

export async function login(email, password) {
  const data = await backendRequest("/api/auth/login", {
    method: "POST",
    body: JSON.stringify({ email, password })
  });

  setToken(data.token);
  localStorage.setItem("atmosfera_user", JSON.stringify(data.user));

  return data.user;
}

export function logout() {
  setToken(null);
  localStorage.removeItem("atmosfera_user");
}

export function getStoredUser() {
  try {
    const raw = localStorage.getItem("atmosfera_user");
    return raw ? JSON.parse(raw) : null;
  } catch {
    return null;
  }
}