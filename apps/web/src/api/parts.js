const API_URL = "http://localhost:4000/api/parts";


export async function getParts() {
  const response = await fetch(API_URL);


  if (!response.ok) {
    throw new Error("Не удалось загрузить запчасти");
  }


  const data = await response.json();
  return data.items || [];
}


export async function createPart(payload) {
  const response = await fetch(API_URL, {
    method: "POST",
    headers: {
      "Content-Type": "application/json"
    },
    body: JSON.stringify(payload)
  });


  if (!response.ok) {
    const data = await response.json();
    throw new Error(data.error || "Не удалось создать запчасть");
  }


  return response.json();
}


export async function updatePart(id, payload) {
  const response = await fetch(`${API_URL}/${id}`, {
    method: "PUT",
    headers: {
      "Content-Type": "application/json"
    },
    body: JSON.stringify(payload)
  });


  if (!response.ok) {
    const data = await response.json();
    throw new Error(data.error || "Не удалось обновить запчасть");
  }


  return response.json();
}


export async function deletePart(id) {
  const response = await fetch(`${API_URL}/${id}`, {
    method: "DELETE"
  });


  if (!response.ok) {
    throw new Error("Не удалось удалить запчасть");
  }


  return response.json();
}