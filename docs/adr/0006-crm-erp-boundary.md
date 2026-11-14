# ADR-0006: Граница CRM и ERP

## Status
Accepted

## Date
2026-11-03

## Context
Склад и логистика — не задачи CRM.

## Decision
CRM: Person, Customer, Session. ERP: Inventory, Warehouse. Обмен — события.

## Consequences
### Positive
- Чистая архитектура.
### Negative
- Нужна шина.
### Risks
- Размывание границы.
