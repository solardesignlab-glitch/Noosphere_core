\# AtmoOS Development Agents



\## Principles



\- One task per agent run.

\- Minimal diff.

\- No schema changes without explicit approval.

\- Never invent file contents: inspect current files first.

\- Always provide verification commands.

\- Never commit automatically.

\- If verification fails, provide a targeted fix, not a full rewrite.



\## Agents



\- `repo-guardian.md`: repository and diff safety.

\- `feature-builder.md`: small feature implementation.

\- `qa-runner.md`: verification and failure analysis.



\## Task format



Agent: <agent-name>

Task: <short task>

Files: <expected files>

Constraints: <constraints>

Definition of Done: <checks>



\## Required verification



\- `node --check apps/api/server.js`

\- `node scripts/smoke-appointments.mjs`

\- `node scripts/smoke-services.mjs`

\- `git diff --stat`

\- `git status --short`

