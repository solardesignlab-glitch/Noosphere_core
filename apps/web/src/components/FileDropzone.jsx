import { useRef, useState } from "react";

const ALLOWED_TYPES = [
  "image/png",
  "image/jpeg",
  "image/webp",
  "image/gif"
];

const MAX_SIZE = 20 * 1024 * 1024;

export default function FileDropzone({ onUploaded }) {
  const inputRef = useRef(null);

  const [isDragging, setIsDragging] = useState(false);
  const [uploading, setUploading] = useState(false);
  const [error, setError] = useState(null);
  const [uploaded, setUploaded] = useState([]);

  function validateFile(file) {
    if (!ALLOWED_TYPES.includes(file.type)) {
      return "Поддерживаются PNG, JPEG, WEBP и неанимированный GIF.";
    }

    if (file.size > MAX_SIZE) {
      return "Файл больше 20 МБ.";
    }

    return null;
  }

  async function uploadFiles(fileList) {
    const selected = Array.from(fileList);

    if (selected.length === 0) return;

    setUploading(true);
    setError(null);

    try {
      const results = [];

      for (const file of selected) {
        const validationError = validateFile(file);

        if (validationError) {
          throw new Error(`${file.name}: ${validationError}`);
        }

        const formData = new FormData();
        formData.append("image", file);

        const response = await fetch(
          "http://localhost:4000/api/media",
          {
            method: "POST",
            body: formData
          }
        );

        const data = await response.json();

        if (!response.ok) {
          throw new Error(data.error || "Ошибка загрузки файла");
        }

        results.push(data);
      }

      setUploaded((prev) => [...results, ...prev]);
      onUploaded?.(results);
    } catch (err) {
      setError(err.message);
    } finally {
      setUploading(false);
    }
  }

  function handleDrop(event) {
    event.preventDefault();
    setIsDragging(false);

    uploadFiles(event.dataTransfer.files);
  }

  function handleDragOver(event) {
    event.preventDefault();
    setIsDragging(true);
  }

  function handleDragLeave() {
    setIsDragging(false);
  }

  return (
    <div className="dropzone-wrapper">
      <div
        className={`dropzone ${isDragging ? "dropzone--active" : ""}`}
        onDrop={handleDrop}
        onDragOver={handleDragOver}
        onDragLeave={handleDragLeave}
        onClick={() => inputRef.current?.click()}
      >
        <span className="dropzone__icon">📤</span>

        <strong>
          {uploading ? "Загружаем файлы…" : "Перетащите изображения сюда"}
        </strong>

        <p>
          PNG, JPEG, WEBP или неанимированный GIF. До 20 МБ на файл.
        </p>

        <button className="button button--primary" type="button">
          Выбрать файлы
        </button>

        <input
          ref={inputRef}
          type="file"
          accept="image/png,image/jpeg,image/webp,image/gif"
          multiple
          onChange={(event) => uploadFiles(event.target.files)}
          style={{ display: "none" }}
        />
      </div>

      {error && (
        <div className="dropzone__error">
          {error}
        </div>
      )}

      {uploaded.length > 0 && (
        <div className="dropzone__results">
          {uploaded.map((file) => (
            <div className="dropzone__result" key={file.id}>
              <img src={file.url} alt={file.name} />
              <span>{file.name}</span>
            </div>
          ))}
        </div>
      )}
    </div>
  );
}