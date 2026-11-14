import { useEffect, useState } from "react";

const API_BASE = "http://localhost:4000";
const APPOINTMENTS_URL = `${API_BASE}/api/appointments`;

function getToken() {
  return localStorage.getItem("atmosfera_token");
}

const AI_QUESTIONS = [
  "Какие записи сегодня требуют подтверждения?",
  "Есть ли свободные окна у мастеров?",
  "Покажи ближайшие записи."
];

const STATUS_LABELS = {
  scheduled: "Запланирована",
  confirmed: "Подтверждена",
  completed: "Завершена",
  cancelled: "Отменена",
  no_show: "Не пришёл"
};

export default function DashboardPage() {
  const [appointments, setAppointments] = useState([]);
  const [dashboardLoading, setDashboardLoading] = useState(true);
  const [dashboardError, setDashboardError] = useState("");

  const [selectedAppointment, setSelectedAppointment] = useState(null);
  const [aiAnswer, setAiAnswer] = useState("");
  const [aiLoading, setAiLoading] = useState(false);
  const [aiError, setAiError] = useState("");

  useEffect(() => {
    const loadAppointments = async () => {
      try {
        setDashboardLoading(true);
        setDashboardError("");

   const response = await fetch(APPOINTMENTS_URL, {
     headers: {
      Authorization: `Bearer ${getToken()}`
          }
        });

        const data = await response.json();

        if (!response.ok) {
          throw new Error(data.message || "Не удалось загрузить записи");
        }

        setAppointments(
          Array.isArray(data.appointments) ? data.appointments : []
        );
      } catch (error) {
        setDashboardError(error.message);
      } finally {
        setDashboardLoading(false);
      }
    };

    loadAppointments();
  }, []);

  const today = new Date().toDateString();

  const todayAppointments = appointments.filter(
    (appointment) =>
      new Date(appointment.starts_at).toDateString() === today
  );

  const pendingAppointments = appointments.filter(
    (appointment) => appointment.status === "scheduled"
  );

  const completedTodayAppointments = todayAppointments.filter(
    (appointment) => appointment.status === "completed"
  );

  const upcomingAppointments = appointments
    .filter((appointment) => new Date(appointment.starts_at) >= new Date())
    .sort(
      (a, b) => new Date(a.starts_at) - new Date(b.starts_at)
    )
    .slice(0, 5);

  const schedule =
    upcomingAppointments.length > 0
      ? upcomingAppointments
      : [...appointments]
          .sort(
            (a, b) => new Date(b.starts_at) - new Date(a.starts_at)
          )
          .slice(0, 5);

  const kpis = [
    {
      id: "appointments",
      label: "Записей сегодня",
      value: String(todayAppointments.length),
      hint: "По текущей дате",
      trend: "Реальные данные",
      accent: "blue"
    },
    {
      id: "pending",
      label: "Ожидают подтверждения",
      value: String(pendingAppointments.length),
      hint: "Статус: запланирована",
      trend:
        pendingAppointments.length > 0
          ? "Требуют действия"
          : "Всё подтверждено",
      accent: "yellow"
    },
    {
      id: "completed",
      label: "Завершено сегодня",
      value: String(completedTodayAppointments.length),
      hint: "По завершённым записям",
      trend: "Реальные данные",
      accent: "green"
    },
    {
      id: "total",
      label: "Всего записей",
      value: String(appointments.length),
      hint: "Во всей системе",
      trend: "Реальные данные",
      accent: "purple"
    }
  ];

  const attention = pendingAppointments.slice(0, 3).map((appointment) => ({
    id: appointment.id,
    title: `Запись ${appointment.client_name || "клиента"} ожидает подтверждения`,
    description: `${appointment.service_name || "Услуга не указана"} · ${
      appointment.master_name || "Мастер не указан"
    } · ${new Date(appointment.starts_at).toLocaleString("ru-RU")}`,
    action: "Открыть"
  }));

  const askAi = async (question) => {
    setAiLoading(true);
    setAiError("");
    setAiAnswer("");

    try {
      const response = await fetch(`${API_BASE}/api/ai/chat`, {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
          Authorization: `Bearer ${getToken()}`
        },
        body: JSON.stringify({
          message: question,
          history: []
        })
      });

      const data = await response.json();

      if (!response.ok) {
        throw new Error(data.detail || "AI не ответил");
      }

      setAiAnswer(data.reply);
    } catch (error) {
      setAiError(error.message);
    } finally {
      setAiLoading(false);
    }
  };

  return (
    <section className="page">
      <header className="page__header">
        <div>
          <h1>Добрый день</h1>
          <p>
            Обзор салона на {new Date().toLocaleDateString("ru-RU")}
          </p>
        </div>

        <button className="button button--primary">+ Новая запись</button>
      </header>

      {dashboardError && (
        <div className="card">
          <p>{dashboardError}</p>
        </div>
      )}

      <div className="kpi-grid">
        {kpis.map((item) => (
          <article
            key={item.id}
            className={`kpi-card kpi-card--${item.accent}`}
          >
            <div className="kpi-card__top">
              <span>{item.label}</span>
              <span className="kpi-card__trend">{item.trend}</span>
            </div>

            <div className="kpi-card__value">{item.value}</div>
            <div className="kpi-card__hint">{item.hint}</div>
          </article>
        ))}
      </div>

      <div className="dashboard-grid">
        <section className="card schedule">
          <div className="card__header">
            <div>
              <h2>Ближайшие записи</h2>
              <p>Реальные данные из системы</p>
            </div>

            <button className="button button--ghost">Все записи</button>
          </div>

          <div className="schedule__list">
            {dashboardLoading && <p>Загрузка записей…</p>}

            {!dashboardLoading && !dashboardError && schedule.length === 0 && (
              <p>Записей пока нет.</p>
            )}

            {!dashboardLoading &&
              !dashboardError &&
              schedule.map((appointment) => (
                <button
                  key={appointment.id}
                  className={
                    "schedule__row" +
                    (selectedAppointment === appointment.id
                      ? " schedule__row--active"
                      : "")
                  }
                  onClick={() =>
                    setSelectedAppointment(
                      selectedAppointment === appointment.id
                        ? null
                        : appointment.id
                    )
                  }
                >
                  <div className="schedule__time">
                    {new Date(appointment.starts_at).toLocaleString("ru-RU", {
                      day: "2-digit",
                      month: "2-digit",
                      hour: "2-digit",
                      minute: "2-digit"
                    })}
                  </div>

                  <div className="schedule__info">
                    <strong>
                      {appointment.client_name || "Клиент не указан"}
                    </strong>

                    <span>
                      {appointment.master_name || "Мастер не указан"} ·{" "}
                      {appointment.service_name || "Услуга не указана"}
                    </span>
                  </div>

                  <span
                    className={`status status--${appointment.status}`}
                  >
                    {STATUS_LABELS[appointment.status] ||
                      appointment.status}
                  </span>
                </button>
              ))}
          </div>
        </section>

        <div className="dashboard-side">
          <section className="card">
            <div className="card__header">
              <div>
                <h2>Требуют внимания</h2>
                <p>{pendingAppointments.length} задач</p>
              </div>
            </div>

            <div className="attention__list">
              {dashboardLoading && <p>Загрузка…</p>}

              {!dashboardLoading && attention.length === 0 && (
                <p>Нет записей, требующих внимания.</p>
              )}

              {attention.map((item) => (
                <div key={item.id} className="attention__item">
                  <div>
                    <strong>{item.title}</strong>
                    <span>{item.description}</span>
                  </div>

                  <button
                    className="button button--small"
                    onClick={() => setSelectedAppointment(item.id)}
                  >
                    {item.action}
                  </button>
                </div>
              ))}
            </div>
          </section>

          <section className="card ai-panel">
            <div className="card__header">
              <div>
                <h2>AI-подсказки</h2>
                <p>Модель: qwen2.5:7b</p>
              </div>

              <span className="status status--confirmed">Активна</span>
            </div>

            <div className="ai-panel__list">
              {AI_QUESTIONS.map((question) => (
                <button
                  key={question}
                  className="ai-panel__question"
                  onClick={() => askAi(question)}
                  disabled={aiLoading}
                >
                  {question}
                </button>
              ))}
            </div>

            {aiLoading && (
              <div className="ai-answer">AI думает...</div>
            )}

            {aiError && (
              <div className="ai-answer ai-answer--error">{aiError}</div>
            )}

            {aiAnswer && <div className="ai-answer">{aiAnswer}</div>}
          </section>
        </div>
      </div>
    </section>
  );
}