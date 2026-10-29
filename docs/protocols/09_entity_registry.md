# Реестр сущностей

Этот файл является единственным источником истины по сущностям проекта.

Перед созданием новой сущности обязательно проверить этот реестр.

## Правила

- Одна бизнес-сущность — одна запись в реестре.
- Нельзя создавать сущность, если уже есть аналогичная.
- При изменении сущности обновлять её статус и назначение.
- Удаление или переименование сущности фиксируется в `07_decision_log.md`.

## Статусы

| Статус | Значение |
|---|---|
| Planned | Планируется |
| In progress | Создаётся или настраивается |
| Active | Используется |
| Deprecated | Больше не используется |
| Merged | Объединена с другой сущностью |
| Frozen | Сохранена, но не развивается |

## Ядро платформы

| Сущность | Название | Статус | Назначение | Ключевые поля |
|---|---|---|---|---|
| CParty | Участник рынка | Planned | Единый объект физлица или компании: клиент, партнёр, поставщик | name, partyType, status, country |
| COrganization | Организация | Planned | Юрлицо или компания участника | name, inn, country, legalForm, status |
| CPartner | Партнёр | Planned | Партнёрские отношения участника | party, organization, partnerType, status |
| COffer | Предложение | Planned | Общее предложение рынка: товар или услуга | name, offerType, category, status |
| CProduct | Товар | Planned | Материальный товар | offer, sku, unit, stockType |
| CDeal | Сделка | Planned | Коммерческая операция между участниками | party, offer, amount, currency, status |
| CFinanceRecord | Финансовая операция | Planned | Доход, расход, амортизация, износ | date, amount, currency, recordType, category |
| CBusinessModel | Бизнес-модель | Planned | Модель деятельности для наблюдения | name, owner, status, country |
| CIndicator | Показатель | Planned | Метрика бизнес-модели | name, code, unit, calculationType, frequency |
| CIndicatorValue | Значение показателя | Planned | Фактическое значение показателя | indicator, businessModel, value, measuredAt, sourceType |
| CResourceSnapshot | Снимок ресурса | Planned | Ручной учёт ресурсов и финансовых показателей | businessModel, resourceType, name, value, unit, measuredAt |

## Замороженная вертикаль «услуги с записью»

| Сущность | Название | Статус | Назначение | Ключевые поля |
|---|---|---|---|---|
| CMaster | Мастера | Frozen | Хранение мастеров замороженной вертикали | Имя, телефон, специализация |
| CService | Услуги | Frozen | Каталог услуг замороженной вертикали | Название, длительность, цена |
| CAppointment | Записи | Frozen | Запись клиента к мастеру | Клиент, мастер, услуга, дата, статус |

## Связи ядра

```text
CParty → COrganization
CParty → CPartner
CParty → CDeal

COffer → CProduct
COffer → CService

CParty → CDeal ← COffer
CDeal → CFinanceRecord

CBusinessModel → CIndicator
CIndicator → CIndicatorValue
CBusinessModel → CIndicatorValue

CBusinessModel → CResourceSnapshot
```

## Правило услуг

Существующая сущность `CService` сохраняется для замороженной вертикали «услуги с записью».

В ядре платформы услуги описываются через `COffer` с типом `service`.

Это предотвращает дублирование сущности услуг.

## Правило создания новой сущности

Перед созданием ответить на вопросы:

1. Какой бизнес-объект она описывает?
2. Есть ли уже сущность для этого объекта?
3. Какие у неё ключевые поля?
4. С какими сущностями она связана?
5. Какой у неё статус?
6. Как изменение будет зафиксировано?

Если хотя бы один ответ неизвестен — сущность не создаётся.