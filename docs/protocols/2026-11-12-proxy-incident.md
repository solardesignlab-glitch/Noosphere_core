# Протокол: прокси-инцидент и ревизия двойников
**Дата:** 12.11.2026, ~01:00–04:00
**Статус:** закрыт

## Инцидент
Статус-чекаут во фронтенде показывал «Ошибка связи с бэкендом»/404.
Причина: три запущенных Node-сервера (5000/4000/3000) и прокси Vite,
указывавший не на тот порт. Правки вносились в копию `backend/`,
оторвавшуюся от основной разработки.

## Решение
1. Прокси `frontend/vite.config.js` сведён к единому таргету http://localhost:4000.
2. Проведена дифф-ревизия `backend/` vs `apps/api/src` по хешам файлов:
   - SAME ×5 (ai, rbac, tenancy-модели) — перенос не требуется;
   - DIFFER: errors.js, migrations.sql, tenantContext.js — версия монолита
     полноценнее, в `backend/` файлы пустые/устаревшие → оставлен монолит;
   - DIFFER: health.js — в `backend/` живая версия с проверкой БД → перенесён.
3. Уникальные файлы монолита подтверждены: config/env.js,
   integrations/espocrm-adapter.js, shared/db/pool.js, utils/http-error.js.
4. `backend/` переименован в `backend-archive/` (git: rename 100%).

## Проверка
- GET /api/v1/db-audit → 200 (стабильно, три проверки).
- Тело ответа: {"status":"ok","service":"atmosfera-backend","db":"up",
  "tables":["organization_members","organizations","users"]}
- Логин owner@atmosfera.local → успех; localStorage: atmosfera_token,
  atmosfera_user. Сессия держится.

## Коммиты
- d915463 — прокси 4000, перенос db-audit, архивация backend/
- 5f005c7 — фронтенд: единый API-base, живой StatusCheck, auth-фиксы
- e92ce9e — игнор inventory_full.txt

## Откаты
Бэкап перед слиянием: backups/api-src-premerge-20261112-0345
