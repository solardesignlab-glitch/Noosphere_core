# ADR-0003: Модель тенанта Company / Branch / TenantScope

## Status
Accepted

## Date
2026-11-03

## Context
Multi-tenant требует изоляции данных.

## Decision
Company / Branch / TenantScope.

## Consequences
### Positive
- Поддержка сетей.
### Negative
- Сложнее модель.
### Risks
- Ошибка в TenantScope = утечка.
