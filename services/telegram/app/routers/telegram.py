from fastapi import APIRouter, Request, HTTPException, Header
from app.config import WEBHOOK_SECRET
from app.services.telegram_service import handle_update

router = APIRouter(prefix="/telegram", tags=["telegram"])


@router.post("/webhook/{secret}")
async def telegram_webhook(
    secret: str,
    request: Request,
    x_telegram_bot_api_secret_token: str | None = Header(default=None),
):
    if secret != WEBHOOK_SECRET:
        raise HTTPException(status_code=403, detail="Invalid webhook secret")

    if x_telegram_bot_api_secret_token and x_telegram_bot_api_secret_token != WEBHOOK_SECRET:
        raise HTTPException(status_code=403, detail="Invalid Telegram secret token")

    update = await request.json()
    await handle_update(update)
    return {"ok": True}
