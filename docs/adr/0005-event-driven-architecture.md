# ADR-0005: Event-driven архитектура

## Status
Accepted

## Date
2026-11-03

## Context
Интеграции не должны менять ядро напрямую.

## Decision
DomainEvent с event_id и idempotency.

## Consequences
### Positive
- Слабая связанность.
### Negative
- Сложнее отладка.
### Risks
- Потеря событий.
