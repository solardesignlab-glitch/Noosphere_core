import { useMemo, useState } from "react";

const STATUS_OPTIONS = [
  { value: "new", label: "Новая" },
  { value: "confirmed", label: "Подтверждена" },
  { value: "completed", label: "Завершена" },
  { value: "cancelled", label: "Отменена" }
];

const STATUS_LABELS = {
  new: "Новая",
  confirmed: "Подтверждена",
  completed: "Завершена",
  cancelled: "Отменена"
};

export default function AppointmentsPage() {
  const [appointments, setAppointments] = useState([]);
  const [statusFilter, setStatusFilter] = useState("all");
  const [search, setSearch] = useState("");
  const [isFormOpen, setIsFormOpen] = useState(false);
  const [error, setError] = useState("");

  const [form, setForm] = useState({
    clientName: "",
    masterName: "",
    serviceName: "",
    date: "",
    time: "",
    status: "new"
  });

  const filteredAppointments = useMemo(() => {
    return appointments.filter((item) => {
      const matchesStatus =
        statusFilter === "all" || item.status === statusFilter;

      const searchText = search.trim().toLowerCase();

      const matchesSearch =
        !searchText ||
        item.clientName.toLowerCase().includes(searchText) ||
        item.masterName.toLowerCase().includes(searchText) ||
        item.serviceName.toLowerCase().includes(searchText);

      return matchesStatus && matchesSearch;
    });
  }, [appointments, statusFilter, search]);

  function handleFormChange(event) {
    const { name, value } = event.target;

    setForm((prev) => ({
      ...prev,
      [name]: value
    }));
  }

  function handleCreate(event) {
    event.preventDefault();
    setError("");

    if (
      !form.clientName ||
      !form.masterName ||
      !form.serviceName ||
      !form.date ||
      !form.time
    ) {
      setError("Заполните все обязательные поля");
      return;
    }

    const newAppointment = {
      id: crypto.randomUUID(),
      ...form
    };

    setAppointments((prev) => [newAppointment, ...prev]);

    setForm({
      clientName: "",
      masterName: "",
      serviceName: "",
      date: "",
      time: "",
      status: "new"
    });

    setIsFormOpen(false);
  }

  function handleChangeStatus(id, status) {
    setAppointments((prev) =>
      prev.map((item) => (item.id === id ? { ...item, status } : item))
    );
  }

  return (
    <div className="appointments">
      <div className="page-header">
        <div>
          <h1>Записи</h1>
          <p>Управляйте записями клиентов, мастерами и услугами</p>
        </div>

        <button
          type="button"
          className="button button--primary"
          onClick={() => setIsFormOpen((prev) => !prev)}
        >
          {isFormOpen ? "Закрыть форму" : "Создать запись"}
        </button>
      </div>

      {isFormOpen && (
        <form className="card appointment-form" onSubmit={handleCreate}>
          <h2>Новая запись</h2>

          <div className="form-grid">
            <label>
              <span>Клиент</span>
              <input
                name="clientName"
                value={form.clientName}
                onChange={handleFormChange}
                placeholder="Имя клиента"
                required
              />
            </label>

            <label>
              <span>Мастер</span>
              <input
                name="masterName"
                value={form.masterName}
                onChange={handleFormChange}
                placeholder="Имя мастера"
                required
              />
            </label>

            <label>
              <span>Услуга</span>
              <input
                name="serviceName"
                value={form.serviceName}
                onChange={handleFormChange}
                placeholder="Название услуги"
                required
              />
            </label>

            <label>
              <span>Дата</span>
              <input
                type="date"
                name="date"
                value={form.date}
                onChange={handleFormChange}
                required
              />
            </label>

            <label>
              <span>Время</span>
              <input
                type="time"
                name="time"
                value={form.time}
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
          </div>

          {error && <div className="form-error">{error}</div>}

          <button type="submit" className="button button--primary">
            Сохранить запись
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
        {filteredAppointments.length === 0 ? (
          <div className="card empty-state">
            <h2>Записей пока нет</h2>
            <p>Создайте первую запись, чтобы начать работу.</p>
          </div>
        ) : (
          filteredAppointments.map((item) => (
            <article key={item.id} className="card appointment-card">
              <div className="appointment-main">
                <h3>{item.clientName}</h3>
                <p>
                  {item.serviceName} • {item.masterName}
                </p>
                <p className="appointment-time">
                  {item.date} в {item.time}
                </p>
              </div>

              <div className="appointment-side">
                <span className={`status status--${item.status}`}>
                  {STATUS_LABELS[item.status]}
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
              </div>
            </article>
          ))
        )}
      </div>
    </div>
  );
}