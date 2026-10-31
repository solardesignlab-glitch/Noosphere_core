import { backendRequest } from "./backend";

export function getUpcomingSessions(limit = 10) {
  return backendRequest(`/api/records/sessions?limit=${limit}`);
}

export async function getSession(id) {
  return backendRequest(`/api/records/sessions/${id}`);
}

export async function updateSessionStatus(id, status) {
  return backendRequest(`/api/records/sessions/${id}`, {
    method: "PUT",
    body: JSON.stringify({
      status
    })
  });
}

export function calculateDayMetrics(sessions) {
  const total = sessions.length;

  const confirmed = sessions.filter(
    (item) => item.status === "confirmed" || item.status === "in_progress"
  ).length;

  const pending = sessions.filter(
    (item) => item.status === "new"
  ).length;

  const completed = sessions.filter(
    (item) => item.status === "completed"
  ).length;

  const cancelled = sessions.filter(
    (item) =>
      item.status === "cancelled" || item.status === "no_show"
  ).length;

  const noShow = sessions.filter(
    (item) => item.status === "no_show"
  ).length;

  const conversion = total
    ? Math.round(((confirmed + completed) / total) * 100)
    : 0;

  return {
    total,
    confirmed,
    pending,
    completed,
    cancelled,
    noShow,
    conversion
  };
}

export function formatDateTime(value) {
  if (!value) return "—";

  return new Date(value).toLocaleString("ru-RU", {
    day: "2-digit",
    month: "2-digit",
    hour: "2-digit",
    minute: "2-digit"
  });
}

export function getStatusClass(status) {
  const map = {
    new: "status--pending",
    confirmed: "status--confirmed",
    in_progress: "status--confirmed",
    completed: "status--completed",
    cancelled: "status--cancelled",
    no_show: "status--cancelled"
  };

  return map[status] || "status--pending";
}

export function getStatusLabel(status) {
  const map = {
    new: "Новая",
    confirmed: "Подтверждена",
    in_progress: "В процессе",
    completed: "Завершена",
    cancelled: "Отменена",
    no_show: "Не пришёл"
  };

  return map[status] || status;
}