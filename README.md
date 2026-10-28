# UCP MVP — Управляемая клиентская платформа

MVP для вертикали «услуги с записью»: Telegram → лид/клиент → запись → подтверждение → визит → отчёт.

## Стек

- EspoCRM — CRM-ядро
- Docker Compose — локальное и серверное окружение
- MariaDB — база данных EspoCRM
- Redis — кэш и очереди
- Python + FastAPI — Telegram-адаптер
- Telegram Bot API — подтверждение записей и напоминания

## Быстрый старт

1. Скопируйте переменные окружения:

```bash
copy .env.example .env
```

2. Заполните `.env`.

3. Запустите CRM:

```bash
docker compose up -d database redis espocrm
```

4. Откройте EspoCRM:

```text
http://localhost:8080
```

5. Создайте администратора EspoCRM при первом входе.

6. Создайте API-пользователя в EspoCRM:

- Administration → Users → Create User
- Role: минимальные права на Contact, Lead, Appointment, Task
- API access: включить
- Скопируйте API key в `.env`

7. Запустите Telegram-сервис:

```bash
docker compose up -d --build telegram
```

## Первый продукт

```text
Клиент пишет в Telegram
→ создаётся Lead в EspoCRM
→ администратор создаёт Appointment
→ Telegram-сервис отправляет подтверждение
→ клиент нажимает «Подтвердить»
→ статус Appointment = confirmed
```

## Что не входит в MVP

- Автоматическая отмена и перенос записей
- Касса, фискализация и возвраты
- WhatsApp и VK
- Двусторонняя интеграция с 1С
- Мультиагентный AI
- On-premise
