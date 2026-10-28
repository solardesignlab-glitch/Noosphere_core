# «Атмосфера» — Инструкция по настройке EspoCRM (Этап P0, шаг 1–2)

**Версия:** 1.0
**Дата:** 27.10.2026
**Для:** разработчиков проекта «Атмосфера»
**Связанные документы:** atmosfera_mvp_consolidated.md (v3.0 — источник правды по модели данных), atmosfera_brandbook.md (дизайн-токены atm-*)
**Статус инфраструктуры:** MariaDB, Redis и EspoCRM развёрнуты и работают на `localhost:8081`, кастомная тема подключена.

---

## 1. Что делаем на этом этапе

1. Создаём сущности в EspoCRM через Диспетчер сущностей: `Offer`, `Specialist`, `Session`, `Expense`.
2. Дополняем стандартную сущность `Contact` тремя полями.
3. Реализуем защиту от двойного бронирования хуком BeforeSave.
4. Проверяем по критериям приёмки (раздел 5).
5. Создаём пользователя `api_user` для Telegram-сервиса (раздел 6 — следующий шаг).

Порядок создания сущностей важен: **Offer → Specialist → Session**, потому что `Session` ссылается на остальные через связи.

Всё делается через: **Администрирование → Диспетчер сущностей → Создать сущность**.

---

## 2. Сущности

### 2.1. Offer (Услуга/Продукт)

| Поле | Тип | Опции |
|---|---|---|
| name | Varchar (обяз.) | название |
| price | Currency | цена |
| durationMin | Integer | длительность в минутах |
| category | Enum | категории ниши (зависят от отраслевого профиля) |
| isActive | Boolean | по умолчанию true |
| description | Text | свободное описание |

### 2.2. Specialist (Исполнитель)

| Поле | Тип | Опции |
|---|---|---|
| name | Varchar (обяз.) | имя |
| phone | Phone | |
| specialty | Varchar | узкая специализация |
| isActive | Boolean | по умолчанию true |
| notes | Text | |

Примечание: связь Specialist ↔ Contact (мастер как клиент) — на этап P2, для MVP не требуется.

### 2.3. Session (Запись/Сессия) — центральная сущность

| Поле | Тип | Опции |
|---|---|---|
| contactId | Link → Contact (обяз.) | клиент |
| specialistId | Link → Specialist (обяз.) | исполнитель |
| offerId | Link → Offer (обяз.) | услуга |
| startAt | DateTime (обяз.) | начало |
| endAt | DateTime (обяз.) | конец |
| status | Enum | `new`, `confirmed`, `in_progress`, `completed`, `cancelled`, `no_show` |
| source | Enum | `telegram`, `phone`, `walk_in` |
| depositAmount | Currency | сумма депозита |
| depositStatus | Enum | `pending`, `paid`, `refunded`, `forfeited` |
| paymentMethod | Enum | `telegram`, `transfer`, `on_site` |
| canceledBy | Enum | `client`, `admin`, `salon` |
| cancelReason | Text | |
| reminderSentAt | DateTime | защита от дублей напоминаний |

Перевод статусов на русский — в лейблах при создании Enum:
`new` = Новая, `confirmed` = Подтверждена, `in_progress` = В работе,
`completed` = Завершена, `cancelled` = Отменена, `no_show` = Неявка.

### 2.4. Expense (Расходы)

| Поле | Тип | Опции |
|---|---|---|
| name | Varchar (обяз.) | что потрачено |
| amount | Currency (обяз.) | сумма |
| category | Enum | `rent`, `supplies`, `ads`, `salary`, `personal`, `other` |
| date | Date (обяз.) | |
| isPersonal | Boolean | флаг личных расходов (раздел «Личный капитал» в дашборде) |
| notes | Text | |

### 2.5. Contact — добавляемые поля

| Поле | Тип | Назначение |
|---|---|---|
| bookingConsent | Boolean | согласие на обработку ПД (152-ФЗ) |
| consentDate | Date | дата согласия |
| depositBalance | Currency | баланс депозита (возврат «на счёт») |

---

## 3. Защита от двойного бронирования

Через интерфейс Диспетчера сущностей уникальный индекс не создаётся —
используем хук BeforeSave. Он не только запрещает дубли, но и возвращает
Telegram-сервису понятную ошибку «время занято».

Файл: `custom/Espo/Custom/Hooks/Session/CheckOverlap.php`

```php
<?php
namespace Espo\Custom\Hooks\Session;

use Espo\ORM\Entity;

class CheckOverlap extends \Espo\Core\Hooks\Base
{
    public function beforeSave(Entity $entity, array $options = [])
    {
        if (
            !$entity->get('startAt') || !$entity->get('endAt') ||
            !$entity->get('specialistId')
        ) {
            return;
        }

        if ($entity->get('status') === 'Cancelled') {
            return;
        }

        $pdo = $this->getEntityManager()->getPDO();
        $stmt = $pdo->prepare("
            SELECT id FROM session
            WHERE specialist_id = :specialistId
              AND deleted = 0
              AND status NOT IN ('Cancelled', 'No Show')
              AND start_at < :endAt
              AND end_at > :startAt
              AND id != :selfId
            LIMIT 1
        ");
        $stmt->execute([
            'specialistId' => $entity->get('specialistId'),
            'startAt'      => $entity->get('startAt'),
            'endAt'        => $entity->get('endAt'),
            'selfId'       => $entity->id ?? '0000000000000000',
        ]);

        if ($stmt->fetch()) {
            throw new \Espo\Core\Exceptions\Conflict(
                'Это время у специалиста уже занято'
            );
        }
    }
}
```

**Важно:** имена таблиц/полей в SQL (`session`, `specialist_id`, `start_at`)
генерируются EspoCRM автоматически. Если сущности созданы с другими именами —
поправить в запросе. После сохранения файла: **Администрирование → Очистить кэш**.

---

## 4. Критерии приёмки шага 1

1. В `Offer` созданы две тестовые услуги: «Маникюр» (2500 ₽, 60 мин), «Стрижка» (1800 ₽, 45 мин).
2. Созданы два тестовых `Specialist` («Анна», «Мария»).
3. Создание `Session` на сегодня 14:00–15:00 → сохраняется.
4. Вторая `Session` у того же специалиста 14:30–15:30 → **ошибка занятости** (критический критерий).
5. Сессия 15:30–16:30 у того же специалиста → сохраняется.

Если шаг 4 не вернул ошибку — хук не подхватился: проверить путь файла и очистить кэш.

---

## 5. Следующий шаг — этап 2: `api_user`

- Создание пользователя `api_user` (тип API) в EspoCRM.
- Роль с доступом **только** к нужным сущностям: `Session` (create/read/edit),
  `Contact` (create/read), `Offer` (read), `Specialist` (read).
- Запрет на админ-панель и прочие сущности.
- Токен передаётся Telegram-сервису через переменные окружения (не в коде).

Детальная настройка роли — в следующей итерации этого документа.

---

## 6. Открытые вопросы (не блокируют шаг 1)

- Цена пакетного внедрения «под ключ» — вписать в тарифы `Opportunity` (решение заказчика).
- Домен с HTTPS для Telegram-webhook — нужен перед продом, для локальной разработки не требуется.

---

*Источник логики модели данных: atmosfera_mvp_consolidated.md, разделы 5 и 15.*
