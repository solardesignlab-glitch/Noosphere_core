import { useEffect, useState } from "react";
import { backendRequest } from "../api/backend";

const emptyForm = { name: "", phone: "", email: "", source: "" };

const pageStyle = {
  padding: "24px 32px",
  fontFamily: "Inter, sans-serif",
};

const titleStyle = {
  fontSize: "22px",
  fontWeight: 600,
  color: "#101828",
  margin: "0 0 16px",
};

const panelStyle = {
  background: "#FFFFFF",
  border: "1px solid #EAECF0",
  borderRadius: "14px",
  padding: "16px",
  marginBottom: "16px",
  boxShadow: "0 1px 3px rgba(16, 24, 40, 0.06)",
};

const inputStyle = {
  border: "1px solid #EAECF0",
  borderRadius: "10px",
  padding: "8px 12px",
  fontSize: "14px",
  marginRight: "8px",
};

const buttonStyle = {
  background: "#5B5BD6",
  color: "#FFFFFF",
  border: "none",
  borderRadius: "10px",
  padding: "8px 16px",
  fontSize: "14px",
  cursor: "pointer",
};

const tableStyle = {
  width: "100%",
  borderCollapse: "collapse",
  background: "#FFFFFF",
  border: "1px solid #EAECF0",
  borderRadius: "14px",
  overflow: "hidden",
};

export default function ClientsPage() {
  const [items, setItems] = useState([]);
  const [search, setSearch] = useState("");
  const [form, setForm] = useState(emptyForm);
  const [error, setError] = useState("");
  const [loading, setLoading] = useState(false);

  async function load(query = search) {
    setLoading(true);
    try {
      const data = await backendRequest(
        `/api/clients${query ? `?search=${encodeURIComponent(query)}` : ""}`
      );
      setItems(data.items || []);
      setError("");
    } catch (e) {
      setError(e.message);
    } finally {
      setLoading(false);
    }
  }

  useEffect(() => {
    load("");
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, []);

  async function handleSubmit(e) {
    e.preventDefault();
    try {
      await backendRequest("/api/clients", {
        method: "POST",
        body: JSON.stringify(form),
      });
      setForm(emptyForm);
      load();
    } catch (e) {
      setError(e.message);
    }
  }

  async function handleDelete(id) {
    if (!window.confirm("Удалить клиента?")) return;
    try {
      await backendRequest(`/api/clients/${id}`, { method: "DELETE" });
      load();
    } catch (e) {
      setError(e.message);
    }
  }

  return (
    <div style={pageStyle}>
      <h1 style={titleStyle}>Клиенты</h1>

      {error ? (
        <div
          style={{
            background: "#FEF3F2",
            color: "#F04438",
            border: "1px solid #FEE4E2",
            borderRadius: "10px",
            padding: "10px 14px",
            marginBottom: "12px",
          }}
        >
          {error}
        </div>
      ) : null}

      <div style={panelStyle}>
        <form
          onSubmit={handleSubmit}
          style={{ display: "flex", gap: "8px", flexWrap: "wrap" }}
        >
          <input
            style={{ ...inputStyle, flex: "1 1 160px" }}
            placeholder="Имя *"
            value={form.name}
            onChange={(e) => setForm({ ...form, name: e.target.value })}
          />
          <input
            style={inputStyle}
            placeholder="Телефон"
            value={form.phone}
            onChange={(e) => setForm({ ...form, phone: e.target.value })}
          />
          <input
            style={inputStyle}
            placeholder="Email"
            value={form.email}
            onChange={(e) => setForm({ ...form, email: e.target.value })}
          />
          <input
            style={inputStyle}
            placeholder="Источник"
            value={form.source}
            onChange={(e) => setForm({ ...form, source: e.target.value })}
          />
          <button type="submit" style={buttonStyle}>
            Добавить
          </button>
        </form>
      </div>

      <div style={panelStyle}>
        <input
          style={{ ...inputStyle, width: "320px" }}
          placeholder="Поиск по имени, телефону, email"
          value={search}
          onChange={(e) => setSearch(e.target.value)}
          onKeyDown={(e) => {
            if (e.key === "Enter") {
              e.preventDefault();
              load();
            }
          }}
        />
        <button
          type="button"
          style={{ ...buttonStyle, background: "#EEEDFB", color: "#3F3FB8" }}
          onClick={() => load()}
        >
          Найти
        </button>
      </div>

      {loading ? <p>Загрузка...</p> : null}

      <table style={tableStyle}>
        <thead>
          <tr>
            {["Имя", "Телефон", "Email", "Источник", "Создан", ""].map(
              (h) => (
                <th
                  key={h}
                  style={{
                    textAlign: "left",
                    padding: "10px 12px",
                    borderBottom: "1px solid #EAECF0",
                    color: "#667085",
                    fontSize: "13px",
                  }}
                >
                  {h}
                </th>
              )
            )}
          </tr>
        </thead>
        <tbody>
          {items.length === 0 && !loading ? (
            <tr>
              <td
                colSpan={6}
                style={{ padding: "16px 12px", color: "#667085" }}
              >
                Клиентов пока нет — добавьте первого в форме выше.
              </td>
            </tr>
          ) : null}
          {items.map((client) => (
            <tr key={client.id}>
              <td style={{ padding: "10px 12px" }}>{client.name}</td>
              <td style={{ padding: "10px 12px" }}>{client.phone || "—"}</td>
              <td style={{ padding: "10px 12px" }}>{client.email || "—"}</td>
              <td style={{ padding: "10px 12px" }}>{client.source || "—"}</td>
              <td style={{ padding: "10px 12px", color: "#667085" }}>
                {client.created_at
                  ? String(client.created_at).slice(0, 10)
                  : "—"}
              </td>
              <td style={{ padding: "10px 12px" }}>
                <button
                  type="button"
                  onClick={() => handleDelete(client.id)}
                  style={{
                    background: "#FEF3F2",
                    color: "#F04438",
                    border: "1px solid #FEE4E2",
                    borderRadius: "8px",
                    padding: "4px 10px",
                    cursor: "pointer",
                  }}
                >
                  Удалить
                </button>
              </td>
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  );
}
