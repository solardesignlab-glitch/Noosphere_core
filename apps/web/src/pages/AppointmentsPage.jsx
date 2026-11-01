import { useEffect, useMemo, useState } from "react";
import axios from "axios";

const API_URL = "http://localhost:4000/api/appointments";
const CLIENTS_URL = "http://localhost:4000/api/clients";
const MASTERS_URL = "http://localhost:4000/api/masters";
const SERVICES_URL = "http://localhost:4000/api/services";

const STATUS_OPTIONS = [
  { value: "scheduled", label: "Запланирована" },
  { value: "completed", label: "Завершена" },
  { value: "cancelled", label: "Отменена" },
  { value: "no_show", label: "Не пришёл" },
];

const STATUS_LABELS = {
  scheduled: "Запланирована",
  completed: "Завершена",
  cancelled: "Отменена",
  no_show: "Не пришёл",
};

function getToken() {
  return localStorage.getItem("atmosfera_token");
}

function authHeaders() {
  return {
    Authorization: `Bearer ${getToken()}`,
  };
}

function toDatetimeLocal(value) {
  if (!value) return "";
  const date = new Date(value);
  const offset = date.getTimezoneOffset();
  return new Date(date.getTime() - offset * 60000).toISOString().slice(0, 16);
}

function formatInterval(start, end) {
  const startDate = new Date(start);
  const endDate = new Date(end);

  return `${startDate.toLocaleString("ru-RU", {
    day: "2-digit",
    month: "2-digit",
    hour: "2-digit",
    minute: "2-digit",
  })} – ${endDate.toLocaleTimeString("ru-RU", {
    hour: "2-digit",
    minute: "2-digit",
  })}`;
}

