import logging

from app.services.espo_service import find_or_create_lead
from app.services.telegram_api import send_message

logger = logging.getLogger(__name__)


async def handle_update(update: dict) -> None:
    message = update.get("message")
    if not message:
        return

    chat = message.get("chat", {})
    chat_id = str(chat.get("id", ""))
    text = (message.get("text") or "").strip()
    first_name = chat.get("first_name", "")
    username = chat.get("username", "")

    logger.info("Telegram message received: chat_id=%s", chat_id)

    if not text:
        await send_message(chat_id, "Пожалуйста, напишите ваш запрос текстом.")
        return

    lead = await find_or_create_lead(
        telegram_id=chat_id,
        name=first_name or "Клиент Telegram",
        username=username,
        message=text,
    )

    await send_message(
        chat_id,
        "Спасибо! Ваш запрос принят. Администратор свяжется с вами в ближайшее время.",
    )

    if lead:
        logger.info("Lead processed: lead_id=%s", lead.get("id"))
