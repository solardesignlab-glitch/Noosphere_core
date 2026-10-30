import { useRef, useState } from "react";

const DEFAULT_QUESTION =
  "Проанализируй этот интерфейс CRM «Атмосфера» и предложи улучшения: структура экрана, UX-сценарии, тексты, визуальная иерархия и доступность.";

const ALLOWED_TYPES = [
  "image/png",
  "image/jpeg",
  "image/webp",
  "image/gif"
];

function parseAnswer(answer) {
  const lines = answer
    .split("\n")
    .map((line) => line.trim())
    .filter(Boolean);

  const sections = [];
  let current = { title: "Результат анализа", items: [] };

  lines.forEach((line) => {
    const isHeading =
      /^#{1,6}\s+/.test(line) ||
      /^\*\*[^*]+\*\*:?$/.test(line) ||
      /^[А-ЯЁA-Z0-9\s\-—:]{3,80}:?$/.test(line);

    if (isHeading) {
      if (current.items.length > 0 || sections.length > 0) {
        sections.push(current);
      }

      current = {
        title: line
          .replace(/^#{1,6}\s+/, "")
          .replace(/\*\*/g, "")
          .replace(/:$/, ""),
        items: []
      };

      return;
    }

    const text = line.replace(/^[-*•]\s+/, "");

    if (text) {
      current.items.push(text);
    }
  });

  if (current.items.length > 0 || sections.length === 0) {
    sections.push(current);
  }

  return sections;
}

export default function AgentPanel({ onClose }) {
  const fileInputRef = useRef(null);

  const [file, setFile] = useState(null);
  const [preview, setPreview] = useState(null);
  const [question, setQuestion] = useState(DEFAULT_QUESTION);
  const [answer, setAnswer] = useState("");
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState(null);
  const [copied, setCopied] = useState(false);

  function handleSelect(event) {
    const selected = event.target.files[0];

    if (!selected) {
      return;
    }

    if (!ALLOWED_TYPES.includes(selected.type)) {
      setError("Поддерживаются PNG, JPEG, WEBP и неанимированный GIF.");
      return;
    }

    if (selected.size > 20 * 1024 * 1024) {
      setError("Файл больше 20 МБ.");
      return;
    }

    setError(null);
    setFile(selected);
    setPreview(URL.createObjectURL(selected));
    setAnswer("");
    setCopied(false);
  }

  function handleRemoveFile() {
    setFile(null);
    setPreview(null);
    setAnswer("");
    setError(null);

    if (fileInputRef.current) {
      fileInputRef.current.value = "";
    }
  }

  async function handleCopy() {
    try {
      await navigator.clipboard.writeText(answer);
      setCopied(true);
      setTimeout(() => setCopied(false), 2000);
    } catch {
      setError("Не удалось скопировать результат.");
    }
  }

  async function analyze() {
    if (!file || loading) {
      return;
    }

    try {
      setLoading(true);
      setError(null);
      setAnswer("");
      setCopied(false);

      const formData = new FormData();
      formData.append("image", file);
      formData.append("question", question);

      const response = await fetch(
        "http://localhost:4000/api/agent/analyze-design",
        {
          method: "POST",
          body: formData
        }
      );

      const data = await response.json();

      if (!response.ok) {
        throw new Error(
          data.error || data.detail || "Ошибка анализа изображения"
        );
      }

      setAnswer(data.answer || "Модель не вернула результат анализа.");
    } catch (err) {
      setError(err.message);
    } finally {
      setLoading(false);
    }
  }

  const resultSections = answer ? parseAnswer(answer) : [];

  return (
    <div className="agent-overlay">
      <aside className="agent-panel">
        <div className="agent-panel__header">
          <div>
            <p className="agent-panel__eyebrow">AI-ассистент</p>
            <h2>Дизайн-ревьюер</h2>
          </div>

          <button
            className="button button--small"
            type="button"
            onClick={onClose}
          >
            Закрыть
          </button>
        </div>

        <div className="agent-panel__body">
          <label className="agent-panel__label">
            Скриншот или макет
          </label>

          <input
            ref={fileInputRef}
            type="file"
            accept="image/png,image/jpeg,image/webp,image/gif"
            onChange={handleSelect}
          />

          {preview && (
            <div className="agent-panel__preview-wrapper">
              <img
                className="agent-panel__preview"
                src={preview}
                alt="Предпросмотр загруженного интерфейса"
              />

              <button
                className="button button--small"
                type="button"
                onClick={handleRemoveFile}
              >
                Удалить файл
              </button>
            </div>
          )}

          <label className="agent-panel__label">
            Вопрос для агента
          </label>

          <textarea
            className="agent-panel__textarea"
            value={question}
            onChange={(event) => setQuestion(event.target.value)}
            rows={4}
          />

          <button
            className="button button--primary agent-panel__submit"
            type="button"
            onClick={analyze}
            disabled={!file || loading}
          >
            {loading ? "Анализируем…" : "Проанализировать дизайн"}
          </button>

          {error && (
            <div className="agent-panel__result agent-panel__result--error">
              {error}
            </div>
          )}

          {answer && (
            <div className="agent-panel__result">
              <div className="agent-panel__result-header">
                <h3>Результат анализа</h3>

                <button
                  className="button button--small"
                  type="button"
                  onClick={handleCopy}
                >
                  {copied ? "Скопировано" : "Скопировать"}
                </button>
              </div>

              {resultSections.map((section, sectionIndex) => (
                <div
                  className="agent-panel__section"
                  key={`${section.title}-${sectionIndex}`}
                >
                  <h4>{section.title}</h4>

                  {section.items.length > 0 && (
                    <ul>
                      {section.items.map((item, itemIndex) => (
                        <li key={`${item}-${itemIndex}`}>{item}</li>
                      ))}
                    </ul>
                  )}
                </div>
              ))}
            </div>
          )}

          {!answer && !loading && !error && (
            <div className="agent-panel__hint">
              Загрузите скриншот экрана CRM и нажмите «Проанализировать
              дизайн». AI предложит улучшения структуры, UX, текстов и
              визуальной иерархии.
            </div>
          )}
        </div>
      </aside>
    </div>
  );
}