import { useState } from 'react';
import './App.css';
import AiPanel from './components/AiPanel';

const NAV = [
  { id: 'dashboard', label: 'Дашборд' },
  { id: 'appointments', label: 'Записи' },
  { id: 'masters', label: 'Мастера' },
  { id: 'services', label: 'Услуги' },
  { id: 'clients', label: 'Клиенты' },
  { id: 'analytics', label: 'Аналитика' },
  { id: 'ai', label: 'AI-помощник' },
];

const APPOINTMENTS = [
  {
    id: 1,
    time: '10:00',
    client: 'Анна Смирнова',
    master: 'Мария',
    service: 'Стрижка и укладка',
    status: 'confirmed',
  },
  {
    id: 2,
    time: '12:30',
    client: 'Игорь Петров',
    master: 'Дмитрий',
    service: 'Массаж спины',
    status: 'pending',
  },
  {
    id: 3,
    time: '15:00',
    client: 'Елена Ковалёва',
    master: 'Мария',
    service: 'Маникюр',
    status: 'confirmed',
  },
];

const STATUS_LABELS = {
  pending: 'Ожидает',
  confirmed: 'Подтверждена',
  completed: 'Завершена',
  cancelled: 'Отменена',
};

export default function App() {
  const [page, setPage] = useState('dashboard');

  const current = NAV.find((item) => item.id === page);

  return (
    <div className="app">
      <aside className="sidebar">
        <div className="brand">
          <div className="brand-mark">А</div>
          <div>
            <div className="brand-name">Атмосфера</div>
            <div className="brand-sub">CRM для услуг</div>
          </div>
        </div>

        <nav className="nav">
          {NAV.map((item) => (
            <button
              key={item.id}
              className={page === item.id ? 'nav-item active' : 'nav-item'}
              onClick={() => setPage(item.id)}
            >
              {item.label}
            </button>
          ))}
        </nav>

        <button className="primary-button">+ Новая запись</button>
      </aside>

      <main className="main">
        <header className="topbar">
          <div>
            <h1>{current?.label}</h1>
            <p className="topbar-sub">Рабочее место администратора</p>
          </div>

          <div className="user">
            <div className="avatar">АД</div>
            <div>
              <div className="user-name">Администратор</div>
              <div className="user-role">Атмосфера</div>
            </div>
          </div>
        </header>

        {page === 'dashboard' && (
          <section className="page">
            <div className="kpi-grid">
              <div className="card kpi">
                <span>Записей сегодня</span>
                <strong>12</strong>
              </div>
              <div className="card kpi warning">
                <span>Ожидают подтверждения</span>
                <strong>4</strong>
              </div>
              <div className="card kpi success">
                <span>Выручка за день</span>
                <strong>18 400 ₽</strong>
              </div>
              <div className="card kpi">
                <span>Загрузка мастеров</span>
                <strong>76%</strong>
              </div>
            </div>

            <div className="card">
              <div className="card-head">
                <h2>Ближайшие записи</h2>
                <button
                  className="ghost-button"
                  onClick={() => setPage('appointments')}
                >
                  Все записи
                </button>
              </div>

              <div className="appointment-list">
                {APPOINTMENTS.map((item) => (
                  <div className="appointment" key={item.id}>
                    <div className="appointment-time">{item.time}</div>
                    <div className="appointment-info">
                      <strong>{item.client}</strong>
                      <span>
                        {item.service} · {item.master}
                      </span>
                    </div>
                    <span className={`badge ${item.status}`}>
                      {STATUS_LABELS[item.status]}
                    </span>
                  </div>
                ))}
              </div>
            </div>
          </section>
        )}

        {page === 'appointments' && (
          <section className="page">
            <div className="card">
              <div className="card-head">
                <h2>Все записи</h2>
                <button className="ghost-button">Фильтры</button>
              </div>

              <div className="appointment-list">
                {APPOINTMENTS.map((item) => (
                  <div className="appointment" key={item.id}>
                    <div className="appointment-time">{item.time}</div>
                    <div className="appointment-info">
                      <strong>{item.client}</strong>
                      <span>
                        {item.service} · {item.master}
                      </span>
                    </div>
                    <span className={`badge ${item.status}`}>
                      {STATUS_LABELS[item.status]}
                    </span>
                  </div>
                ))}
              </div>
            </div>
          </section>
        )}

        {page === 'ai' && <AiPanel />}

        {page !== 'dashboard' && page !== 'appointments' && page !== 'ai' && (
          <section className="page">
            <div className="card empty">
              <h2>Раздел в разработке</h2>
              <p>Здесь появится «{current?.label}».</p>
            </div>
          </section>
        )}
      </main>
    </div>
  );
}