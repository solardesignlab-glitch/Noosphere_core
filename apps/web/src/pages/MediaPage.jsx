import { useEffect, useRef, useState } from "react";
import FileDropzone from "../components/FileDropzone";

const API_URL = "http://localhost:4000";

export default function MediaPage() {
  const fileInputRef = useRef(null);

  const [files, setFiles] = useState([]);
  const [loading, setLoading] = useState(true);
  const [uploading, setUploading] = useState(false);
  const [error, setError] = useState(null);
  const [copiedUrl, setCopiedUrl] = useState(null);

  async function loadFiles() {
    try {
      setLoading(true);
      setError(null);

      const response = await fetch(`${API_URL}/api/media`);

      if (!response.ok) {
        throw new Error("Не удалось получить медиафайлы");
      }

      const data = await response.json();

      setFiles(data.files || []);
    } catch (err) {
      setError(err.message);
    } finally {
      setLoading(false);
    }
  }

  useEffect(() => {
    loadFiles();
  }, []);

  async function handleUpload(event) {
    const file = event.target.files[0];

    if (!file) return;

    try {
      setUploading(true);
      setError(null);

      const formData = new FormData();
      formData.append("image", file);

      const response = await fetch(`${API_URL}/api/media`, {
        method: "POST",
        body: formData
      });

      const data = await response.json();

      if (!response.ok) {
        throw new Error(data.error || "Ошибка загрузки");
      }

      await loadFiles();
    } catch (err) {
      setError(err.message);
    } finally {
      setUploading(false);
      event.target.value = "";
    }
  }

  async function copyUrl(url) {
    await navigator.clipboard.writeText(url);
    setCopiedUrl(url);

    setTimeout(() => {
      setCopiedUrl(null);
    }, 2000);
  }

  return (
    <div>
      <div className="page__header">
        <div>
          <h1>Медиа</h1>
          <p>Загрузка изображений для сайта и интерфейса</p>
        </div>

        <label className="button button--primary">
          {uploading ? "Загружаем…" : "Загрузить изображение"}

          <input
            ref={fileInputRef}
            type="file"
            accept="image/png,image/jpeg,image/webp,image/gif"
            onChange={handleUpload}
            style={{ display: "none" }}
          />
        </label>
      </div>

      <FileDropzone onUploaded={loadFiles} />

      {loading && (
        <div className="state-card">
          <div className="spinner" />
          <p>Загружаем медиабиблиотеку…</p>
        </div>
      )}

      {!loading && error && (
        <div className="state-card state-card--error">
          <span className="state-card__icon">⚠️</span>
          <h2>Ошибка</h2>
          <p>{error}</p>
        </div>
      )}

      {!loading && !error && files.length === 0 && (
        <div className="state-card">
          <span className="state-card__icon">🖼️</span>
          <h2>Пока нет изображений</h2>
          <p>Загрузите логотип, макет или изображение для сайта.</p>
        </div>
      )}

      {!loading && !error && files.length > 0 && (
        <div className="media-grid">
          {files.map((file) => (
            <article className="media-card" key={file.id}>
              <img src={file.url} alt={file.name} />

              <div className="media-card__body">
                <strong>{file.name}</strong>

                <button
                  className="button button--small"
                  type="button"
                  onClick={() => copyUrl(file.url)}
                >
                  {copiedUrl === file.url ? "Скопировано" : "Копировать URL"}
                </button>
              </div>
            </article>
          ))}
        </div>
      )}
    </div>
  );
}