import React, { useState } from 'react';
import axios from 'axios';

const FileUpload = () => {
  const [file, setFile] = useState(null);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState(null); // Добавляем обработку ошибок

  const handleFileChange = (e) => {
    const selectedFile = e.target.files[0];
    if (selectedFile) {
      setFile(selectedFile);
    }
  };

  const handleUpload = async () => {
    if (!file) return; // Проверка на наличие файла

    setLoading(true);
    setError(null); // Сброс ошибки

    try {
      const formData = new FormData();
      formData.append('file', file);
      
      await axios.post('/api/files', formData, {
        headers: {
          'Content-Type': 'multipart/form-data'
        }
      });
      
      setFile(null);
      setLoading(false);
    } catch (error) {
      console.error('Ошибка загрузки:', error);
      setError('Произошла ошибка при загрузке файла');
      setLoading(false);
    }
  };

  return (
    <div className="file-upload">
      <input
        type="file"
        onChange={handleFileChange}
        accept="*"
        style={{ display: 'none' }}
        ref={(input) => {
          if (input) {
            input.value = '';
          }
        }}
      />
      
      <label htmlFor="file-upload" className="file-upload-label">
        <button
          disabled={loading || !file}
          onClick={() => {
            document.getElementById('file-upload').click();
          }}
        >
          {loading ? 'Загрузка...' : 'Загрузить'}
        </button>
      </label>

      {error && <p className="error">{error}</p>}
    </div>
  );
};

export default FileUpload;
