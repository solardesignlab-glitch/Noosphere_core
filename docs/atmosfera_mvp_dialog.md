# Атмосфера — сборка MVP на EspoCRM

## 1. Текущий статус проекта

Проект запускается локально через Docker Compose.

- MariaDB и Redis работают.
- EspoCRM доступен по адресу: `http://localhost:8081`.
- Созданы базовые сущности: `Appointment`, `Master`, `Service`.
- Подключён кастомный стиль «Атмосфера» через `atmosfera.css`.
- Telegram-контейнер запущен, но Telegram-бот пока не настроен.

Проверка логов EspoCRM:

```powershell
docker compose logs --tail 40 espocrm
```

Признак успешного подключения стиля:

```text
GET /client/custom/css/atmosfera.css 200
```

## 2. Архитектура системы

```text
Клиент
  ↓
Telegram-бот
  ↓
Telegram-сервис
  ↓
EspoCRM API
  ↓
MariaDB
  ↓
Уведомления / напоминания / аналитика
```

| Компонент | Роль | Статус |
|---|---|---|
| Docker Compose | Запуск всех сервисов локально | Работает |
| MariaDB | Хранение данных EspoCRM | Работает |
| Redis | Кэш, очереди, сессии | Работает |
| EspoCRM | CRM, записи, мастера, услуги, клиенты | Работает |
| Telegram-сервис | Приём сообщений, создание записей | Запущен, не настроен |
| Telegram-бот | Интерфейс клиента | Нужен токен |
| Уведомления | Подтверждения, напоминания, отмены | Не реализовано |
| Аналитика | Загрузка мастеров, выручка, no-show | Не реализовано |

## 3. Что нужно для минимальной работы

Для рабочего MVP необходимы:

1. Настроенный EspoCRM: язык, меню, поля, роли, тестовые данные.
2. Модель данных: клиенты, мастера, услуги, записи, статусы, источники.
3. API-доступ: отдельный пользователь `api_user`.
4. Telegram-бот: токен от BotFather и ID администратора.
5. Telegram-сервис: обработка диалога записи и создание записи через EspoCRM API.
6. Уведомления: подтверждение записи и напоминание за 24 часа.

## 4. Настройка EspoCRM

### Язык

```text
Администрирование → Настройки → Язык → Russian (ru_RU)
```

Затем:

```text
Администрирование → Очистить кэш
```

И обновить страницу:

```text
Ctrl + F5
```

### Меню «Атмосфера»

```text
Администрирование → Пользовательский интерфейс → Список вкладок
```

Рекомендуемое меню:

```text
Дашборд
Записи
Мастера
Услуги
Контакты
Маркетинг
Продажи
Аналитика
Настройки
```

На старте можно скрыть неиспользуемые модули: Лиды, Сделки, Кампании, Кейсы, Учётные записи.

### Русские названия сущностей

```text
Администрирование → Диспетчер сущностей
```

| Сущность | Название |
|---|---|
| Appointment | Записи |
| Master | Мастера |
| Service | Услуги |

## 5. Модель данных

### Клиент — Contact

| Поле | Тип | Пример |
|---|---|---|
| Имя | Text | Анна |
| Фамилия | Text | Иванова |
| Телефон | Phone | +7 999 123-45-67 |
| Email | Email | anna@example.com |
| Telegram ID | Text | 123456789 |
| Telegram username | Text | @anna |
| Источник | Enum | Telegram, Instagram, Сайт, Рекомендация |
| Заметки | Text | Предпочитает вечерние записи |

### Мастер — Master

| Поле | Тип | Пример |
|---|---|---|
| Имя | Text | Анна |
| Специализация | Text | Маникюр, педикюр |
| Телефон | Phone | +7 999 123-45-67 |
| Telegram ID | Text | 123456789 |
| График работы | Text | Пн–Сб, 10:00–19:00 |
| Активен | Boolean | Да |
| Фото | Image | — |
| Заметки | Text | Работает с детскими записями |

### Услуга — Service

| Поле | Тип | Пример |
|---|---|---|
| Название | Text | Маникюр |
| Категория | Text | Ногтевой сервис |
| Длительность | Integer | 60 |
| Цена | Currency | 2 500 |
| Активна | Boolean | Да |
| Описание | Text | Классический маникюр с покрытием |
| Подходящие мастера | Relation | Анна, Ольга |

### Запись — Appointment

