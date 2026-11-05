import { useEffect, useState } from 'react';
import axios from 'axios';

export function AuditBar() {
  const [status, setStatus] = useState('⏳ Проверка API...');

  useEffect(() => {
    axios.get('/api/health')
      .then(res => {
        if (res.data.status === 'ok') {
          setStatus(✅ API: OK ());
        } else {
          setStatus(⚠️ API: статус );
        }
      })
      .catch(err => {
        console.error(err);
        setStatus('❌ API: недоступен');
      });
  }, []);

  return (
    <div style={{
      position: 'fixed',
      top: 0,
      left: 0,
      right: 0,
      padding: '8px 16px',
      background: '#2b2d3a',
      color: '#fff',
      fontFamily: 'sans-serif',
      fontSize: '14px',
      zIndex: 9999,
      borderBottom: '1px solid #444',
      display: 'flex',
      alignItems: 'center',
      gap: '12px',
    }}>
      <span>Панель аудита (
oosphere-engine)</span>
      <span style={{ fontWeight: 'bold' }}>{status}</span>
    </div>
  );
}
