# PROJECT-INVENTORY — Атмосфера OS

Версия: 3.0 (сводный атлас после консолидации 2026-11-14)
Дата: 2026-11-14
Метод: факты из терминала + живые сессии разработки; противоречия источников помечены.
История: v2.0 от 2026-11-13 описывал состояние до merge atmoos; устаревшее перенесено в git-историю (коммиты 9b07d5b, e4160f3).

## 1. Цели проекта

- Бизнес: экосистема управления бизнесом в сфере услуг — CRM, контент-движок, обучение, сайт.
- Продукт: MVP «Атмосфера OS» — базовое ядро, пакет Beauty, AI-ассистент, дашборд владельца.
- Критерии MVP: 10 платящих пилотов, запуск до 30 дней, churn 6 мес ниже 5%, NPS выше 40.
- Источник истины по видению: docs/vision_master_document.md.

## 2. Терминология (глоссарий)

| Термин | Что это | Зачем |
| --- | --- | --- |
| Organization (tenant) | Салон как изолированный арендатор. Все данные размечены organization_id | Мультиарендность: несколько салонов на одной платформе |
| Owner | Владелец салона, полные права в своей организации | Первый пользователь, создаётся через seedOwner при старте |
| seedOwner | Функция в server.js: создаёт организацию и owner из переменных окружения, если их нет | Автоматическая инициализация при запуске |
| tenantContext | Middleware: по токену определяет organization_id и кладёт в req | Каждый запрос видит только данные своего салона |
| Appointments | Записи клиентов на сеансы | Ядро CRM; таблица уже в каноне схемы (0004) |
| Services / Masters | Услуги и мастера салона | Каталог и расписание |
| EspoCRM | Open-source CRM (PHP), работает в Docker на 8081 | Второй контур CRM с кастомными сущностями; статус «основной/отложенный» — спорный (см. п. 9) |
| Session (EspoCRM) | Запись на сеанс в EspoCRM | Сущность с хуком OverlapCheck — готовая логика защиты от двойной записи |
| CMaster, CService | Кастомные сущности EspoCRM (мастер, услуга) | Зеркало понятий MVP внутри CRM |
| Ollama | Локальный AI-движок на 11434 | Единственный AI-провайдер MVP; backend ходит в него через OpenAI-совместимый API |
| Vite | Dev-сервер и сборщик фронтенда (5173) | Разработка React-приложения |
| Monorepo | Один репозиторий: apps/api, apps/web, services, docs | Единая история и версии |

## 3. Инструментарий

| Слой | Технология | Порт/детали |
| --- | --- | --- |
| Backend | Node.js + Express + mysql2 | 4000 |
| Frontend | React + Vite | 5173 |
| БД | MySQL-протокол, контейнер ucp_database | 3307 наружу (3306 внутри) |
| Telegram | Python, FastAPI (routers: telegram, appointments, ai) | 8090 → 8000 внутри |
| CRM | PHP + EspoCRM | 8081 |
| AI | Ollama | 11434 |
| Кэш | Redis (ucp_redis) | только внутренний |
| Инфра | Docker Desktop, docker-compose | — |
| Скрипты | start-dev.bat / start.bat / start.ps1, scripts/ | запуск окружения |
| Версионирование | Git (GitHub: Noosphere_core) | — |

## 4. Карта живых модулей (пост-консолидация)

- apps/api — Backend API. auth (register/login/me), CRUD клиентов и услуг, media, AI-чат, agent propose-code, интеграция EspoCRM (espocrmRequest), registerServiceRoutes (src/routes/services.js). Эндпоинты /api/parts отсутствуют; наследие (PartsPage, api/parts.js, FileManager, AiPanel) удалено 2026-11-14.
- apps/api/migrations — ЕДИНСТВЕННЫЙ канон схемы: 0001 masters, 0002 services, 0003 clients, 0004 appointments. Сверены с живой БД через SHOW CREATE TABLE (коммит e4160f3): индексы и коллация uca1400_ai_ci выровнены.
- apps/api/db-migrate.js — ЕДИНСТВЕННЫЙ runner миграций; статус: npm run db:migrate / db:status (Applied: 4, Pending: 0).
- apps/api/src — модульный каркас: config/env, shared/db/pool, shared/middleware/tenantContext, routes/health, routes/services, integrations/espocrm-adapter.
- apps/web — канонический фронтенд (бывший apps/web-archive, переименован 2026-11-14, коммит 9b07d5b). Страницы: Dashboard, Appointments, Clients, Services, Masters, Parts, AiAssistant, AiModels, Media, Sessions, Login + дизайн-система. Ходит напрямую на http://localhost:4000.
- services/telegram — FastAPI: роутеры telegram, appointments, ai; сервисы appointment_service, espo_service, telegram_api. Ходит в EspoCRM (espo_service).
- scripts/smoke-services.mjs, scripts/smoke-appointments.mjs — смоук-проверки API (пришли из merge atmoos).
- agents/ — агенты разработки: feature-builder, qa-runner, repo-guardian.
- docs/archive — артефакты снесённого дубля frontend/ (StatusCheck, TASKS, ROADMAP).

