import { useEffect, useRef, useState } from "react";
import "../App.css";

const API_BASE = "http://localhost:4000";

const AGENTS = [
  {
    id: "product",
    label: "Продукт и визуал",
    hint: "UX, интерфейсы, тексты, бизнес-логика"
  },
  {
    id: "architecture",
    label: "Архитектура и код",
    hint: "Данные, API, React, интеграции"
  }
];

const MODELS = [
  "qwen2.5:7b",
  "qwen2.5-coder:7b",
  "qwen2.5-coder-32k:latest"
];

const MAX_FILES = 5;
const MAX_FILE_SIZE = 20 * 1024 * 1024;

const ALLOWED_IMAGE_TYPES = [
  "image/png",
  "image/jpeg",
  "image/webp",
  "image/gif"
];

const ALLOWED_DOCUMENT_TYPES = [
  "application/pdf",
  "text/plain",
  "text/markdown",
  "text/csv",
  "application/msword",
  "application/vnd.openxmlformats-officedocument.wordprocessingml.document",
  "application/vnd.ms-excel",
  "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
];

const ACCEPTED_FILE_TYPES = [
  ".png",
  ".jpg",
  ".jpeg",
  ".webp",
  ".gif",
  ".pdf",
  ".doc",
  ".docx",
  ".txt",
  ".md",
  ".csv",
  ".xlsx"
].join(",");

function getFileKey(file) {
  return `${file.name}-${file.size}-${file.lastModified}`;
}

