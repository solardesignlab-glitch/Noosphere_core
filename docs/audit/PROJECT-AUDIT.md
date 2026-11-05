# UCP MVP Project Audit
Date: 11/05/2026 14:14:13

## Docker containers

NAMES          IMAGE                    STATUS                 PORTS
ucp_telegram   ucp-mvp-telegram         Up 2 hours             0.0.0.0:8090->8000/tcp, [::]:8090->8000/tcp
ucp_espocrm    espocrm/espocrm:latest   Up 2 hours (healthy)   0.0.0.0:8081->80/tcp, [::]:8081->80/tcp
ucp_redis      redis:7-alpine           Up 2 hours             6379/tcp
ucp_database   mariadb:10.11            Up 2 hours (healthy)   0.0.0.0:3306->3306/tcp, [::]:3306->3306/tcp


## Project structure

### backend\src
C:\Projects\ucp-mvp\backend\src\middleware\errors.js
C:\Projects\ucp-mvp\backend\src\modules\ai\aiActionLogModel.js
C:\Projects\ucp-mvp\backend\src\modules\ai\aiOrchestrator.js
C:\Projects\ucp-mvp\backend\src\modules\rbac\roles.js
C:\Projects\ucp-mvp\backend\src\modules\tenancy\migrations.sql
C:\Projects\ucp-mvp\backend\src\modules\tenancy\organizationModel.js
C:\Projects\ucp-mvp\backend\src\modules\tenancy\organizationRoutes.js
C:\Projects\ucp-mvp\backend\src\routes\health.js
C:\Projects\ucp-mvp\backend\src\shared\middleware\tenantContext.js
### services
C:\Projects\ucp-mvp\services\telegram\.env
C:\Projects\ucp-mvp\services\telegram\Dockerfile
C:\Projects\ucp-mvp\services\telegram\requirements.txt
C:\Projects\ucp-mvp\services\telegram\app\config.py
C:\Projects\ucp-mvp\services\telegram\app\main.py
C:\Projects\ucp-mvp\services\telegram\app\__init__.py
C:\Projects\ucp-mvp\services\telegram\app\routers\ai.py
C:\Projects\ucp-mvp\services\telegram\app\routers\appointments.py
C:\Projects\ucp-mvp\services\telegram\app\routers\telegram.py
C:\Projects\ucp-mvp\services\telegram\app\routers\__init__.py
C:\Projects\ucp-mvp\services\telegram\app\services\appointment_service.py
C:\Projects\ucp-mvp\services\telegram\app\services\espo_service.py
C:\Projects\ucp-mvp\services\telegram\app\services\telegram_api.py
C:\Projects\ucp-mvp\services\telegram\app\services\telegram_service.py
C:\Projects\ucp-mvp\services\telegram\app\services\__init__.py
### frontend\src
C:\Projects\ucp-mvp\frontend\src\App.css
C:\Projects\ucp-mvp\frontend\src\App.jsx
C:\Projects\ucp-mvp\frontend\src\index.css
C:\Projects\ucp-mvp\frontend\src\main.jsx
C:\Projects\ucp-mvp\frontend\src\api\backend.js
C:\Projects\ucp-mvp\frontend\src\api\espocrm.js
C:\Projects\ucp-mvp\frontend\src\assets\hero.png
C:\Projects\ucp-mvp\frontend\src\assets\react.svg
C:\Projects\ucp-mvp\frontend\src\assets\vite.svg
C:\Projects\ucp-mvp\frontend\src\components\AgentPanel.jsx
C:\Projects\ucp-mvp\frontend\src\components\AiPanel.css
C:\Projects\ucp-mvp\frontend\src\components\AiPanel.jsx
C:\Projects\ucp-mvp\frontend\src\components\FileDropzone.jsx
C:\Projects\ucp-mvp\frontend\src\components\SessionDrawer.jsx
C:\Projects\ucp-mvp\frontend\src\components\StatusCheck.jsx
C:\Projects\ucp-mvp\frontend\src\components\FileManager\FileList.jsx
C:\Projects\ucp-mvp\frontend\src\components\FileManager\FileUpload.jsx
C:\Projects\ucp-mvp\frontend\src\components\FileManager\index.jsx
C:\Projects\ucp-mvp\frontend\src\components\FileManager\styles.css
C:\Projects\ucp-mvp\frontend\src\pages\AiAssistantPage.jsx
C:\Projects\ucp-mvp\frontend\src\pages\AiModelsPage.jsx
C:\Projects\ucp-mvp\frontend\src\pages\AppointmentsPage.jsx
C:\Projects\ucp-mvp\frontend\src\pages\DashboardPage.jsx
C:\Projects\ucp-mvp\frontend\src\pages\LoginPage.jsx
C:\Projects\ucp-mvp\frontend\src\pages\MediaPage.jsx
C:\Projects\ucp-mvp\frontend\src\pages\SessionsPage.jsx
### scripts
C:\Projects\ucp-mvp\scripts\audit-ucp.ps1
C:\Projects\ucp-mvp\scripts\check-json-local.ps1
C:\Projects\ucp-mvp\scripts\set_telegram_webhook.sh
### docs
C:\Projects\ucp-mvp\docs\atmosfera_development_guide.md
C:\Projects\ucp-mvp\docs\atmosfera_mvp_dialog.md
C:\Projects\ucp-mvp\docs\ATMOSFERA_UX_CONCEPT.md
C:\Projects\ucp-mvp\docs\DASHBOARD_STRUCTURE.md
C:\Projects\ucp-mvp\docs\qwen_audit_review_draft.txt
C:\Projects\ucp-mvp\docs\ROADMAP.backup-2026-11-01.md
C:\Projects\ucp-mvp\docs\ROADMAP.md
C:\Projects\ucp-mvp\docs\vision_master_document.md
C:\Projects\ucp-mvp\docs\audit\PROJECT-AUDIT.baseline-2026-11-05-1352.md
C:\Projects\ucp-mvp\docs\audit\PROJECT-AUDIT.md
C:\Projects\ucp-mvp\docs\product\001_create_atmosfera_core.sql
C:\Projects\ucp-mvp\docs\protocols\00_README.md
C:\Projects\ucp-mvp\docs\protocols\01_laws.md
C:\Projects\ucp-mvp\docs\protocols\02_prohibitions.md
C:\Projects\ucp-mvp\docs\protocols\03_rules.md
C:\Projects\ucp-mvp\docs\protocols\04_conditions.md
C:\Projects\ucp-mvp\docs\protocols\05_protocols.md
C:\Projects\ucp-mvp\docs\protocols\06_change_process.md
C:\Projects\ucp-mvp\docs\protocols\07_decision_log.md
C:\Projects\ucp-mvp\docs\protocols\08_error_log.md
C:\Projects\ucp-mvp\docs\protocols\09_entity_registry.md
C:\Projects\ucp-mvp\docs\protocols\10_agent_contract.md
C:\Projects\ucp-mvp\docs\protocols\11_agent_policy.md
C:\Projects\ucp-mvp\docs\protocols\12_agent_handoff.md
C:\Projects\ucp-mvp\docs\protocols\13_data_sources.md
C:\Projects\ucp-mvp\docs\protocols\14_truth_sources.md
C:\Projects\ucp-mvp\docs\protocols\15_input_security.md
C:\Projects\ucp-mvp\docs\protocols\scope_registry.md
### db


