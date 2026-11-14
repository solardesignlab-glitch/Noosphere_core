# ADR-0004: Разделение Person и Customer

## Status
Accepted

## Date
2026-11-03

## Context
Один человек — клиент нескольких компаний.

## Decision
Person — человек. Customer — отношение к Company.

## Consequences
### Positive
- Корректная модель.
### Negative
- Доп. таблица.
### Risks
- Дубли Person.