function isAllowedFileType(file) {
  return (
    ALLOWED_IMAGE_TYPES.includes(file.type) ||
    ALLOWED_DOCUMENT_TYPES.includes(file.type) ||
    /\.(pdf|docx?|txt|md|csv|xlsx)$/i.test(file.name)
  );
}

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
  const chatEndRef = useRef(null);

  const [messages, setMessages] = useState([
    {
      role: "assistant",
      content:
        "Здравствуйте! Выберите агента, задайте вопрос и при необходимости прикрепите скриншот, документ или файл с данными."
    }
  ]);

  const [agent, setAgent] = useState("product");
  const [model, setModel] = useState("qwen2.5:7b");
  const [input, setInput] = useState("");
  const [files, setFiles] = useState([]);
  const [filePreviews, setFilePreviews] = useState({});
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState(null);
  const [copied, setCopied] = useState(false);

  const currentAgent = AGENTS.find((item) => item.id === agent);

  useEffect(() => {
    chatEndRef.current?.scrollIntoView({ behavior: "smooth" });
  }, [messages, loading]);

  useEffect(() => {
    return () => {
      Object.values(filePreviews).forEach((previewUrl) => {
        URL.revokeObjectURL(previewUrl);
      });
    };
  }, [filePreviews]);

  function handleFiles(event) {
    const selectedFiles = Array.from(event.target.files || []);

    if (selectedFiles.length === 0) {
      return;
    }

    if (files.length + selectedFiles.length > MAX_FILES) {
      setError(`Можно прикрепить не более ${MAX_FILES} файлов.`);
      event.target.value = "";
      return;
    }

    const invalidFile = selectedFiles.find(
      (file) => !isAllowedFileType(file)
    );

    if (invalidFile) {
      setError(
        `Файл «${invalidFile.name}» не поддерживается. Разрешены изображения, PDF, DOCX, TXT, MD, CSV и XLSX.`
      );
      event.target.value = "";
      return;
    }

    const oversizedFile = selectedFiles.find(
      (file) => file.size > MAX_FILE_SIZE
    );

    if (oversizedFile) {
      setError(`Файл «${oversizedFile.name}» больше 20 МБ.`);
      event.target.value = "";
      return;
    }

    const nextPreviews = {};

    selectedFiles.forEach((file) => {
      if (ALLOWED_IMAGE_TYPES.includes(file.type)) {
        nextPreviews[getFileKey(file)] = URL.createObjectURL(file);
      }
    });

    setError(null);
    setFiles((prev) => [...prev, ...selectedFiles]);
    setFilePreviews((prev) => ({ ...prev, ...nextPreviews }));
    event.target.value = "";
  }

  function removeFile(file) {
    const fileKey = getFileKey(file);

    setFiles((prev) => prev.filter((item) => getFileKey(item) !== fileKey));

    setFilePreviews((prev) => {
      const previewUrl = prev[fileKey];

      if (previewUrl) {
        URL.revokeObjectURL(previewUrl);
      }

      const nextPreviews = { ...prev };
      delete nextPreviews[fileKey];

      return nextPreviews;
    });
  }

  function clearAttachments() {
    Object.values(filePreviews).forEach((previewUrl) => {
      URL.revokeObjectURL(previewUrl);
    });

    setFiles([]);
    setFilePreviews({});

    if (fileInputRef.current) {
      fileInputRef.current.value = "";
    }
  }

  async function handleCopy() {
    const lastAssistantMessage = [...messages]
      .reverse()
      .find((message) => message.role === "assistant");

    if (!lastAssistantMessage) {
      return;
    }

    try {
      await navigator.clipboard.writeText(lastAssistantMessage.content);
      setCopied(true);
      setTimeout(() => setCopied(false), 2000);
    } catch {
      setError("Не удалось скопировать результат.");
    }
  }

  async function sendMessage(text) {
    const question = text.trim();
    const hasFiles = files.length > 0;

    if ((!question && !hasFiles) || loading) {
      return;
    }

    const userMessage = {
      role: "user",
      content: question || "Проанализируй прикреплённые файлы.",
      files: files.map((file) => file.name)
    };

    const history = messages
      .filter((message) => message.role !== "system")
      .slice(-10);

    setMessages((prev) => [...prev, userMessage]);
    setInput("");
    setLoading(true);
    setError(null);
    setCopied(false);

    const currentFiles = files;
    clearAttachments();

    try {
      const formData = new FormData();

      formData.append("message", question);
      formData.append("agent", agent);
      formData.append("model", model);
      formData.append("history", JSON.stringify(history));

      currentFiles.forEach((file) => {
        formData.append("files", file);
      });

      const response = await fetch(`${API_BASE}/api/ai/chat`, {
        method: "POST",
        body: formData
      });

      const data = await response.json();

      if (!response.ok) {
        throw new Error(
          data.error ||
            data.detail ||
            "Не удалось получить ответ от AI-помощника."
        );
      }

      setMessages((prev) => [
        ...prev,
        {
          role: "assistant",
          content:
            data.reply ||
            "Модель вернула пустой ответ. Попробуйте переформулировать запрос."
        }
      ]);
    } catch (err) {
      setError(err.message);
    } finally {
      setLoading(false);
    }
  }

  const lastAssistantMessage = [...messages]
    .reverse()
    .find((message) => message.role === "assistant");

  const resultSections = lastAssistantMessage
    ? parseAnswer(lastAssistantMessage.content)
    : [];

  return (
    <div className="agent-overlay">
      <aside className="agent-panel">
        <div className="agent-panel__header">
          <div>
            <p className="agent-panel__eyebrow">AI-ассистент</p>
            <h2>Помощник «Атмосферы»</h2>
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
          <div className="assistant-agent-switch">
            {AGENTS.map((item) => (
              <button
                key={item.id}
                type="button"
                className={
                  "assistant-agent-button" +
                  (agent === item.id ? " assistant-agent-button--active" : "")
                }
                onClick={() => setAgent(item.id)}
                disabled={loading}
              >
                {item.label}
              </button>
            ))}
          </div>

          <div className="assistant-agent-hint">
            <strong>{currentAgent.label}:</strong> {currentAgent.hint}
          </div>

          <div className="agent-panel__chat">
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

                {message.files?.length > 0 && (
                  <div className="assistant-message__files">
                    {message.files.map((fileName, fileIndex) => (
                      <span
                        key={`${fileName}-${fileIndex}`}
                        className="assistant-file-chip"
                      >
                        📎 {fileName}
                      </span>
                    ))}
                  </div>
                )}
              </div>
            ))}

            {loading && (
              <div className="assistant-message assistant-message--assistant">
                <div className="assistant-message__role">AI-помощник</div>
                <div className="assistant-message__text">
                  Анализирую запрос
                  {files.length > 0 ? " и вложения" : ""}...
                </div>
              </div>
            )}

            <div ref={chatEndRef} />
          </div>

          {error && (
            <div className="agent-panel__result agent-panel__result--error">
              {error}
            </div>
          )}

          <form
            className="assistant-chat__form"
            onSubmit={(event) => {
              event.preventDefault();
              sendMessage(input);
            }}
          >
            {files.length > 0 && (
              <div className="assistant-attachments">
                {files.map((file) => {
                  const fileKey = getFileKey(file);
                  const previewUrl = filePreviews[fileKey];

                  return (
                    <div
                      key={fileKey}
                      className="assistant-attachment"
                    >
                      {previewUrl && (
                        <img
                          className="assistant-attachment__preview"
                          src={previewUrl}
                          alt={`Предпросмотр ${file.name}`}
                        />
                      )}

                      <span className="assistant-attachment__name">
                        📎 {file.name}
                      </span>

                      <button
                        type="button"
                        className="assistant-attachment__remove"
                        onClick={() => removeFile(file)}
                        disabled={loading}
                      >
                        ✕
                      </button>
                    </div>
                  );
                })}
              </div>
            )}

            <div className="assistant-chat__controls">
              <label
                className="assistant-attach"
                title="Прикрепить скриншот или документ"
              >
                📎
                <input
                  ref={fileInputRef}
                  type="file"
                  multiple
                  hidden
                  accept={ACCEPTED_FILE_TYPES}
                  onChange={handleFiles}
                  disabled={loading || files.length >= MAX_FILES}
                />
              </label>

              <textarea
                className="assistant-chat__input"
                value={input}
                onChange={(event) => setInput(event.target.value)}
                placeholder="Опишите задачу или прикрепите скриншот…"
                rows={2}
                disabled={loading}
                onKeyDown={(event) => {
                  if (event.key === "Enter" && !event.shiftKey) {
                    event.preventDefault();
                    sendMessage(input);
                  }
                }}
              />

              <button
                type="submit"
                className="button button--primary"
                disabled={loading || (!input.trim() && files.length === 0)}
              >
                ➤
              </button>
            </div>
          </form>

          {lastAssistantMessage && !loading && (
            <div className="agent-panel__result">
              <div className="agent-panel__result-header">
                <h3>Последний ответ</h3>

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

          <div className="agent-panel__footer">
            <select
              className="ai-model-select"
              value={model}
              onChange={(event) => setModel(event.target.value)}
              disabled={loading}
            >
              {MODELS.map((item) => (
                <option key={item} value={item}>
                  {item}
                </option>
              ))}
            </select>

            <span>Локальная модель через Ollama</span>
          </div>
        </div>
      </aside>
    </div>
  );
}