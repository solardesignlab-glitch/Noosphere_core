import { useState } from "react";

export default function App() {
  const [message, setMessage] = useState("");
  const [reply, setReply] = useState("");
  const [loading, setLoading] = useState(false);

  async function send() {
    if (!message.trim()) return;

    setLoading(true);
    setReply("");

    try {
      const response = await fetch("/api/ai/chat", {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify({
          message,
          history: [],
        }),
      });

      const data = await response.json();
      setReply(data.reply || "Ответ не получен");
    } catch {
      setReply("Ошибка соединения с AI-сервисом");
    } finally {
      setLoading(false);
    }
  }

  return (
    <main className="app">
      <h1>Атмосфера AI</h1>

      <textarea
        value={message}
        onChange={(event) => setMessage(event.target.value)}
        rows={4}
        placeholder="Спросите AI-ассистента..."
      />

      <button onClick={send} disabled={loading}>
        {loading ? "AI думает..." : "Отправить"}
      </button>

      {reply && (
        <section className="reply">
          <strong>Ответ AI:</strong>
          <p>{reply}</p>
        </section>
      )}
    </main>
  );
}