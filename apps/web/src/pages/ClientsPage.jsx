import { useCallback, useEffect, useState } from "react";
import { backendRequest } from "../api/backend.js";

const emptyForm = {
  name: "",
  phone: "",
  email: "",
  notes: "",
  source: "",
  isActive: true
};

export default function ClientsPage() {
  const [clients, setClients] = useState([]);
  const [search, setSearch] = useState("");
  const [form, setForm] = useState(emptyForm);
  const [editingId, setEditingId] = useState(null);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState("");
  const [message, setMessage] = useState("");

  const loadClients = useCallback(async (searchText = "") => {
    setLoading(true);
    setError("");

    try {
      const query = searchText ? `?search=${encodeURIComponent(searchText)}` : "";
      const data = await backendRequest(`/api/clients${query}`);
      setClients(data.clients || []);
    } catch (err) {
      setError(err.message || "Не удалось загрузить клиентов");
    } finally {
      setLoading(false);
    }
  }, []);

  useEffect(() => {
    loadClients();
  }, [loadClients]);

  const handleChange = (event) => {
    const { name, value, type, checked } = event.target;
    setForm((prev) => ({
      ...prev,
      [name]: type === "checkbox" ? checked : value
    }));
  };

  const handleSubmit = async (event) => {
    event.preventDefault();
    setError("");
    setMessage("");

    if (!form.name.trim()) {
      setError("Укажите имя клиента");
      return;
    }

    try {
      if (editingId) {
        await backendRequest(`/api/clients/${editingId}`, {
          method: "PUT",
          body: form
        });
        setMessage("Клиент обновлён");
      } else {
        await backendRequest("/api/clients", {
  method: "POST",
  body: JSON.stringify(form)
});
        setMessage("Клиент создан");
      }

      setForm(emptyForm);
      setEditingId(null);
      await loadClients(search);
    } catch (err) {
      setError(err.message || "Не удалось сохранить клиента");
    }
  };

  const handleEdit = (client) => {
    setEditingId(client.id);
    setForm({
      name: client.name || "",
      phone: client.phone || "",
      email: client.email || "",
      notes: client.notes || "",
      source: client.source || "",
      isActive: Boolean(client.is_active)
    });
    setMessage("");
    setError("");
  };

  const handleCancelEdit = () => {
    setEditingId(null);
    setForm(emptyForm);
    setMessage("");
    setError("");
  };

  const handleDelete = async (client) => {
    if (!window.confirm(`Удалить клиента «${client.name}»?`)) {
      return;
    }

    setError("");
    setMessage("");

    try {
      await backendRequest(`/api/clients/${client.id}`, {
        method: "DELETE"
      });
      setMessage("Клиент удалён");
      await loadClients(search);
    } catch (err) {
      setError(err.message || "Не удалось удалить клиента");
    }
  };

  const handleSearch = (event) => {
    event.preventDefault();
    loadClients(search);
  };

  return (
    <div>
      <h1>Клиенты</h1>

      {error && <p style={{ color: "red" }}>{error}</p>}
      {message && <p style={{ color: "green" }}>{message}</p>}

      <form onSubmit={handleSearch} style={{ marginBottom: 16 }}>
        <input
          type="text"
          placeholder="Поиск по имени, телефону или email"
          value={search}
          onChange={(event) => setSearch(event.target.value)}
        />
        <button type="submit">Найти</button>
      </form>

      <form onSubmit={handleSubmit} style={{ marginBottom: 24 }}>
        <h2>{editingId ? "Редактировать клиента" : "Новый клиент"}</h2>

        <div>
          <input
            name="name"
            placeholder="Имя"
            value={form.name}
            onChange={handleChange}
            required
          />
        </div>

        <div>
          <input
            name="phone"
            placeholder="Телефон"
            value={form.phone}
            onChange={handleChange}
          />
        </div>

        <div>
          <input
            name="email"
            type="email"
            placeholder="Email"
            value={form.email}
            onChange={handleChange}
          />
        </div>

        <div>
          <input
            name="source"
            placeholder="Источник: сайт, Instagram, рекомендация"
            value={form.source}
            onChange={handleChange}
          />
        </div>

        <div>
          <textarea
            name="notes"
            placeholder="Заметки"
            value={form.notes}
            onChange={handleChange}
          />
        </div>

        <label>
          <input
            name="isActive"
            type="checkbox"
            checked={form.isActive}
            onChange={handleChange}
          />
          Активен
        </label>

        <div>
          <button type="submit">
            {editingId ? "Сохранить" : "Создать клиента"}
          </button>

          {editingId && (
            <button type="button" onClick={handleCancelEdit}>
              Отмена
            </button>
          )}
        </div>
      </form>

      {loading ? (
        <p>Загрузка...</p>
      ) : (
        <table border="1" cellPadding="8">
          <thead>
            <tr>
              <th>Имя</th>
              <th>Телефон</th>
              <th>Email</th>
              <th>Источник</th>
              <th>Статус</th>
              <th>Действия</th>
            </tr>
          </thead>
          <tbody>
            {clients.length === 0 ? (
              <tr>
                <td colSpan="6">Клиентов пока нет</td>
              </tr>
            ) : (
              clients.map((client) => (
                <tr key={client.id}>
                  <td>{client.name}</td>
                  <td>{client.phone || "—"}</td>
                  <td>{client.email || "—"}</td>
                  <td>{client.source || "—"}</td>
                  <td>{client.is_active ? "Активен" : "Неактивен"}</td>
                  <td>
                    <button onClick={() => handleEdit(client)}>
                      Изменить
                    </button>
                    <button onClick={() => handleDelete(client)}>
                      Удалить
                    </button>
                  </td>
                </tr>
              ))
            )}
          </tbody>
        </table>
      )}
    </div>
  );
}