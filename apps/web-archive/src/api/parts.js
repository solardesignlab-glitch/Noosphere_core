import { backendRequest } from "./backend";

export async function getParts() {
  const data = await backendRequest("/api/parts");
  return data.items || [];
}

export async function createPart(payload) {
  return backendRequest("/api/parts", {
    method: "POST",
    body: JSON.stringify(payload)
  });
}

export async function updatePart(id, payload) {
  return backendRequest(`/api/parts/${id}`, {
    method: "PUT",
    body: JSON.stringify(payload)
  });
}

export async function deletePart(id) {
  return backendRequest(`/api/parts/${id}`, {
    method: "DELETE"
  });
}