## PowerShell scripts

get-upcoming-sessions.ps1
start-all.ps1
scripts\audit-ucp.ps1
scripts\check-json-local.ps1


## Backend API routes

C:\Projects\ucp-mvp\backend\src\routes\health.js:6: router.get(["/", "/health"], async (req, res) => {
C:\Projects\ucp-mvp\backend\src\routes\health.js:33: router.get("/db-audit", async (req, res) => {
C:\Projects\ucp-mvp\services\telegram\app\routers\ai.py:55: @router.get("/health")
C:\Projects\ucp-mvp\services\telegram\app\routers\ai.py:74: @router.get("/models")
C:\Projects\ucp-mvp\services\telegram\app\routers\ai.py:116: @router.post("/test")
C:\Projects\ucp-mvp\services\telegram\app\routers\ai.py:163: @router.post("/chat")
C:\Projects\ucp-mvp\services\telegram\app\routers\ai.py:214: @router.post("/task")
C:\Projects\ucp-mvp\services\telegram\app\routers\appointments.py:44: @router.post("/created")
C:\Projects\ucp-mvp\services\telegram\app\routers\appointments.py:54: @router.get("/today", dependencies=[Depends(require_service_token)])
C:\Projects\ucp-mvp\services\telegram\app\routers\telegram.py:8: @router.post("/webhook/{secret}")
C:\Projects\ucp-mvp\services\telegram\app\main.py:18: @app.get("/health")


## Frontend API calls

C:\Projects\ucp-mvp\frontend\src\api\backend.js:18: const response = await fetch(`${BACKEND_URL}${path}`, {
C:\Projects\ucp-mvp\frontend\src\api\backend.js:53: const data = await backendRequest("/api/auth/login", {
C:\Projects\ucp-mvp\frontend\src\api\espocrm.js:4: return backendRequest(`/api/records/sessions?limit=${limit}`);
C:\Projects\ucp-mvp\frontend\src\api\espocrm.js:8: return backendRequest(`/api/records/sessions/${id}`);
C:\Projects\ucp-mvp\frontend\src\api\espocrm.js:12: return backendRequest(`/api/records/sessions/${id}`, {
C:\Projects\ucp-mvp\frontend\src\components\FileManager\FileList.jsx:2: import axios from 'axios';
C:\Projects\ucp-mvp\frontend\src\components\FileManager\FileList.jsx:10: const { data } = await axios.get('/api/files');
C:\Projects\ucp-mvp\frontend\src\components\FileManager\FileUpload.jsx:2: import axios from 'axios';
C:\Projects\ucp-mvp\frontend\src\components\FileManager\FileUpload.jsx:26: await axios.post('/api/files', formData, {
C:\Projects\ucp-mvp\frontend\src\components\FileManager\index.jsx:2: import axios from 'axios';
C:\Projects\ucp-mvp\frontend\src\components\FileManager\index.jsx:10: const { data } = await axios.get('/api/files');
C:\Projects\ucp-mvp\frontend\src\components\AgentPanel.jsx:4: const API_BASE = "http://localhost:4000";
C:\Projects\ucp-mvp\frontend\src\components\AgentPanel.jsx:291: const response = await fetch(`${API_BASE}/api/ai/chat`, {
C:\Projects\ucp-mvp\frontend\src\components\AiPanel.jsx:32: const response = await fetch('/api/ai/task', {
C:\Projects\ucp-mvp\frontend\src\components\FileDropzone.jsx:53: const response = await fetch(
C:\Projects\ucp-mvp\frontend\src\components\FileDropzone.jsx:54: "http://localhost:4000/api/media",
C:\Projects\ucp-mvp\frontend\src\components\SessionDrawer.jsx:8: } from "../api/espocrm";
C:\Projects\ucp-mvp\frontend\src\components\StatusCheck.jsx:8: fetch("http://localhost:4000/api/v1/db-audit")
C:\Projects\ucp-mvp\frontend\src\pages\AiAssistantPage.jsx:3: const API_BASE = "http://localhost:4000";
C:\Projects\ucp-mvp\frontend\src\pages\AiAssistantPage.jsx:56: const response = await fetch(`${API_BASE}/api/ai/chat`, {
C:\Projects\ucp-mvp\frontend\src\pages\AiModelsPage.jsx:3: const API_BASE = "http://localhost:8090";
C:\Projects\ucp-mvp\frontend\src\pages\AiModelsPage.jsx:17: endpoint: "https://openrouter.ai/api/v1",
C:\Projects\ucp-mvp\frontend\src\pages\AiModelsPage.jsx:76: const response = await fetch(`${API_BASE}/api/ai/models`);
C:\Projects\ucp-mvp\frontend\src\pages\AiModelsPage.jsx:109: const response = await fetch(`${API_BASE}/api/ai/test`, {
C:\Projects\ucp-mvp\frontend\src\pages\DashboardPage.jsx:3: const API_BASE = "http://localhost:8090";
C:\Projects\ucp-mvp\frontend\src\pages\DashboardPage.jsx:121: const response = await fetch(`${API_BASE}/api/ai/chat`, {
C:\Projects\ucp-mvp\frontend\src\pages\LoginPage.jsx:2: import { login } from "../api/backend";
C:\Projects\ucp-mvp\frontend\src\pages\MediaPage.jsx:20: const response = await fetch(`${API_URL}/api/media`);
C:\Projects\ucp-mvp\frontend\src\pages\MediaPage.jsx:52: const response = await fetch(`${API_URL}/api/media`, {
C:\Projects\ucp-mvp\frontend\src\pages\SessionsPage.jsx:9: } from "../api/espocrm";
C:\Projects\ucp-mvp\frontend\src\App.jsx:11: import { getStoredUser, logout } from "./api/backend";


## API checks

http://localhost:8090/docs => 200
http://localhost:8090/api/ai/chat => 405
http://localhost:8090/api/appointments => 404
http://localhost:8081/api/v1/Appointments => 401
http://localhost:5173 => ERROR


## MariaDB databases

Database
information_schema
ucp

