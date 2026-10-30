import { useEffect, useRef, useState } from "react";

const API_BASE = "http://localhost:4000";

const QUICK_QUESTIONS = [
  "Какие записи сегодня требуют подтверждения?",
  "Есть ли свободные окна у мастеров?",
  "Покажи ближайшие записи.",
  "Какие услуги чаще всего выбирают клиенты?",
  "Как улучшить загрузку мастеров?"
];

const MODELS = [
  "qwen2.5:7b",
  "qwen2.5-coder:7b",
  "qwen2.5-coder-32k:latest"
];

export default function AiAssistantPage() {
  const [messages, setMessages] = useState([
    {
      role: "assistant",
      content:
        "Здравствуйте! Я AI-помощник CRM «Атмосфера». Задайте вопрос о записях, клиентах, мастерах или расписании."
    }
  ]);
  const [input, setInput] = useState("");
  const [model, setModel] = useState("qwen2.5:7b");
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState("");

  const chatEndRef = useRef(null);

  useEffect(() => {
    chatEndRef.current?.scrollIntoView({ behavior: "smooth" });
  }, [messages, loading]);

  const sendMessage = async (text) => {
    const question = text.trim();

    if (!question || loading) {
      return;
    }

    const userMessage = { role: "user", content: question };
    const history = messages
      .filter((message) => message.role !== "system")
      .slice(-10);

    setMessages((prev) => [...prev, userMessage]);
    setInput("");
    setLoading(true);
    setError("");

    try {
      const response = await fetch(`${API_BASE}/api/ai/chat`, {
        method: "POST",
        headers: {
          "Content-Type": "application/json"
        },
        body: JSON.stringify({
          message: question,
          history
        })
      });

      const data = await response.json();

      if (!response.ok) {
        throw new Error(data.detail || "AI не ответил");
      }

      setMessages((prev) => [
        ...prev,
        {
          role: "assistant",
          content: data.reply || "Модель вернула пустой ответ."
        }
      ]);
    } catch (err) {
      setError(err.message);
    } finally {
      setLoading(false);
    }
  };

  const clearChat = () => {
    setMessages([
      {
        role: "assistant",
        content: "Диалог очищен. Чем могу помочь?"
      }
    ]);
    setError("");
  };

  return (
    <section className="page">
      <header className="page__header">
        <div>
          <h1>AI-помощник</h1>
          <p>Вопросы о записях, клиентах, мастерах и расписании</p>
        </div>

        <div className="ai-controls">
          <select
            className="ai-model-select"
            value={model}
            onChange={(event) => setModel(event.target.value)}
          >
            {MODELS.map((item) => (
              <option key={item} value={item}>
                {item}
              </option>
            ))}
          </select>

          <button className="button button--ghost" onClick={clearChat}>
            Очистить
          </button>
        </div>
      </header>

      <div className="assistant-layout">
        <section className="card assistant-chat">
          <div className="assistant-chat__messages">
            {messages.map((message, index) => (
              <div
                key={index}
                className={
                  "assistant-message " +
                  (message.role === "user"
                    ? "assistant-message--user"
                    : "assistant-message--assistant")
                }
              >
                <div className="assistant-message__role">
                  {message.role === "user" ? "Вы" : "AI-помощник"}
                </div>
                <div className="assistant-message__text">
                  {message.content}
                </div>
              </div>
            ))}

            {loading && (
              <div className="assistant-message assistant-message--assistant">
                <div className="assistant-message__role">AI-помощник</div>
                <div className="assistant-message__text">Думаю...</div>
              </div>
            )}

            <div ref={chatEndRef} />
          </div>

          {error && (
            <div className="ai-answer ai-answer--error">{error}</div>
          )}

          <form
            className="assistant-chat__form"
            onSubmit={(event) => {
              event.preventDefault();
              sendMessage(input);
            }}
          >
            <input
              value={input}
              onChange={(event) => setInput(event.target.value)}
              placeholder="Задайте вопрос AI-помощнику..."
              disabled={loading}
            />

            <button
              type="submit"
              className="button button--primary"
              disabled={loading || !input.trim()}
            >
              Отправить
            </button>
          </form>
        </section>

        <aside className="assistant-side">
          <section className="card">
            <div className="card__header">
              <div>
                <h2>Быстрые вопросы</h2>
                <p>Нажмите, чтобы отправить</p>
              </div>
            </div>

            <div className="ai-panel__list">
              {QUICK_QUESTIONS.map((question) => (
                <button
                  key={question}
                  className="ai-panel__question"
                  onClick={() => sendMessage(question)}
                  disabled={loading}
                >
                  {question}
                </button>
              ))}
            </div>
          </section>

          <section className="card">
            <div className="card__header">
              <div>
                <h2>Текущая модель</h2>
                <p>Запросы идут через Ollama</p>
              </div>
            </div>

            <div className="assistant-model">
              <strong>{model}</strong>
              <span>Локальная модель</span>
            </div>
          </section>
        </aside>
      </div>
    </section>
  );
}