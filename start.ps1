param([switch]$Docker)

$root = $PSScriptRoot

# Docker-версия EspoCRM (опционально: .\start.ps1 -Docker)
if ($Docker) {
    if (Test-Path "$root\docker-compose.yml") {
        Write-Host "Поднимаем docker compose..."
        docker compose -f "$root\docker-compose.yml" -p atmosfera up -d
    } else {
        Write-Host "docker-compose.yml не найден в корне - пропускаю Docker"
    }
}

# Бэкенд (порт 4000)
if (Get-NetTCPConnection -LocalPort 4000 -State Listen -ErrorAction SilentlyContinue) {
    Write-Host "Порт 4000 занят - бэкенд уже работает, пропускаю"
} else {
    Write-Host "Запускаю бэкенд..."
    Start-Process powershell -ArgumentList "-NoExit","-Command","Set-Location '$root\apps\api'; npm run dev"
}

# Фронтенд (порт 5173)
if (Get-NetTCPConnection -LocalPort 5173 -State Listen -ErrorAction SilentlyContinue) {
    Write-Host "Порт 5173 занят - фронтенд уже работает, пропускаю"
} else {
    Write-Host "Запускаю фронтенд..."
    Start-Process powershell -ArgumentList "-NoExit","-Command","Set-Location '$root\frontend'; npm run dev"
}

# Даём серверам подняться и открываем дашборд
Start-Sleep -Seconds 6
Start-Process "http://localhost:5173"
Write-Host "Готово: бэкенд http://localhost:4000, дашборд http://localhost:5173"
