import { useEffect, useState } from "react";
import axios from "axios";

const API_URL = "http://localhost:4000/api/services";

function getToken() {
  return localStorage.getItem("atmosfera_token");
}

export default function ServicesPage() {
  const [services, setServices] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState("");

  const [form, setForm] = useState({
    name: "",
    description: "",
    price: "",
    duration_minutes: "",
  });

  const [editingId, setEditingId] = useState(null);

  const loadServices = async () => {
    try {
      setLoading(true);
      setError("");

      const res = await axios.get(API_URL, {
  headers: {
    Authorization: `Bearer ${getToken()}`,
  },
});

const data = res.data;

      setServices(Array.isArray(data) ? data : data.services || []);
    } catch (err) {
      setError(
        err.response?.data?.message ||
          "Не удалось загрузить услуги. Проверьте, что backend запущен."
      );
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    loadServices();
  }, []);

  const handleChange = (e) => {
    setForm({
      ...form,
      [e.target.name]: e.target.value,
    });
  };

  const resetForm = () => {
    setForm({
      name: "",
      description: "",
      price: "",
      duration_minutes: "",
    });
    setEditingId(null);
  };

  const handleSubmit = async (e) => {
    e.preventDefault();

    try {
      const payload = {
        name: form.name,
        description: form.description,
        price: Number(form.price),
        duration_minutes: Number(form.duration_minutes),
      };

      if (editingId) {
        await axios.put(`${API_URL}/${editingId}`, payload, {
          headers: {
            Authorization: `Bearer ${getToken()}`,
          },
        });
      } else {
        await axios.post(API_URL, payload, {
          headers: {
            Authorization: `Bearer ${getToken()}`,
          },
        });
      }

      resetForm();
      await loadServices();
    } catch (err) {
      setError(
        err.response?.data?.message ||
          "Не удалось сохранить услугу."
      );
    }
  };

  const handleEdit = (service) => {
    setEditingId(service.id);
    setForm({
      name: service.name || "",
      description: service.description || "",
      price: service.price ?? "",
      duration_minutes: service.duration_minutes ?? "",
    });
  };

  const handleDelete = async (id) => {
    if (!window.confirm("Удалить услугу?")) return;

    try {
      await axios.delete(`${API_URL}/${id}`, {
        headers: {
          Authorization: `Bearer ${getToken()}`,
        },
      });

      await loadServices();
    } catch (err) {
      setError(
        err.response?.data?.message ||
          "Не удалось удалить услугу."
      );
    }
  };

  return (
    <div style={{ padding: "20px" }}>
      <h1>Услуги</h1>

      {error && (
        <div
          style={{
            color: "red",
            marginBottom: "15px",
            whiteSpace: "pre-wrap",
          }}
        >
          {error}
        </div>
      )}

      <form
        onSubmit={handleSubmit}
        style={{
          display: "grid",
          gap: "10px",
          maxWidth: "500px",
          marginBottom: "30px",
        }}
      >
        <input
          name="name"
          placeholder="Название услуги"
          value={form.name}
          onChange={handleChange}
          required
        />

        <textarea
          name="description"
          placeholder="Описание"
          value={form.description}
          onChange={handleChange}
          rows={3}
        />

        <input
          name="price"
          type="number"
          min="0"
          step="0.01"
          placeholder="Цена"
          value={form.price}
          onChange={handleChange}
          required
        />

        <input
          name="duration_minutes"
          type="number"
          min="0"
          placeholder="Длительность, минут"
          value={form.duration_minutes}
          onChange={handleChange}
          required
        />

        <button type="submit">
          {editingId ? "Сохранить изменения" : "Добавить услугу"}
        </button>

        {editingId && (
          <button type="button" onClick={resetForm}>
            Отмена
          </button>
        )}
      </form>

      {loading ? (
        <p>Загрузка...</p>
      ) : services.length === 0 ? (
        <p>Услуги пока не добавлены.</p>
      ) : (
        <table border="1" cellPadding="8">
          <thead>
            <tr>
              <th>Название</th>
              <th>Описание</th>
              <th>Цена</th>
              <th>Длительность</th>
              <th>Действия</th>
            </tr>
          </thead>
          <tbody>
            {services.map((service) => (
              <tr key={service.id}>
                <td>{service.name}</td>
                <td>{service.description}</td>
                <td>{service.price}</td>
                <td>{service.duration_minutes} мин.</td>
                <td>
                  <button onClick={() => handleEdit(service)}>
                    Изменить
                  </button>{" "}
                  <button onClick={() => handleDelete(service.id)}>
                    Удалить
                  </button>
                </td>
              </tr>
            ))}
          </tbody>
        </table>
      )}
    </div>
  );
}