| Поле | Тип | Пример |
|---|---|---|
| Клиент | Relation | Contact |
| Мастер | Relation | Master |
| Услуга | Relation | Service |
| Дата и время начала | DateTime | 2026-10-28 15:00 |
| Длительность | Integer | 60 |
| Статус | Enum | new |
| Источник | Enum | Telegram |
| Цена | Currency | 2 500 |
| Предоплата | Currency | 500 |
| Заметки | Text | Клиент попросил позднее время |
| Telegram-чат ID | Text | 123456789 |

### Статусы записи

```text
Новая → Подтверждена → Завершена
Новая → Отменена
Новая → Неявка
```

| Статус | Значение |
|---|---|
| `new` | Новая |
| `confirmed` | Подтверждена |
| `completed` | Завершена |
| `cancelled` | Отменена |
| `no_show` | Неявка |

## 6. Роли пользователей

| Роль | Доступ |
|---|---|
| Owner | Полный доступ: финансы, записи, мастера, услуги, клиенты, аналитика |
| Administrator | Записи, клиенты, мастера, услуги, расписание |
| Master | Только свои записи и свои клиенты |
| Marketer | Лиды, кампании, аналитика |
| Sales | Лиды, сделки, контакты |
| API | Только API-доступ |

Не использовать администратора для Telegram-интеграции. Создать отдельного пользователя `api_user`.

## 7. Telegram-сценарий

Минимальный сценарий:

```text
/start
→ Выберите услугу
→ Выберите мастера
→ Выберите дату
→ Выберите время
→ Подтвердите запись
→ Запись создана
```

Бот должен уметь:

- показывать активные услуги;
- показывать доступных мастеров;
- показывать свободные слоты;
- создавать запись в EspoCRM;
- отправлять подтверждение;
- отправлять напоминание;
- позволять отменить запись.

## 8. EspoCRM API

Telegram-сервис должен уметь:

1. Получать список услуг.
2. Получать список мастеров.
3. Проверять занятость мастера.
4. Создавать запись.
5. Обновлять статус записи.
6. Получать клиента по Telegram ID.
7. Создавать клиента, если его нет.

Пример создания записи:

```json
{
  "name": "Запись: Маникюр",
  "contactId": "client_id",
  "masterId": "master_id",
  "serviceId": "service_id",
  "startAt": "2026-10-28 15:00:00",
  "durationMinutes": 60,
  "status": "new",
  "source": "Telegram",
  "telegramChatId": "123456789"
}
```

## 9. Уведомления

Минимальный набор:

| Событие | Кому | Канал |
|---|---|---|
| Запись создана | Клиенту | Telegram |
| Запись подтверждена | Клиенту | Telegram |
| Напоминание за 24 часа | Клиенту | Telegram |
| Запись отменена | Клиенту | Telegram |

Позже можно добавить:

- напоминание мастеру;
- уведомление администратору;
- запрос оценки после визита;
- win-back-сообщение.

## 10. Важные правила системы

### Часовой пояс

Использовать единый часовой пояс:

```text
Europe/Moscow
```

### Конфликты расписания

Нельзя создавать две записи одному мастеру на одно время.

Проверка:

```text
Мастер + дата + время + статус ≠ отменена
```

### Отмена и неявка

Разделять:

- отмену клиентом;
- отмену администратором;
- неявку клиента.

### Безопасность

- Токены и пароли хранить в `.env`.
- Не коммитить `.env` в Git.
- Использовать отдельного API-пользователя.

### Резервные копии

Настроить ежедневный бэкап MariaDB.

## 11. Маркетинг и продажи

### Структура

```text
Кампания / канал
  ↓
Лид
  ↓
Квалификация
  ↓
Сделка
  ↓
Клиент / Контракт
  ↓
Продление / допродажа
```

### Сущности

| Сущность | Назначение |
|---|---|
| Campaign | Источник трафика и маркетинговая активность |
| Lead | Заявка или потенциальный клиент |
| Opportunity | Сделка / продажа тарифа |
| Account | Компания-клиент |
| Contact | Контактное лицо |
| Document | КП, договор |
| Activity | Звонки, встречи, задачи |

### Поля лида

