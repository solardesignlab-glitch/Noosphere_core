import { useEffect, useState } from "react";

const API_BASE = "http://localhost:8090";

const PROVIDERS = [
  {
    id: "ollama",
    name: "Ollama",
    status: "connected",
    endpoint: "http://localhost:11434",
    modelsCount: 3
  },
  {
    id: "openrouter",
    name: "OpenRouter",
    status: "disconnected",
    endpoint: "https://openrouter.ai/api/v1",
    modelsCount: 0
  },
  {
    id: "local_image",
    name: "ComfyUI",
    status: "disconnected",
    endpoint: "http://127.0.0.1:8188",
    modelsCount: 0
  }
];

const ROLES = [
  {
    id: "ux_assistant",
    title: "UX-ассистент",
    description: "Структура экранов, тексты, UX-сценарии",
    provider: "ollama",
    model: "qwen2.5:7b"
  },
  {
    id: "code_assistant",
    title: "Код-ассистент",
    description: "React-компоненты, CSS, рефакторинг",
    provider: "ollama",
    model: "qwen2.5-coder:7b"
  },
  {
    id: "client_chat",
    title: "Клиентский AI-чат",
    description: "Ответы администратору и подсказки",
    provider: "ollama",
    model: "qwen2.5:7b"
  },
  {
    id: "image_generator",
    title: "Генерация изображений",
    description: "UI-макеты и визуальные концепты",
    provider: "local_image",
    model: "flux1-schnell-fp8"
  }
];

