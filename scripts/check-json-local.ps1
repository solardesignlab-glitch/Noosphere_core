Write-Host "=== 4. Проверка Telegram Webhook ===" -ForegroundColor Cyan

if ($env:TELEGRAM_BOT_TOKEN) {
    try {
        $status = Invoke-RestMethod -Uri "https://api.telegram.org/bot$(\$env:TELEGRAM_BOT_TOKEN)/getWebhookInfo"
        if ($status.ok -and $status.result.url) {
            Write-Host "Webhook активен: $($status.result.url)" -ForegroundColor Green
        } else {
            Write-Host "Webhook НЕ настроен или отключен." -ForegroundColor Yellow
            Write-Host "Запусти .\scripts\set_telegram_webhook.ps1 для настройки."
        }
    } catch {
        Write-Host "Не удалось проверить webhook (нет токена или проблемы сети)." -ForegroundColor Gray
    }
} else {
    Write-Host "TELEGRAM_BOT_TOKEN не найден в переменных окружения." -ForegroundColor Gray
}
