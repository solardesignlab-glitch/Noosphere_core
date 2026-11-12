import { useEffect, useState } from "react";

export function StatusCheck() {
  const [status, setStatus] = useState(null);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    fetch("/api/v1/db-audit")
      .then((r) => {
        if (!r.ok) throw new Error(`HTTP ${r.status}`);
        return r.json();
      })
      .then((data) => {
        setStatus(data);
        setLoading(false);
      })
      .catch((e) => {
        console.error("Ошибка связи с бэкендом", e);
        setStatus({ error: true, message: e.message });
        setLoading(false);
      });
  }, []);

  if (loading) {
    return (
      <div style={{ padding: "12px", color: "#666" }}>
        Проверка соединения с API...
      </div>
    );
  }

  if (status?.error) {
    return (
      <div
        style={{
          padding: "12px",
          background: "#fff3f3",
          color: "#c62828",
          border: "1px solid #ffcdd2",
        }}
      >
        ❌ Ошибка: {status.message}
      </div>
    );
  }

  return (
    <div
      style={{
        padding: "12px",
        background: "#f1f8e9",
        color: "#2e7d32",
        border: "1px solid #c8e6c9",
      }}
    >
      ✅ Статус: {status.service} • База: {status.db}
      {status.tables && ` • Таблиц: ${status.tables.length}`}
    </div>
  );
}
