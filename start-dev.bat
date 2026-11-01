@echo off
title UCP MVP - launcher

echo Starting UCP MVP...
echo API: http://localhost:4000
echo WEB: http://localhost:5173

start "API - UCP MVP" cmd /k "cd /d C:\Projects\ucp-mvp\apps\api && npm run dev"
start "WEB - UCP MVP" cmd /k "cd /d C:\Projects\ucp-mvp\apps\web && npm run dev"

echo.
echo Both terminals started.
echo Close each window with Ctrl+C to stop its server.
pause