| Поле | Тип | Пример |
|---|---|---|
| Имя | Text | Анна |
| Фамилия | Text | Иванова |
| Телефон | Phone | +7 999 123-45-67 |
| Email | Email | anna@example.com |
| Компания | Text | Салон «Атмосфера» |
| Город | Text | Москва |
| Источник | Enum | Telegram, Instagram, Сайт, Рекомендация |
| Кампания | Relation | Instagram Ads — октябрь |
| Статус лида | Enum | Новый, В работе, Квалифицирован, Отклонён |
| Интересующий тариф | Enum | CRM, CRM + Telegram, Enterprise |
| Бюджет | Enum | До 10 тыс., 10–30 тыс., 30+ тыс. |
| Срок запуска | Enum | Срочно, 1 месяц, 2–3 месяца |
| Комментарий | Text | Нужна запись через Telegram |

### Статусы лида

```text
Новый → В работе → Квалифицирован → Создана сделка
Новый → Не целевой
Новый → Потерян
```

### Этапы сделки

```text
Новая заявка
→ Квалификация
→ Демонстрация
→ Коммерческое предложение
→ Согласование
→ Оплата
→ Запуск
```

| Этап | Вероятность | Действие |
|---|---:|---|
| Новая заявка | 10% | Связаться в течение 15 минут |
| Квалификация | 25% | Выяснить нишу, объём, срок |
| Демонстрация | 45% | Показать CRM и Telegram-бота |
| КП | 60% | Отправить предложение |
| Согласование | 75% | Снять возражения |
| Оплата | 90% | Получить оплату |
| Запуск | 100% | Подключить бота и настроить CRM |

### Кампании

Примеры:

```text
Telegram Ads — Москва
Instagram Ads — Салоны красоты
SEO — сайт Атмосфера
Рекомендации партнёров
Холодные звонки
Выставка beauty
```

Метрики:

- количество лидов;
- количество сделок;
- выручка;
- стоимость лида;
- CAC;
- ROI.

## 12. Ролевые интерфейсы

Принцип: одна CRM, но у каждой роли свой рабочий экран.

```text
Владелец → Деньги, рост, загрузка, риски
Администратор → Записи, расписание, клиенты
Мастер → Мои визиты, мои клиенты, услуги
Маркетолог → Лиды, кампании, стоимость лида
Продажник → Сделки, задачи, воронка
```

### Дашборд владельца

- Выручка за сегодня, неделю, месяц.
- Количество записей.
- Новые клиенты.
- Загрузка мастеров.
- Средний чек.
- Отмены и неявки.
- Топ-услуги.
- Топ-мастера.

### Дашборд администратора

- Записи на сегодня.
- Свободные слоты.
- Ожидающие подтверждения.
- Клиенты, которые должны прийти.
- Отмены за сегодня.
- Задачи.
- Быстрое создание записи.

### Дашборд мастера

- Мои записи на сегодня.
- Следующий клиент.
- Мои клиенты.
- Мои услуги.
- История визитов.
- Заметки по клиенту.
- Моя выручка за день.

### Дашборд маркетолога

- Новые лиды.
- Лиды по источникам.
- Стоимость лида.
- Конверсия лид → запись.
- Активные кампании.
- Лучшие каналы.
- Возврат клиентов.

### Дашборд продажника

- Мои сделки по этапам.
- Задачи на сегодня.
- Просроченные контакты.
- Новые лиды.
- Демо на сегодня.
- Сумма сделок в работе.
- Закрытые сделки за месяц.

## 13. Дизайн-система «Атмосферы»

### Цвета

```css
:root {
  --atm-bg: #F7F8FA;
  --atm-surface: #FFFFFF;
  --atm-text: #101828;
  --atm-muted: #667085;
  --atm-border: #EAECF0;

  --atm-primary: #5B5BD6;
  --atm-primary-dark: #3F3FB8;
  --atm-primary-soft: #EEEDFB;

  --atm-accent: #FFB86B;
  --atm-accent-soft: #FFF3E4;

  --atm-success: #12B76A;
  --atm-success-soft: #E7F8F0;

  --atm-warning: #F79009;
  --atm-warning-soft: #FFF4E0;

  --atm-danger: #F04438;
  --atm-danger-soft: #FDECEA;

  --atm-radius: 14px;
  --atm-radius-lg: 18px;
}
```

### Типографика

```css
font-family: Inter, sans-serif;
```

- Заголовки: 18–24 px, вес 600–700.
- Основной текст: 14 px.
- Вторичный текст: 12–13 px.
- KPI: 24–32 px, вес 700.

### Карточки

```css
border-radius: 18px;
border: 1px solid #EAECF0;
box-shadow: 0 12px 32px rgba(16, 24, 40, 0.06);
```

### Кнопки

