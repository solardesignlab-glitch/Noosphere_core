# ADR-0007: RLS для tenant isolation

## Status
Accepted

## Date
2026-11-03

## Context
Multi-tenant требует гарантии изоляции.

## Decision
PostgreSQL RLS + tenant middleware + policy-as-code тесты.

## Consequences
### Positive
- Изоляция на уровне БД.
### Negative
- Сложнее отладка.
### Risks
- Ошибка в RLS = утечка.
