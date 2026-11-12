import { useState } from "react";
import "./App.css";

import DashboardPage from "./pages/DashboardPage";
import AiModelsPage from "./pages/AiModelsPage";
import SessionsPage from "./pages/SessionsPage";
import AiAssistantPage from "./pages/AiAssistantPage";
import AgentPanel from "./components/AgentPanel";
import LoginPage from "./pages/LoginPage";
import PartsPage from "./pages/PartsPage";

import { getStoredUser, logout } from "./api/backend";

const OWNER_NAV_ITEMS = [
  { id: "dashboard", label: "Дашборд", icon: "📊" },
  { id: "appointments", label: "Записи", icon: "📅" },
  { id: "clients", label: "Клиенты", icon: "👥" },
  { id: "masters", label: "Мастера", icon: "✂️" },
  { id: "services", label: "Услуги", icon: "💼" },
  { id: "parts", label: "Запчасти", icon: "⚙️" },
  { id: "ai", label: "AI-помощник", icon: "🤖" },
  { id: "settings", label: "Настройки", icon: "⚙️" }
];

const DEVELOPER_NAV_ITEMS = [
  { id: "ai", label: "AI-помощник", icon: "🤖" },
  { id: "settings", label: "AI-модели", icon: "⚙️" }
];

const CLIENT_NAV_ITEMS = [
  { id: "client-home", label: "Мой кабинет", icon: "🏠" },
  { id: "ai", label: "AI-помощник", icon: "🤖" }
];

const PAGE_TITLES = {
  clients: "Клиенты",
  masters: "Мастера",
  services: "Услуги"
};

export default function App() {
  const [user, setUser] = useState(getStoredUser());
  const [activePage, setActivePage] = useState("dashboard");
  const [isAgentOpen, setIsAgentOpen] = useState(false);

  if (!user) {
    return (
      <LoginPage
        onLogin={(loggedInUser) => {
          setUser(loggedInUser);
          setActivePage(
            loggedInUser.role === "client" ? "client-home" : "dashboard"
          );
        }}
      />
    );
  }

  const role = user.role;

  const navItems =
    role === "owner"
      ? OWNER_NAV_ITEMS
      : role === "developer"
        ? DEVELOPER_NAV_ITEMS
        : CLIENT_NAV_ITEMS;

  const visiblePage = navItems.some((item) => item.id === activePage)
    ? activePage
    : navItems[0].id;

  function handleLogout() {
    logout();
    setUser(null);
    setActivePage("dashboard");
  }

  return (
    <div className="app">
      <aside className="sidebar">
        <div className="sidebar__brand">
          <div className="sidebar__logo">A</div>

          <div>
            <div className="sidebar__title">Атмосфера</div>
            <div className="sidebar__subtitle">
              {role === "owner"
                ? "CRM салона"
                : role === "developer"
                  ? "Среда разработки"
                  : "Клиентский кабинет"}
            </div>
          </div>
        </div>

        <nav className="sidebar__nav">
          {navItems.map((item) => (
            <button
              key={item.id}
              type="button"
              className={
                "sidebar__item" +
                (visiblePage === item.id ? " sidebar__item--active" : "")
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
            <div className="sidebar__avatar">
              {user.email.slice(0, 1).toUpperCase()}
            </div>

            <div>
              <div className="sidebar__user-name">{user.email}</div>
              <div className="sidebar__user-role">
                {role === "owner"
                  ? "Владелец"
                  : role === "developer"
                    ? "Разработчик"
                    : "Клиент"}
              </div>
            </div>
          </div>

          <button
            className="sidebar__logout"
            type="button"
            onClick={handleLogout}
          >
            Выйти
          </button>
        </div>
      </aside>

      <main className="main">
        {visiblePage === "dashboard" && (
          <DashboardPage onOpenAssistant={() => setIsAgentOpen(true)} />
        )}

        {visiblePage === "appointments" && (
          <SessionsPage onOpenAssistant={() => setIsAgentOpen(true)} />
        )}

        {visiblePage === "parts" && <PartsPage />}

        {visiblePage === "ai" && <AiAssistantPage />}

        {visiblePage === "settings" && <SettingsPage />}

        {visiblePage === "client-home" && (
          <section className="page">
            <header className="page__header">
              <div>
                <h1>Мой кабинет</h1>
                <p>Здесь будут ваши записи, услуги и уведомления.</p>
              </div>

              <button
                className="button button--primary"
                type="button"
                onClick={() => setIsAgentOpen(true)}
              >
                Спросить AI
              </button>
            </header>

            <div className="empty-state">
              <div className="empty-state__icon">🏠</div>
              <h2>Клиентский портал</h2>
              <p>
                В следующем шаге подключим ваши записи и ограниченного
                AI-помощника.
              </p>
            </div>
          </section>
        )}

        {["clients", "masters", "services"].includes(visiblePage) && (
          <section className="page">
            <header className="page__header">
              <div>
                <h1>{PAGE_TITLES[visiblePage]}</h1>
                <p>Раздел будет подключён после MVP-дашборда.</p>
              </div>

              <button
                className="button button--primary"
                type="button"
                onClick={() => setIsAgentOpen(true)}
              >
                Спросить AI
              </button>
            </header>

            <div className="empty-state">
              <div className="empty-state__icon">🚧</div>
              <h2>Раздел в разработке</h2>
              <p>Сначала завершим дашборд и страницу записей.</p>
            </div>
          </section>
        )}
      </main>

      {isAgentOpen && <AgentPanel onClose={() => setIsAgentOpen(false)} />}
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
            type="button"
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