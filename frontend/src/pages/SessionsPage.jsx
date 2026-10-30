import { useEffect, useState } from "react";
import {
  getUpcomingSessions,
  formatDateTime,
  getStatusClass,
  getStatusLabel
} from "../api/espocrm";

export default function SessionsPage() {
  const [sessions, setSessions] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);

  useEffect(() => {
    let active = true;

    async function loadSessions() {
      try {
        setLoading(true);
        setError(null);

        const data = await getUpcomingSessions(20);
        const list = data.list || [];

        if (active) {
          setSessions(list);
        }
      } catch (err) {
        if (active) {
          setError(err.message);
        }
      } finally {
        if (active) {
          setLoading(false);
        }
      }
    }

    loadSessions();

    return () => {
      active = false;
    };
  }, []);

  return (
    <div>
      <div className="page__header">
        <div>
          <h1>Записи</h1>
          <p>Ближайшие занятия и их текущий статус</p>
        </div>

        <button className="button button--primary" type="button">
          Новая запись
        </button>
      </div>

      {loading && (
        <div className="state-card">
          <div className="spinner" />
          <p>Загружаем расписание…</p>
        </div>
      )}

      {!loading && error && (
        <div className="state-card state-card--error">
          <span className="state-card__icon">⚠️</span>
          <h2>Не удалось получить данные</h2>
          <p>{error}</p>

          <button
            className="button button--small"
            type="button"
            onClick={() => window.location.reload()}
          >
            Повторить
          </button>
        </div>
      )}

      {!loading && !error && sessions.length === 0 && (
        <div className="state-card">
          <span className="state-card__icon">📅</span>
          <h2>Ближайших занятий нет</h2>
          <p>
            Создайте запись в EspoCRM с датой в будущем — она появится здесь.
          </p>
        </div>
      )}

      {!loading && !error && sessions.length > 0 && (
        <div className="sessions-grid">
          {sessions.map((session) => (
            <article className="session-card" key={session.id}>
              <div className="session-card__top">
                <span className={`status ${getStatusClass(session.status)}`}>
                  {getStatusLabel(session.status)}
                </span>

                <span className="session-card__date">
                  {formatDateTime(session.startAt)}
                </span>
              </div>

              <h3>{session.name || "Занятие"}</h3>

              <div className="session-card__meta">
                <span>
                  <strong>Специалист:</strong>{" "}
                  {session.specialistName || "Не указан"}
                </span>

                <span>
                  <strong>Окончание:</strong>{" "}
                  {formatDateTime(session.endAt)}
                </span>
              </div>

              <button
                className="button button--ghost button--small"
                type="button"
              >
                Открыть карточку
              </button>
            </article>
          ))}
        </div>
      )}
    </div>
  );
}