export default function AiModelsPage() {
  const [roles, setRoles] = useState(ROLES);
  const [selectedRole, setSelectedRole] = useState("ux_assistant");
  const [testPrompt, setTestPrompt] = useState(
    "Составь структуру дашборда администратора"
  );
  const [testResult, setTestResult] = useState("");
  const [testing, setTesting] = useState(false);

  const [apiModels, setApiModels] = useState([]);
  const [apiStatus, setApiStatus] = useState("loading");
  const [apiError, setApiError] = useState("");

  useEffect(() => {
    const loadModels = async () => {
      try {
        const response = await fetch(`${API_BASE}/api/ai/models`);
        const data = await response.json();

        if (!response.ok) {
          throw new Error(data.detail || "Ошибка загрузки моделей");
        }

        setApiModels(data.models || []);
        setApiStatus("connected");
      } catch (error) {
        setApiStatus("error");
        setApiError(error.message);
      }
    };

    loadModels();
  }, []);

  const updateRole = (roleId, field, value) => {
    setRoles((prev) =>
      prev.map((role) =>
        role.id === roleId ? { ...role, [field]: value } : role
      )
    );
  };

  const runTest = async () => {
    const role = roles.find((item) => item.id === selectedRole);

    setTesting(true);
    setTestResult("");

    try {
      const response = await fetch(`${API_BASE}/api/ai/test`, {
        method: "POST",
        headers: {
          "Content-Type": "application/json"
        },
        body: JSON.stringify({
          model: role.model,
          message: testPrompt,
          systemPrompt:
            "Ты UX-архитектор CRM «Атмосфера». Отвечай кратко, по-русски и без выдумок."
        })
      });

      const data = await response.json();

      if (!response.ok) {
        throw new Error(data.detail || "Модель не ответила");
      }

      setTestResult(data.reply);
    } catch (error) {
      setTestResult(`Ошибка: ${error.message}`);
    } finally {
      setTesting(false);
    }
  };

  return (
    <div className="ai-models">
      <div className="provider-grid">
        {PROVIDERS.map((provider) => (
          <article
            key={provider.id}
            className={`provider-card provider-card--${provider.status}`}
          >
            <div className="provider-card__header">
              <strong>{provider.name}</strong>
              <span className="provider-card__status">
                {provider.status === "connected" ? "Подключён" : "Не подключён"}
              </span>
            </div>

            <p>{provider.endpoint}</p>
            <span>Моделей: {provider.modelsCount}</span>
          </article>
        ))}
      </div>

      <section className="card">
        <div className="card__header">
          <div>
            <h2>Роли моделей</h2>
            <p>Выберите модель для каждой AI-задачи</p>
          </div>
        </div>

        <div className="role-grid">
          {roles.map((role) => (
            <article key={role.id} className="role-card">
              <h3>{role.title}</h3>
              <p>{role.description}</p>

              <label>
                Провайдер
                <select
                  value={role.provider}
                  onChange={(event) =>
                    updateRole(role.id, "provider", event.target.value)
                  }
                >
                  <option value="ollama">Ollama</option>
                  <option value="openrouter">OpenRouter</option>
                  <option value="local_image">ComfyUI</option>
                </select>
              </label>

              <label>
                Модель
                <input
                  value={role.model}
                  onChange={(event) =>
                    updateRole(role.id, "model", event.target.value)
                  }
                />
              </label>

              <button
                className={
                  "button button--small" +
                  (selectedRole === role.id ? " button--primary" : "")
                }
                onClick={() => setSelectedRole(role.id)}
              >
                {selectedRole === role.id ? "Выбрана" : "Выбрать для теста"}
              </button>
            </article>
          ))}
        </div>
      </section>

      <section className="card">
        <div className="card__header">
          <div>
            <h2>Каталог моделей</h2>
            <p>
              {apiStatus === "connected"
                ? `Ollama подключён. Доступно моделей: ${apiModels.length}`
                : apiStatus === "loading"
                ? "Загружаем модели из Ollama..."
                : "Ollama недоступен"}
            </p>
          </div>

          <button
            className="button button--ghost"
            onClick={() => window.location.reload()}
          >
            Обновить
          </button>
        </div>

        {apiStatus === "error" && <div className="test-result">{apiError}</div>}

        <div className="table-wrapper">
          <table className="models-table">
            <thead>
              <tr>
                <th>Модель</th>
                <th>Провайдер</th>
                <th>Параметры</th>
                <th>Контекст</th>
                <th>Статус</th>
              </tr>
            </thead>

            <tbody>
              {apiModels.map((model) => (
                <tr key={model.id}>
                  <td>
                    <strong>{model.name}</strong>
                  </td>
                  <td>{model.provider}</td>
                  <td>
                    {model.parameterSize} · {model.quantization}
                  </td>
                  <td>
                    {model.contextLength?.toLocaleString("ru-RU")} токенов
                  </td>
                  <td>
                    <span className="status status--completed">Установлена</span>
                  </td>
                </tr>
              ))}

              {apiStatus === "loading" && (
                <tr>
                  <td colSpan={5}>Загрузка...</td>
                </tr>
              )}

              {apiStatus === "error" && (
                <tr>
                  <td colSpan={5}>Не удалось получить модели из Ollama</td>
                </tr>
              )}
            </tbody>
          </table>
        </div>
      </section>

      <section className="card">
        <div className="card__header">
          <div>
            <h2>Тест модели</h2>
            <p>Проверка выбранной роли и модели</p>
          </div>
        </div>

        <div className="test-panel">
          <label>
            Роль
            <select
              value={selectedRole}
              onChange={(event) => setSelectedRole(event.target.value)}
            >
              {roles.map((role) => (
                <option key={role.id} value={role.id}>
                  {role.title}
                </option>
              ))}
            </select>
          </label>

          <label>
            Запрос
            <textarea
              rows={3}
              value={testPrompt}
              onChange={(event) => setTestPrompt(event.target.value)}
            />
          </label>

          <button
            className="button button--primary"
            onClick={runTest}
            disabled={testing}
          >
            {testing ? "Проверяем..." : "Отправить тест"}
          </button>

          {testResult && <div className="test-result">{testResult}</div>}
        </div>
      </section>
    </div>
  );
}