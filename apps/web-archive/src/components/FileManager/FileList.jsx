import React, { useState, useEffect } from 'react';
import axios from 'axios';

const FileList = () => {
  const [files, setFiles] = useState();

  useEffect(() => {
    const fetchFiles = async () => {
      try {
        const { data } = await axios.get('/api/files');
        setFiles(data);
      } catch (error) {
        console.error('Ошибка получения файлов:', error);
      }
    };

    fetchFiles();
  }, );

  return (
    <div className="file-list">
      <ul>
        {files.length === 0 ? (
          <li>Список файлов пуст</li>
        ) : (
          files.map(({ id, name, size }) => (
            <li key={id}>
              <div>
                <span>{name}</span>
                <span>{size} КБ</span>
              </div>
            </li>
          ))
        )}
      </ul>
    </div>
  );
};

export default FileList;
