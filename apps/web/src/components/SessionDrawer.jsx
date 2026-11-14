import { useEffect, useState } from "react";
import {
  getSession,
  updateSessionStatus,
  formatDateTime,
  getStatusClass,
  getStatusLabel
} from "../api/espocrm";

const STATUS_ACTIONS = [
  { value: "confirmed", label: "Подтвердить" },
  { value: "in_progress", label: "Начать визит" },
  { value: "completed", label: "Завершить" },
  { value: "cancelled", label: "Отменить" },
  { value: "no_show", label: "Клиент не пришёл" }
];

export default function SessionDrawer({ sessionId, onClose, onChanged }) {
  const [session, setSession] = useState(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);
  const [saving, setSaving] = useState(false);

  useEffect(() => {
    let active = true;

    async function loadSession() {
      try {
        setLoading(true);
        setError(null);

        const data = await getSession(sessionId);

        if (active) {
          setSession(data);
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

    loadSession();

    return () => {
      active = false;
    };
  }, [sessionId]);

  async function changeStatus(status) {
    try {
      setSaving(true);
      setError(null);

      await updateSessionStatus(sessionId, status);

      const updated = await getSession(sessionId);

      setSession(updated);
      onChanged();
    } catch (err) {
      setError(err.message);
    } finally {
      setSaving(false);
    }
  }

  return (
    <div className="drawer-overlay" onClick={onClose}>
      <aside
        className="drawer"
        onClick={(event) => event.stopPropagation()}
      >
        <div className="drawer__header">
          <div>
            <p className="drawer__eyebrow">Карточка записи</p>
            <h2>{session?.name || "Занятие"}</h2>
          </div>

          <button
            className="button button--small"
            type="button"
            onClick={onClose}
          >
            Закрыть
          </button>
        </div>

        {loading && <p>Загружаем запись…</p>}

        {!loading && error && (
          <div className="state-card state-card--error">
            <span className="state-card__icon">⚠️</span>
            <h2>Ошибка</h2>
            <p>{error}</p>
          </div>
        )}

        {!loading && !error && session && (
          <>
            <div className="drawer__status">
              <span className={`status ${getStatusClass(session.status)}`}>
                {getStatusLabel(session.status)}
              </span>
            </div>

            <div className="drawer__fields">
              <div className="drawer__field">
                <span>Начало</span>
                <strong>{formatDateTime(session.startAt)}</strong>
              </div>

              <div className="drawer__field">
                <span>Окончание</span>
                <strong>{formatDateTime(session.endAt)}</strong>
              </div>

              <div className="drawer__field">
                <span>Специалист</span>
                <strong>{session.specialistName || "Не указан"}</strong>
              </div>

              <div className="drawer__field">
                <span>Статус</span>
                <strong>{getStatusLabel(session.status)}</strong>
              </div>
            </div>

            <div className="drawer__actions">
              {STATUS_ACTIONS.map((action) => (
                <button
                  className="button button--small"
                  key={action.value}
                  type="button"
                  disabled={saving || session.status === action.value}
                  onClick={() => changeStatus(action.value)}
                >
                  {action.label}
                </button>
              ))}
            </div>

            {saving && (
              <p className="drawer__saving">Сохраняем…</p>
            )}
          </>
        )}
      </aside>
    </div>
  );
}