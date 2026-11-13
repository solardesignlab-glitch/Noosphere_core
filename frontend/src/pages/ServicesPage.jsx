import { useEffect, useState } from "react";
import { backendRequest } from "../api/backend";

const EMPTY_FORM = {
  name: "",
  category: "",
  durationMinutes: 60,
  price: 0,
  isActive: true,
  description: "",
};

export default function ServicesPage() {
  const [items, setItems] = useState([]);
  const [search, setSearch] = useState("");
  const [form, setForm] = useState(EMPTY_FORM);
  const [error, setError] = useState("");
  const [isLoading, setIsLoading] = useState(false);

  async function loadItems() {
    setIsLoading(true);
    try {
      const data = await backendRequest("/api/services");
      setItems(data.items || []);
      setError("");
    } catch (err) {
      setError(err.message);
    } finally {
      setIsLoading(false);
    }
  }

  useEffect(() => {
    loadItems();
  }, []);

  async function handleCreate(event) {
    event.preventDefault();
    try {
      await backendRequest("/api/services", {
        method: "POST",
        body: JSON.stringify({
          name: form.name,
          category: form.category,
          durationMinutes: Number(form.durationMinutes) || 60,
          price: Number(form.price) || 0,
          isActive: form.isActive,
          description: form.description,
        }),
      });
      setForm(EMPTY_FORM);
      await loadItems();
    } catch (err) {
      setError(err.message);
    }
  }

  async function handleDelete(id) {
    if (!window.confirm("Удалить услугу?")) return;
    try {
      await backendRequest(`/api/services/${id}`, { method: "DELETE" });
      await loadItems();
    } catch (err) {
      setError(err.message);
    }
  }

  const filtered = items.filter((item) => {
    const query = search.trim().toLowerCase();
    if (!query) return true;
    return (
      (item.name || "").toLowerCase().includes(query) ||
      (item.category || "").toLowerCase().includes(query)
    );
  });

  return (
    <section className="page">
      <header className="page__header">
        <div>
          <h1>Услуги</h1>
          <p>Каталог услуг салона: названия, длительность и цены.</p>
        </div>
      </header>

      {error && <div className="alert alert--error">{error}</div>}

      <form className="card" onSubmit={handleCreate}>
        <input
          placeholder="Название услуги"
          value={form.name}
          onChange={(e) => setForm({ ...form, name: e.target.value })}
          required
        />
        <input
          placeholder="Категория"
          value={form.category}
          onChange={(e) => setForm({ ...form, category: e.target.value })}
        />
        <input
          type="number"
          min="5"
          max="1440"
          placeholder="Длительность, мин"
          value={form.durationMinutes}
          onChange={(e) => setForm({ ...form, durationMinutes: e.target.value })}
        />
        <input
          type="number"
          min="0"
          step="0.01"
          placeholder="Цена"
          value={form.price}
          onChange={(e) => setForm({ ...form, price: e.target.value })}
        />
        <label>
          <input
            type="checkbox"
            checked={form.isActive}
            onChange={(e) => setForm({ ...form, isActive: e.target.checked })}
          />
          Активна
        </label>
        <button className="button button--primary" type="submit">
          Добавить услугу
        </button>
      </form>

      <input
        className="search-input"
        placeholder="Поиск по названию или категории"
        value={search}
        onChange={(e) => setSearch(e.target.value)}
      />

      {isLoading ? (
        <p>Загрузка…</p>
      ) : filtered.length === 0 ? (
        <div className="empty-state">
          <div className="empty-state__icon">💼</div>
          <h2>Услуг пока нет</h2>
          <p>Добавьте первую услугу — она появится в списке выше.</p>
        </div>
      ) : (
        <table>
          <thead>
            <tr>
              <th>Название</th>
              <th>Категория</th>
              <th>Длительность</th>
              <th>Цена</th>
              <th>Активна</th>
              <th></th>
            </tr>
          </thead>
          <tbody>
            {filtered.map((item) => (
              <tr key={item.id}>
                <td>{item.name}</td>
                <td>{item.category || "—"}</td>
                <td>{item.duration_minutes} мин</td>
                <td>{item.price}</td>
                <td>{item.is_active ? "Да" : "Нет"}</td>
                <td>
                  <button type="button" onClick={() => handleDelete(item.id)}>
                    Удалить
                  </button>
                </td>
              </tr>
            ))}
          </tbody>
        </table>
      )}
    </section>
  );
}
