import { useEffect, useState } from "react";
import axios from "axios";

const API_URL = "http://localhost:4000/api/masters";

function getToken() {
  return localStorage.getItem("atmosfera_token");
}

export default function MastersPage() {
  const [masters, setMasters] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState("");

  const [form, setForm] = useState({
    name: "",
    phone: "",
    email: "",
    specialty: "",
  });

  const [editingId, setEditingId] = useState(null);

  const loadMasters = async () => {
    try {
      setLoading(true);
      setError("");

      const res = await axios.get(API_URL, {
        headers: {
          Authorization: `Bearer ${getToken()}`,
        },
      });

      const data = res.data;
      setMasters(Array.isArray(data) ? data : data.masters || []);
    } catch (err) {
      setError(
        err.response?.data?.detail ||
          err.response?.data?.message ||
          "Не удалось загрузить мастеров."
      );
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    loadMasters();
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
      phone: "",
      email: "",
      specialty: "",
    });
    setEditingId(null);
  };

  const handleSubmit = async (e) => {
    e.preventDefault();

    try {
      const payload = {
        name: form.name,
        phone: form.phone || null,
        email: form.email || null,
        specialty: form.specialty || null,
        is_active: true,
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
      await loadMasters();
    } catch (err) {
      setError(
        err.response?.data?.detail ||
          err.response?.data?.message ||
          "Не удалось сохранить мастера."
      );
    }
  };

  const handleEdit = (master) => {
    setEditingId(master.id);
    setForm({
      name: master.name || "",
      phone: master.phone || "",
      email: master.email || "",
      specialty: master.specialty || "",
    });
  };

  const handleDelete = async (id) => {
    if (!window.confirm("Удалить мастера?")) return;

    try {
      await axios.delete(`${API_URL}/${id}`, {
        headers: {
          Authorization: `Bearer ${getToken()}`,
        },
      });

      await loadMasters();
    } catch (err) {
      setError(
        err.response?.data?.detail ||
          err.response?.data?.message ||
          "Не удалось удалить мастера."
      );
    }
  };

  return (
    <div style={{ padding: "20px" }}>
      <h1>Мастера</h1>

      {error && (
        <div style={{ color: "red", marginBottom: "15px" }}>
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
          placeholder="Имя мастера"
          value={form.name}
          onChange={handleChange}
          required
        />

        <input
          name="phone"
          placeholder="Телефон"
          value={form.phone}
          onChange={handleChange}
        />

        <input
          name="email"
          type="email"
          placeholder="Email"
          value={form.email}
          onChange={handleChange}
        />

        <input
          name="specialty"
          placeholder="Специализация"
          value={form.specialty}
          onChange={handleChange}
        />

        <button type="submit">
          {editingId ? "Сохранить изменения" : "Добавить мастера"}
        </button>

        {editingId && (
          <button type="button" onClick={resetForm}>
            Отмена
          </button>
        )}
      </form>

      {loading ? (
        <p>Загрузка...</p>
      ) : masters.length === 0 ? (
        <p>Мастера пока не добавлены.</p>
      ) : (
        <table border="1" cellPadding="8">
          <thead>
            <tr>
              <th>Имя</th>
              <th>Телефон</th>
              <th>Email</th>
              <th>Специализация</th>
              <th>Действия</th>
            </tr>
          </thead>
          <tbody>
            {masters.map((master) => (
              <tr key={master.id}>
                <td>{master.name}</td>
                <td>{master.phone}</td>
                <td>{master.email}</td>
                <td>{master.specialty}</td>
                <td>
                  <button onClick={() => handleEdit(master)}>
                    Изменить
                  </button>{" "}
                  <button onClick={() => handleDelete(master.id)}>
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