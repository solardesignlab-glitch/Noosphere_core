import logging

from app.services.telegram_api import send_message
from app.services.espo_service import espo

logger = logging.getLogger(__name__)


async def send_appointment_confirmation(payload: dict) -> dict:
    appointment_id = payload["appointment_id"]
    chat_id = payload["client_telegram_id"]
    text = (
        f"<b>Запись создана</b>\n\n"
        f"Услуга: {payload['service_name']}\n"
        f"Мастер: {payload['master_name']}\n"
        f"Дата и время: {payload['start_at']}\n"
        f"Длительность: {payload['duration_minutes']} мин.\n\n"
        "Пожалуйста, подтвердите запись."
    )

    keyboard = {
        "inline_keyboard": [
            [
                {"text": "✅ Подтвердить", "callback_data": f"confirm:{appointment_id}"},
                {"text": "🔁 Перенести", "callback_data": f"reschedule:{appointment_id}"},
            ]
        ]
    }

    result = await send_message(chat_id, text, keyboard)
    await espo.update_appointment_status(appointment_id, "awaiting_confirmation")
    return {"ok": True, "telegram": result}
