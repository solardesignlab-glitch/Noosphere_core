import { useState } from "react";

const API_BASE = "http://localhost:8090";

const KPI = [
  {
    id: "appointments",
    label: "Записей сегодня",
    value: "12",
    hint: "3 подтверждены",
    trend: "+2 к вчера",
    accent: "blue"
  },
  {
    id: "pending",
    label: "Ожидают подтверждения",
    value: "4",
    hint: "Требуют действия",
    trend: "Внимание",
    accent: "yellow"
  },
  {
    id: "revenue",
    label: "Выручка за день",
    value: "38 500 ₽",
    hint: "По завершённым записям",
    trend: "+12%",
    accent: "green"
  },
  {
    id: "load",
    label: "Загрузка мастеров",
    value: "78%",
    hint: "6 из 8 мастеров заняты",
    trend: "Высокая",
    accent: "purple"
  }
];

const SCHEDULE = [
  {
    id: 1,
    time: "10:00",
    client: "Анна Смирнова",
    master: "Мария",
    service: "Стрижка + укладка",
    status: "confirmed"
  },
  {
    id: 2,
    time: "11:30",
    client: "Игорь Петров",
    master: "Алексей",
    service: "Мужская стрижка",
    status: "pending"
  },
  {
    id: 3,
    time: "13:00",
    client: "Елена Козлова",
    master: "Мария",
    service: "Окрашивание",
    status: "confirmed"
  },
  {
    id: 4,
    time: "15:00",
    client: "Дмитрий Волков",
    master: "Алексей",
    service: "Борода + стрижка",
    status: "completed"
  }
];

const ATTENTION = [
  {
    id: 1,
    title: "4 записи ожидают подтверждения",
    description: "Отправьте напоминания клиентам",
    action: "Напомнить"
  },
  {
    id: 2,
    title: "Свободное окно у мастера Марии",
    description: "14:30–15:30",
    action: "Создать запись"
  },
  {
    id: 3,
    title: "Клиент Игорь Петров не подтвердил запись",
    description: "Запись сегодня в 11:30",
    action: "Открыть"
  }
];

const AI_QUESTIONS = [
  "Какие записи сегодня требуют подтверждения?",
  "Есть ли свободные окна у мастеров?",
  "Покажи ближайшие записи."
];

const STATUS_LABELS = {
  pending: "Ожидает",
  confirmed: "Подтверждена",
  completed: "Завершена",
  cancelled: "Отменена"
};

export default function DashboardPage() {
  const [selectedAppointment, setSelectedAppointment] = useState(null);
  const [aiAnswer, setAiAnswer] = useState("");
  const [aiLoading, setAiLoading] = useState(false);
  const [aiError, setAiError] = useState("");

  const askAi = async (question) => {
    setAiLoading(true);
    setAiError("");
    setAiAnswer("");

    try {
      const response = await fetch(`${API_BASE}/api/ai/chat`, {
        method: "POST",
        headers: {
          "Content-Type": "application/json"
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
          <p>Обзор салона на сегодня, 30 октября</p>
        </div>

        <button className="button button--primary">+ Новая запись</button>
      </header>

      <div className="kpi-grid">
        {KPI.map((item) => (
          <article key={item.id} className={`kpi-card kpi-card--${item.accent}`}>
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
              <h2>Расписание на сегодня</h2>
              <p>Ближайшие записи и статусы</p>
            </div>
            <button className="button button--ghost">Все записи</button>
          </div>

          <div className="schedule__list">
            {SCHEDULE.map((item) => (
              <button
                key={item.id}
                className={
                  "schedule__row" +
                  (selectedAppointment === item.id
                    ? " schedule__row--active"
                    : "")
                }
                onClick={() =>
                  setSelectedAppointment(
                    selectedAppointment === item.id ? null : item.id
                  )
                }
              >
                <div className="schedule__time">{item.time}</div>

                <div className="schedule__info">
                  <strong>{item.client}</strong>
                  <span>
                    {item.master} · {item.service}
                  </span>
                </div>

                <span className={`status status--${item.status}`}>
                  {STATUS_LABELS[item.status]}
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
                <p>3 задачи</p>
              </div>
            </div>

            <div className="attention__list">
              {ATTENTION.map((item) => (
                <div key={item.id} className="attention__item">
                  <div>
                    <strong>{item.title}</strong>
                    <span>{item.description}</span>
                  </div>
                  <button className="button button--small">{item.action}</button>
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

            {aiLoading && <div className="ai-answer">AI думает...</div>}

            {aiError && <div className="ai-answer ai-answer--error">{aiError}</div>}

            {aiAnswer && <div className="ai-answer">{aiAnswer}</div>}
          </section>
        </div>
      </div>
    </section>
  );
}