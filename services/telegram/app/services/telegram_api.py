import httpx

from app.config import TELEGRAM_BOT_TOKEN

API_URL = f"https://api.telegram.org/bot{TELEGRAM_BOT_TOKEN}"


async def send_message(chat_id: str, text: str, reply_markup: dict | None = None) -> dict:
    payload = {
        "chat_id": chat_id,
        "text": text,
        "parse_mode": "HTML",
    }
    if reply_markup:
        payload["reply_markup"] = reply_markup

    async with httpx.AsyncClient(timeout=15) as client:
        response = await client.post(f"{API_URL}/sendMessage", json=payload)
        response.raise_for_status()
        return response.json()


async def set_webhook(url: str, secret: str) -> dict:
    payload = {
        "url": url,
        "secret_token": secret,
        "allowed_updates": ["message", "callback_query"],
    }

    async with httpx.AsyncClient(timeout=15) as client:
        response = await client.post(f"{API_URL}/setWebhook", json=payload)
        response.raise_for_status()
        return response.json()