## 5. EspoCRM-слой

- Кастомные сущности: Session, Specialist, Offer, Expense, PersonalProject, CMaster, CService.
- Переводы на 25+ языков, метаданные, хук Session/OverlapCheck (защита от пересечения записей).
- Открытый вопрос: HANDOFF называет контур «параллельным/отложенным», инвентаризация видит контейнер живым. Telegram-сервис и web-фронтенд имеют espocrm-клиенты. Решить, основной ли это контур для салона или параллельный.
- espocrm-dump.sql из п. 6 v2.0 отсутствует в git ls-files — проверить, существует ли физически.

## 6. Архивы и мусор (остаток после консолидации)

| Объект | Что это | Вердикт |
| --- | --- | --- |
| backend-archive | Старый бэкенд (ai, rbac, tenancy — частично мигрировали) | Кандидат на удаление после сверки |
| new-react-project-archive | Обломок дубля фронтенда: два файла, один с опечаткой «.jsxcd» | Кандидат на удаление |
| PROJECT-AUDIT.new.md | Черновик аудита в корне | Удалить (канон — docs/audit/PROJECT-AUDIT.md) |
| check.php, fix-enums.sql, folders.txt, frontend-list.txt, revision_results.txt | Разовые артефакты в корне | Просмотреть и удалить |
| espocrm-dump.sql | Дамп БД | Проверить существование; если есть — backups или удаление |

Выполнено 2026-11-14: apps/web-archive переименован в apps/web; frontend/ удалён (уникальное — в docs/archive); корневой package-lock.json удалён; run-clients-migration.mjs удалён; дубли runner'ов и db/ зачищены (e4160f3 и ранее).

## 7. Ветки

| Ветка | Состояние | Вердикт |
| --- | --- | --- |
| main | Активная; консолидация закоммичена (e4160f3, 9b07d5b) | Рабочая; запушить |
| backup-before-consolidation | Страховочный снапшот перед консолидацией | Проверить main..ветку; если уникальных коммитов нет — удалить |
| rename/atmoos | Существует локально и на origin; источник merge ee32ff6 | Содержимое уже влилось в main; решить имя проекта |

Открытый вопрос идентичности: UCP / Атмосфера / Atmoos / Noosphere_core — нужно выбрать официальное имя.

## 8. Статус функций MVP (актуально на 2026-11-14)

| Функция | Статус |
| --- | --- |
| Клиенты | Работает; схема выровнена с каноном |
| Услуги | Работает (роутер, схема, страница) |
| Мастера | Страница и схема есть (MastersPage, 0001); сверка роутера — в плане |
| Регистрация и вход | Работает |
| AI-чат | В работе, оба пути идут в Ollama |
| Дашборд владельца | В работе |
| Записи (appointments) | Таблица в каноне (0004), страница обновлена merge atmoos; сверка роутера — в плане |
| Контент-конвейер (WhisperX, FFmpeg) | Не начато |
| Telegram-уведомления | Контейнер живёт; мост к MVP не проверен |
| 1С, кассы, B-roll | Вне скоупа MVP |

## 9. Риски

1. Имя проекта не выбрано (4 варианта).
2. Судьба EspoCRM-контура не решена (основной или параллельный).
3. Пароль БД светился в переписке — сменить.
4. Комментарии в .env не в UTF-8.
5. Блок schema_migrations внутри src/modules/tenancy/migrations.sql — второй источник истины о схеме (находка аудита №9); устранить в бэклоге.
6. Закрыто сверкой 2026-11-14: клиенты/мастера/записи живы. Мёртвыми были Parts (/api/parts), FileManager (/api/files), AiPanel (/api/ai/task) — удалены. AiModelsPage требует починки (/api/ai/models, /api/ai/test не существуют; живой роут — /api/models).

## 10. Следующие шаги

1. Сверить API-роуты apps/api со страницами apps/web (clients/masters/parts — ожидаются расхождения).
2. Сверить ветки: git log main..backup-before-consolidation --oneline и то же для rename/atmoos; принять вердикты из п. 7.
3. Решить официальный вопрос идентичности (п. 7).
4. Запушить main.
