import { useEffect, useMemo, useState } from "react";
import {
  getUpcomingSessions,
  calculateDayMetrics,
  updateSessionStatus,
  formatDateTime,
  getStatusClass,
  getStatusLabel
} from "../api/espocrm";
import AgentPanel from "../components/AgentPanel";
import SessionDrawer from "../components/SessionDrawer";

function dayKey(value) {
  const date = new Date(value);

  return `${date.getFullYear()}-${String(date.getMonth() + 1).padStart(2, "0")}-${String(
    date.getDate()
  ).padStart(2, "0")}`;
}

function dayTitle(value) {
  const date = new Date(value);
  const today = new Date();
  const tomorrow = new Date();

  tomorrow.setDate(today.getDate() + 1);

  if (dayKey(date) === dayKey(today)) return "Сегодня";
  if (dayKey(date) === dayKey(tomorrow)) return "Завтра";

  return date.toLocaleDateString("ru-RU", {
    day: "numeric",
    month: "long",
    weekday: "long"
  });
}

function nextAction(status) {
  if (status === "new") {
    return { value: "confirmed", label: "Подтвердить" };
  }

  if (status === "confirmed") {
    return { value: "in_progress", label: "Начать визит" };
  }

  if (status === "in_progress") {
    return { value: "completed", label: "Завершить" };
  }

  return null;
}

export default function SessionsPage() {
  const [sessions, setSessions] = useState([]);
  const [metrics, setMetrics] = useState(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);
  const [selectedId, setSelectedId] = useState(null);
  const [agentOpen, setAgentOpen] = useState(false);
  const [busyId, setBusyId] = useState(null);
  const [toast, setToast] = useState(null);

  async function loadSessions() {
    try {
      setLoading(true);
      setError(null);

      const data = await getUpcomingSessions(50);
      const list = data.list || [];

      setSessions(list);
      setMetrics(calculateDayMetrics(list));
    } catch (err) {
      setError(err.message);
    } finally {
      setLoading(false);
    }
  }

  useEffect(() => {
    loadSessions();
  }, []);

  useEffect(() => {
    if (!toast) return;

    const timer = setTimeout(() => setToast(null), 3200);

    return () => clearTimeout(timer);
  }, [toast]);

  const groupedSessions = useMemo(() => {
    const groups = new Map();

    [...sessions]
      .sort((a, b) => new Date(a.startAt) - new Date(b.startAt))
      .forEach((session) => {
        const key = dayKey(session.startAt);

        if (!groups.has(key)) {
          groups.set(key, {
            title: dayTitle(session.startAt),
            items: []
          });
        }

        groups.get(key).items.push(session);
      });

    return [...groups.values()];
  }, [sessions]);

  const nextSession = sessions[0];

  async function quickChangeStatus(session, status) {
    try {
      setBusyId(session.id);

      await updateSessionStatus(session.id, status);

      setToast({
        type: "success",
        text: `Статус обновлён: ${getStatusLabel(status)}`
      });

      await loadSessions();
    } catch (err) {
      setToast({
        type: "error",
        text: err.message
      });
    } finally {
      setBusyId(null);
    }
  }

  return (
    <div>
      <div className="page__header">
        <div>
          <h1>Записи</h1>
          <p>Ближайшие занятия, статусы и метрики дня</p>
        </div>

        <div className="page__header-actions">
          <button
            className="button"
            type="button"
            onClick={() => setAgentOpen(true)}
          >
            AI-анализ
          </button>

          <button className="button button--primary" type="button">
            Новая запись
          </button>
        </div>
      </div>

      {metrics && (
        <div className="kpi-grid">
          <div className="kpi-card kpi-card--blue">
            <div className="kpi-card__top">
              <span>Всего записей</span>
            </div>

            <div className="kpi-card__value">{metrics.total}</div>
            <div className="kpi-card__hint">Ближайший период</div>
          </div>

          <div className="kpi-card kpi-card--yellow">
            <div className="kpi-card__top">
              <span>Ожидают подтверждения</span>
            </div>

            <div className="kpi-card__value">{metrics.pending}</div>
            <div className="kpi-card__hint">Статус: новая</div>
          </div>

          <div className="kpi-card kpi-card--green">
            <div className="kpi-card__top">
              <span>Подтверждено</span>
            </div>

            <div className="kpi-card__value">{metrics.confirmed}</div>
            <div className="kpi-card__hint">Включая идущие визиты</div>
          </div>

          <div className="kpi-card kpi-card--purple">
            <div className="kpi-card__top">
              <span>Конверсия в визит</span>
            </div>

            <div className="kpi-card__value">{metrics.conversion}%</div>

            <div className="kpi-progress">
              <span
                className="kpi-progress__bar"
                style={{ width: `${metrics.conversion}%` }}
              />
            </div>
          </div>

          <div className="kpi-card kpi-card--green">
            <div className="kpi-card__top">
              <span>Завершено</span>
            </div>

            <div className="kpi-card__value">{metrics.completed}</div>
            <div className="kpi-card__hint">Успешно проведённые визиты</div>
          </div>

          <div className="kpi-card kpi-card--red">
            <div className="kpi-card__top">
              <span>Отмены и неявки</span>
            </div>

            <div className="kpi-card__value">{metrics.cancelled}</div>
            <div className="kpi-card__hint">
              Не пришли: {metrics.noShow}
            </div>
          </div>

          <div className="kpi-card kpi-card--blue kpi-card--wide">
            <div className="kpi-card__top">
              <span>Ближайшая запись</span>
            </div>

            {nextSession ? (
              <>
                <div className="kpi-card__value kpi-card__value--small">
                  {formatDateTime(nextSession.startAt)}
                </div>

                <div className="kpi-card__hint">
                  {nextSession.name || "Занятие"} ·{" "}
                  {nextSession.specialistName || "Специалист не указан"}
                </div>
              </>
            ) : (
              <div className="kpi-card__hint">Записей пока нет</div>
            )}
          </div>
        </div>
      )}

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
            onClick={loadSessions}
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

          <button className="button button--primary" type="button">
            Новая запись
          </button>
        </div>
      )}

      {!loading && !error && groupedSessions.map((group) => (
        <section className="day-group" key={group.title}>
          <div className="day-group__header">
            <h2>{group.title}</h2>
            <span>{group.items.length} записей</span>
          </div>

          <div className="sessions-grid">
            {group.items.map((session) => {
              const action = nextAction(session.status);

              return (
                <article
                  className={`session-card ${
                    nextSession?.id === session.id ? "session-card--next" : ""
                  }`}
                  key={session.id}
                >
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

                  <div className="session-card__actions">
                    {action && (
                      <button
                        className="button button--primary button--small"
                        type="button"
                        disabled={busyId === session.id}
                        onClick={() =>
                          quickChangeStatus(session, action.value)
                        }
                      >
                        {busyId === session.id ? "Сохраняем…" : action.label}
                      </button>
                    )}

                    <button
                      className="button button--ghost button--small"
                      type="button"
                      onClick={() => setSelectedId(session.id)}
                    >
                      Открыть карточку
                    </button>
                  </div>
                </article>
              );
            })}
          </div>
        </section>
      ))}

      {selectedId && (
        <SessionDrawer
          sessionId={selectedId}
          onClose={() => setSelectedId(null)}
          onChanged={loadSessions}
        />
      )}

      {agentOpen && (
        <AgentPanel onClose={() => setAgentOpen(false)} />
      )}

      {toast && (
        <div className={`toast toast--${toast.type}`}>
          {toast.text}
        </div>
      )}
    </div>
  );
}