import { useState } from 'react';
import './AiPanel.css';

const TASK_TYPES = [
  { id: 'chat', label: 'Общий чат' },
  { id: 'code_review', label: 'Проверка кода' },
  { id: 'specification', label: 'Спецификация' },
  { id: 'audit', label: 'Аудит' },
];

export default function AiPanel() {
  const [taskType, setTaskType] = useState('chat');
  const [message, setMessage] = useState('');
  const [context, setContext] = useState('');
  const [reply, setReply] = useState('');
  const [model, setModel] = useState('');
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState('');

  async function sendTask() {
    if (!message.trim()) {
      setError('Введите задачу.');
      return;
    }

    setLoading(true);
    setError('');
    setReply('');
    setModel('');

    try {
      const response = await fetch('/api/ai/task', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({
          taskType,
          message,
          context,
        }),
      });

      const data = await response.json();

      if (!response.ok) {
        throw new Error(data.detail || 'AI-сервис вернул ошибку.');
      }

      setReply(data.reply);
      setModel(data.model);
    } catch (err) {
      setError(err.message);
    } finally {
      setLoading(false);
    }
  }

  return (
    <section className="page">
      <div className="card ai-panel">
        <div className="card-head">
          <h2>AI-помощник</h2>
          {model && <span className="ai-model">{model}</span>}
        </div>

        <label className="ai-label">
          Тип задачи
          <select
            className="ai-select"
            value={taskType}
            onChange={(event) => setTaskType(event.target.value)}
          >
            {TASK_TYPES.map((item) => (
              <option key={item.id} value={item.id}>
                {item.label}
              </option>
            ))}
          </select>
        </label>

        <label className="ai-label">
          Задача
          <textarea
            className="ai-textarea"
            rows={4}
            value={message}
            onChange={(event) => setMessage(event.target.value)}
            placeholder="Например: проверь риски текущей архитектуры AI-роутера"
          />
        </label>

        <label className="ai-label">
          Контекст
          <textarea
            className="ai-textarea"
            rows={3}
            value={context}
            onChange={(event) => setContext(event.target.value)}
            placeholder="Необязательно: проект, файл, ограничения, данные"
          />
        </label>

        <button
          className="primary-button"
          onClick={sendTask}
          disabled={loading}
        >
          {loading ? 'AI думает…' : 'Отправить в AI'}
        </button>

        {error && <div className="ai-error">{error}</div>}

        {reply && (
          <div className="ai-reply">
            <h3>Ответ модели</h3>
            <pre>{reply}</pre>
          </div>
        )}
      </div>
    </section>
  );
}