```css
border-radius: 12px;
font-weight: 600;
```

Главная кнопка — сине-фиолетовый градиент, вторичная — белая с серой рамкой.

## 14. Полный файл atmosfera.css

```css
/* ==========================================================
   Атмосфера — custom theme for EspoCRM
   ========================================================== */

:root {
  --atm-bg: #F7F8FA;
  --atm-surface: #FFFFFF;
  --atm-text: #101828;
  --atm-muted: #667085;
  --atm-border: #EAECF0;

  --atm-primary: #5B5BD6;
  --atm-primary-dark: #3F3FB8;
  --atm-primary-soft: #EEEDFB;

  --atm-accent: #FFB86B;
  --atm-accent-soft: #FFF3E4;

  --atm-success: #12B76A;
  --atm-success-soft: #E7F8F0;

  --atm-warning: #F79009;
  --atm-warning-soft: #FFF4E0;

  --atm-danger: #F04438;
  --atm-danger-soft: #FDECEA;

  --atm-radius: 14px;
  --atm-radius-lg: 18px;
  --atm-shadow: 0 1px 3px rgba(16, 24, 40, 0.06);
  --atm-shadow-hover: 0 12px 32px rgba(16, 24, 40, 0.08);
}

body {
  background:
    radial-gradient(circle at 10% 0%, rgba(91, 91, 214, 0.08), transparent 40%),
    radial-gradient(circle at 90% 100%, rgba(255, 184, 107, 0.10), transparent 45%),
    var(--atm-bg);
  color: var(--atm-text);
  font-family: Inter, -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
}

a,
.link {
  color: var(--atm-primary);
}

a:hover,
.link:hover {
  color: var(--atm-primary-dark);
}

h1,
h2,
h3,
h4 {
  color: var(--atm-text);
  font-weight: 650;
  letter-spacing: -0.01em;
}

.navbar {
  background-color: rgba(255, 255, 255, 0.95);
  border-bottom: 1px solid var(--atm-border);
  box-shadow: none;
  backdrop-filter: blur(10px);
}

.navbar .navbar-brand,
.navbar .app-name {
  color: var(--atm-text);
  font-weight: 700;
  letter-spacing: -0.02em;
}

.navbar .navbar-nav > li > a,
.navbar .dropdown-toggle {
  color: var(--atm-muted);
}

.navbar .navbar-nav > li > a:hover,
.navbar .dropdown-toggle:hover {
  color: var(--atm-text);
  background-color: var(--atm-primary-soft);
}

.navbar-side,
.side-menu,
#nav-menu {
  background: rgba(255, 255, 255, 0.92);
  border-right: 1px solid var(--atm-border);
  backdrop-filter: blur(10px);
}

.navbar-side .nav > li > a,
#nav-menu .nav > li > a {
  color: var(--atm-muted);
  font-weight: 600;
  border-radius: 12px;
  margin: 2px 8px;
  padding: 10px 14px;
  transition: background-color 0.15s ease, color 0.15s ease;
}

.navbar-side .nav > li > a:hover,
#nav-menu .nav > li > a:hover {
  background-color: var(--atm-primary-soft);
  color: var(--atm-primary-dark);
}

.navbar-side .nav > li.active > a,
#nav-menu .nav > li.active > a,
.navbar-side .nav > li.selected > a,
#nav-menu .nav > li.selected > a {
  background: linear-gradient(135deg, #5B5BD6, #3F3FB8);
  color: #FFFFFF;
  box-shadow: 0 8px 20px rgba(91, 91, 214, 0.28);
}

.panel,
.panel-default,
.record-panel,
.dashboard-card,
.list-group-item {
  background-color: var(--atm-surface);
  border: 1px solid rgba(234, 236, 240, 0.9);
  border-radius: var(--atm-radius-lg);
  box-shadow:
    0 1px 2px rgba(16, 24, 40, 0.04),
    0 12px 32px rgba(16, 24, 40, 0.06);
}

.panel-heading,
.panel-default > .panel-heading {
  background-color: transparent;
  border-bottom: 1px solid var(--atm-border);
  color: var(--atm-text);
  font-weight: 600;
}

.panel-body {
  padding: 18px;
}

.btn {
  border-radius: 12px;
  font-weight: 600;
  transition: all 0.15s ease;
}

.btn-primary,
.btn.btn-primary {
  background: linear-gradient(135deg, #5B5BD6, #3F3FB8);
  border: none;
  color: #FFFFFF;
  box-shadow: 0 6px 16px rgba(91, 91, 214, 0.25);
}

.btn-primary:hover,
.btn.btn-primary:hover,
.btn-primary:focus,
.btn.btn-primary:focus {
  background: linear-gradient(135deg, #4B4BC7, #3535A8);
  border: none;
  color: #FFFFFF;
  transform: translateY(-1px);
  box-shadow: 0 10px 24px rgba(91, 91, 214, 0.32);
}

.btn-default,
.btn.btn-default {
  background-color: var(--atm-surface);
  border-color: var(--atm-border);
  color: var(--atm-text);
}

.btn-default:hover,
.btn.btn-default:hover {
  background-color: var(--atm-primary-soft);
  border-color: var(--atm-primary-soft);
  color: var(--atm-primary-dark);
}

.form-control,
input[type="text"],
input[type="email"],
input[type="password"],
input[type="number"],
select,
textarea {
  background-color: var(--atm-surface);
  border: 1px solid var(--atm-border);
  border-radius: 12px;
  color: var(--atm-text);
  box-shadow: none;
}

.form-control:focus,
input:focus,
select:focus,
textarea:focus {
  border-color: var(--atm-primary);
  box-shadow: 0 0 0 3px rgba(91, 91, 214, 0.15);
  outline: none;
}

.table > thead > tr > th {
  background-color: #FBFBFD;
  border-bottom: 1px solid var(--atm-border);
  color: var(--atm-muted);
  font-size: 12px;
  font-weight: 700;
  letter-spacing: 0.02em;
  text-transform: uppercase;
}

.table > tbody > tr > td {
  border-top: 1px solid var(--atm-border);
  vertical-align: middle;
}

.table-hover > tbody > tr:hover > td,
.table-hover > tbody > tr:hover > th {
  background-color: #F4F4FF;
}

.label,
.badge {
  border-radius: 999px;
  font-size: 11px;
  font-weight: 700;
  padding: 4px 10px;
}

.label-success,
.badge-success {
  background-color: var(--atm-success-soft);
  color: #027A48;
}

.label-warning,
.badge-warning {
  background-color: var(--atm-warning-soft);
  color: #B54708;
}

.label-danger,
.badge-danger {
  background-color: var(--atm-danger-soft);
  color: #B42318;
}

.label-primary,
.badge-primary,
.label-info,
.badge-info {
  background-color: var(--atm-primary-soft);
  color: var(--atm-primary-dark);
}

.dashboard .panel,
#dashboard .panel {
  border-radius: var(--atm-radius-lg);
}

.login-page,
#login-page,
body.login {
  background:
    radial-gradient(circle at 15% 20%, rgba(91, 91, 214, 0.16), transparent 45%),
    radial-gradient(circle at 85% 80%, rgba(255, 184, 107, 0.20), transparent 45%),
    var(--atm-bg);
}

::-webkit-scrollbar {
  width: 10px;
  height: 10px;
}

::-webkit-scrollbar-thumb {
  background: #D0D5DD;
  border-radius: 999px;
}

::-webkit-scrollbar-thumb:hover {
  background: #98A2B3;
}

@media (max-width: 767px) {
  .navbar-side,
  .side-menu,
  #nav-menu {
    border-right: none;
  }

  .btn {
    min-height: 44px;
  }
}
```

## 15. Порядок дальнейшей сборки

1. Настроить EspoCRM: язык, меню, поля, статусы, роли.
2. Создать тестовые услуги, мастеров и клиентов.
3. Создать API-пользователя.
4. Получить токен Telegram-бота.
5. Настроить Telegram-сервис.
6. Реализовать сценарий записи.
7. Реализовать подтверждение и отмену.
8. Добавить напоминания.
9. Сделать дашборды для ролей.
10. Добавить маркетинг и продажи.
11. После стабильного MVP подключать оплаты, WhatsApp, VK, iiko, Set Prisma, Poster и AI.

## 16. Интеграции

| Интеграция | Нужна для MVP? | Когда добавлять |
|---|---|---|
| Telegram | Да | Сейчас |
| EspoCRM API | Да | Сейчас |
| Оплата / предоплата | Нет | После проверки спроса |
| iiko | Нет | Для общепита |
| Set Prisma | Нет | Для салонов красоты |
| Poster | Нет | Для общепита |
| WhatsApp | Нет | После Telegram |
| VK | Нет | После Telegram |
| AI-ассистент | Нет | После стабильного MVP |