export default function AppointmentsPage() {
  const [appointments, setAppointments] = useState([]);
  const [clients, setClients] = useState([]);
  const [masters, setMasters] = useState([]);
  const [services, setServices] = useState([]);

  const [statusFilter, setStatusFilter] = useState("all");
  const [search, setSearch] = useState("");
  const [isFormOpen, setIsFormOpen] = useState(false);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState("");

  const [editingId, setEditingId] = useState(null);

  const [form, setForm] = useState({
    client_id: "",
    master_id: "",
    service_id: "",
    starts_at: "",
    ends_at: "",
    status: "scheduled",
    notes: "",
  });

  const loadAll = async () => {
    try {
      setLoading(true);
      setError("");

      const [appointmentsRes, clientsRes, mastersRes, servicesRes] =
        await Promise.all([
          axios.get(API_URL, { headers: authHeaders() }),
          axios.get(CLIENTS_URL, { headers: authHeaders() }),
          axios.get(MASTERS_URL, { headers: authHeaders() }),
          axios.get(SERVICES_URL, { headers: authHeaders() }),
        ]);

      setAppointments(appointmentsRes.data.appointments || []);
      setClients(
        Array.isArray(clientsRes.data)
          ? clientsRes.data
          : clientsRes.data.clients || []
      );
      setMasters(
        Array.isArray(mastersRes.data)
          ? mastersRes.data
          : mastersRes.data.masters || []
      );
      setServices(
        Array.isArray(servicesRes.data)
          ? servicesRes.data
          : servicesRes.data.services || []
      );
    } catch (err) {
      setError(
        err.response?.data?.message ||
          err.response?.data?.detail ||
          "Не удалось загрузить записи"
      );
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    loadAll();
  }, []);

  const filteredAppointments = useMemo(() => {
    const searchText = search.trim().toLowerCase();

    return appointments.filter((item) => {
      const matchesStatus =
        statusFilter === "all" || item.status === statusFilter;

      const matchesSearch =
        !searchText ||
        (item.client_name || "").toLowerCase().includes(searchText) ||
        (item.master_name || "").toLowerCase().includes(searchText) ||
        (item.service_name || "").toLowerCase().includes(searchText);

      return matchesStatus && matchesSearch;
    });
  }, [appointments, statusFilter, search]);

  function handleFormChange(event) {
    const { name, value } = event.target;

    setForm((prev) => ({
      ...prev,
      [name]: value,
    }));
  }

  function resetForm() {
    setForm({
      client_id: "",
      master_id: "",
      service_id: "",
      starts_at: "",
      ends_at: "",
      status: "scheduled",
      notes: "",
    });
    setEditingId(null);
  }

  async function handleSubmit(event) {
    event.preventDefault();
    setError("");

    if (
      !form.client_id ||
      !form.master_id ||
      !form.service_id ||
      !form.starts_at ||
      !form.ends_at
    ) {
      setError("Заполните все обязательные поля");
      return;
    }

    try {
      const payload = {
        client_id: form.client_id,
        master_id: form.master_id,
        service_id: form.service_id,
        starts_at: form.starts_at,
        ends_at: form.ends_at,
        status: form.status,
        notes: form.notes,
      };

      if (editingId) {
        await axios.put(`${API_URL}/${editingId}`, payload, {
          headers: authHeaders(),
        });
      } else {
        await axios.post(API_URL, payload, {
          headers: authHeaders(),
        });
      }

      resetForm();
      setIsFormOpen(false);
      await loadAll();
    } catch (err) {
      setError(
        err.response?.data?.message ||
          err.response?.data?.detail ||
          "Не удалось сохранить запись"
      );
    }
  }

  function handleEdit(appointment) {
    setEditingId(appointment.id);
    setForm({
      client_id: appointment.client_id || "",
      master_id: appointment.master_id || "",
      service_id: appointment.service_id || "",
      starts_at: toDatetimeLocal(appointment.starts_at),
      ends_at: toDatetimeLocal(appointment.ends_at),
      status: appointment.status || "scheduled",
      notes: appointment.notes || "",
    });
    setIsFormOpen(true);
  }

  async function handleDelete(id) {
    if (!window.confirm("Удалить запись?")) return;

    try {
      await axios.delete(`${API_URL}/${id}`, {
        headers: authHeaders(),
      });

      await loadAll();
    } catch (err) {
      setError(
        err.response?.data?.message ||
          err.response?.data?.detail ||
          "Не удалось удалить запись"
      );
    }
  }

  async function handleChangeStatus(id, status) {
    try {
      const appointment = appointments.find((item) => item.id === id);

      if (!appointment) return;

      await axios.put(
        `${API_URL}/${id}`,
        {
          client_id: appointment.client_id,
          master_id: appointment.master_id,
          service_id: appointment.service_id,
          starts_at: appointment.starts_at,
          ends_at: appointment.ends_at,
          status,
          notes: appointment.notes,
        },
        { headers: authHeaders() }
      );

      await loadAll();
    } catch (err) {
      setError(
        err.response?.data?.message ||
          err.response?.data?.detail ||
          "Не удалось изменить статус"
      );
    }
  }

  return (
    <div className="appointments">
      <div className="page-header">
        <div>
          <h1>Записи</h1>
          <p>Управляйте записями клиентов, мастеров и услугами</p>
        </div>

        <button
          type="button"
          className="button button--primary"
          onClick={() => {
            if (isFormOpen) {
              resetForm();
            }

            setIsFormOpen((prev) => !prev);
          }}
        >
          {isFormOpen ? "Закрыть форму" : "Создать запись"}
        </button>
      </div>

      {error && <div className="form-error">{error}</div>}

      {isFormOpen && (
        <form className="card appointment-form" onSubmit={handleSubmit}>
          <h2>{editingId ? "Редактирование записи" : "Новая запись"}</h2>

          <div className="form-grid">
            <label>
              <span>Клиент</span>
              <select
                name="client_id"
                value={form.client_id}
                onChange={handleFormChange}
                required
              >
                <option value="">Выберите клиента</option>
                {clients.map((client) => (
                  <option key={client.id} value={client.id}>
                    {client.name}
                  </option>
                ))}
              </select>
            </label>

            <label>
              <span>Мастер</span>
              <select
                name="master_id"
                value={form.master_id}
                onChange={handleFormChange}
                required
              >
                <option value="">Выберите мастера</option>
                {masters.map((master) => (
                  <option key={master.id} value={master.id}>
                    {master.name}
                  </option>
                ))}
              </select>
            </label>

            <label>
              <span>Услуга</span>
              <select
                name="service_id"
                value={form.service_id}
                onChange={handleFormChange}
                required
              >
                <option value="">Выберите услугу</option>
                {services.map((service) => (
                  <option key={service.id} value={service.id}>
                    {service.name}
                  </option>
                ))}
              </select>
            </label>

            <label>
              <span>Начало</span>
              <input
                type="datetime-local"
                name="starts_at"
                value={form.starts_at}
                onChange={handleFormChange}
                required
              />
            </label>

            <label>
              <span>Окончание</span>
              <input
                type="datetime-local"
                name="ends_at"
                value={form.ends_at}
                onChange={handleFormChange}
                required
              />
            </label>

            <label>
              <span>Статус</span>
              <select
                name="status"
                value={form.status}
                onChange={handleFormChange}
              >
                {STATUS_OPTIONS.map((item) => (
                  <option key={item.value} value={item.value}>
                    {item.label}
                  </option>
                ))}
              </select>
            </label>

            <label>
              <span>Комментарий</span>
              <input
                name="notes"
                value={form.notes}
                onChange={handleFormChange}
                placeholder="Необязательно"
              />
            </label>
          </div>

          <button type="submit" className="button button--primary">
            {editingId ? "Сохранить изменения" : "Сохранить запись"}
          </button>
        </form>
      )}

      <div className="card appointments-toolbar">
        <input
          className="search-input"
          value={search}
          onChange={(event) => setSearch(event.target.value)}
          placeholder="Поиск по клиенту, мастеру или услуге"
        />

        <select
          value={statusFilter}
          onChange={(event) => setStatusFilter(event.target.value)}
        >
          <option value="all">Все статусы</option>
          {STATUS_OPTIONS.map((item) => (
            <option key={item.value} value={item.value}>
              {item.label}
            </option>
          ))}
        </select>
      </div>

      <div className="appointments-list">
        {loading ? (
          <div className="card empty-state">
            <h2>Загрузка...</h2>
          </div>
        ) : filteredAppointments.length === 0 ? (
          <div className="card empty-state">
            <h2>Записей пока нет</h2>
            <p>Создайте первую запись, чтобы начать работу.</p>
          </div>
        ) : (
          filteredAppointments.map((item) => (
            <article key={item.id} className="card appointment-card">
              <div className="appointment-main">
                <h3>{item.client_name}</h3>
                <p>
                  {item.service_name} • {item.master_name}
                </p>
                <p className="appointment-time">
                  {formatInterval(item.starts_at, item.ends_at)}
                </p>
              </div>

              <div className="appointment-side">
                <span className={`status status--${item.status}`}>
                  {STATUS_LABELS[item.status] || item.status}
                </span>

                <select
                  value={item.status}
                  onChange={(event) =>
                    handleChangeStatus(item.id, event.target.value)
                  }
                >
                  {STATUS_OPTIONS.map((option) => (
                    <option key={option.value} value={option.value}>
                      {option.label}
                    </option>
                  ))}
                </select>

                <button type="button" onClick={() => handleEdit(item)}>
                  Изменить
                </button>

                <button type="button" onClick={() => handleDelete(item.id)}>
                  Удалить
                </button>
              </div>
            </article>
          ))
        )}
      </div>
    </div>
  );
}