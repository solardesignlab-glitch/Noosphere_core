import { useState } from "react";
import "./App.css";

import DashboardPage from "./pages/DashboardPage";
import AiModelsPage from "./pages/AiModelsPage";
import SessionsPage from "./pages/SessionsPage";
import AiAssistantPage from "./pages/AiAssistantPage";
import AgentPanel from "./components/AgentPanel";

const NAV_ITEMS = [
  { id: "dashboard", label: "Дашборд", icon: "📊" },
  { id: "appointments", label: "Записи", icon: "📅" },
  { id: "clients", label: "Клиенты", icon: "👥" },
  { id: "masters", label: "Мастера", icon: "✂️" },
  { id: "services", label: "Услуги", icon: "💼" },
  { id: "ai", label: "AI-помощник", icon: "🤖" },
  { id: "design", label: "AI-дизайн", icon: "🎨" },
  { id: "settings", label: "Настройки", icon: "⚙️" }
];

export default function App() {
  const [activePage, setActivePage] = useState("dashboard");
  const [isAgentOpen, setIsAgentOpen] = useState(false);

  return (
    <div className="app">
      <aside className="sidebar">
        <div className="sidebar__brand">
          <div className="sidebar__logo">A</div>
          <div>
            <div className="sidebar__title">Атмосфера</div>
            <div className="sidebar__subtitle">CRM салона</div>
          </div>
        </div>

        <nav className="sidebar__nav">
          {NAV_ITEMS.map((item) => (
            <button
              key={item.id}
              className={
                "sidebar__item" +
                (activePage === item.id ? " sidebar__item--active" : "")
              }
              onClick={() => setActivePage(item.id)}
            >
              <span>{item.icon}</span>
              {item.label}
            </button>
          ))}
        </nav>

        <div className="sidebar__footer">
          <div className="sidebar__user">
            <div className="sidebar__avatar">А</div>
            <div>
              <div className="sidebar__user-name">Администратор</div>
              <div className="sidebar__user-role">Салон «Атмосфера»</div>
            </div>
          </div>
        </div>
      </aside>

      <main className="main">
        {activePage === "dashboard" && <DashboardPage />}

        {activePage === "appointments" && <SessionsPage />}

        {activePage === "settings" && <SettingsPage />}

        {activePage === "ai" && <AiAssistantPage />}

        {activePage === "design" && (
          <section className="page">
            <header className="page__header">
              <div>
                <h1>AI-дизайн</h1>
                <p>
                  Загрузите скриншот интерфейса для анализа и рекомендаций.
                </p>
              </div>

              <button
                className="button button--primary"
                type="button"
                onClick={() => setIsAgentOpen(true)}
              >
                Открыть дизайн-ревью
              </button>
            </header>

            <div className="empty-state">
              <div className="empty-state__icon">🎨</div>
              <h2>AI-дизайн-ассистент</h2>
              <p>
                Загрузите скриншот или макет, чтобы получить UX-анализ.
              </p>
            </div>
          </section>
        )}

        {["clients", "masters", "services"].includes(activePage) && (
          <section className="page">
            <header className="page__header">
              <div>
                <h1>
                  {NAV_ITEMS.find((item) => item.id === activePage).label}
                </h1>
                <p>Раздел будет подключён после MVP-дашборда.</p>
              </div>
            </header>

            <div className="empty-state">
              <div className="empty-state__icon">🚧</div>
              <h2>Раздел в разработке</h2>
              <p>Сначала завершим дашборд и страницу записей.</p>
            </div>
          </section>
        )}
      </main>

      {isAgentOpen && (
        <AgentPanel onClose={() => setIsAgentOpen(false)} />
      )}
    </div>
  );
}

function SettingsPage() {
  const [activeTab, setActiveTab] = useState("ai-models");

  const tabs = [
    { id: "profile", label: "Профиль салона" },
    { id: "users", label: "Пользователи" },
    { id: "ai-models", label: "AI-модели" },
    { id: "integrations", label: "Интеграции" }
  ];

  return (
    <section className="page">
      <header className="page__header">
        <div>
          <h1>Настройки</h1>
          <p>Управление салоном, пользователями и AI-моделями</p>
        </div>
      </header>

      <div className="tabs">
        {tabs.map((tab) => (
          <button
            key={tab.id}
            className={"tab" + (activeTab === tab.id ? " tab--active" : "")}
            onClick={() => setActiveTab(tab.id)}
          >
            {tab.label}
          </button>
        ))}
      </div>

      {activeTab === "ai-models" ? (
        <AiModelsPage />
      ) : (
        <div className="empty-state">
          <div className="empty-state__icon">⚙️</div>
          <h2>Раздел в разработке</h2>
          <p>Здесь появятся настройки выбранного раздела.</p>
        </div>
      )}
    </section>
  );
}