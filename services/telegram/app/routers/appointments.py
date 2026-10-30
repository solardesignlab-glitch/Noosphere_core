import logging
import os
from datetime import datetime
from zoneinfo import ZoneInfo

from fastapi import APIRouter, Depends, Header, HTTPException
from pydantic import BaseModel

from app.services.appointment_service import send_appointment_confirmation
from app.services.espo_service import espo

logger = logging.getLogger(__name__)

router = APIRouter(prefix="/appointments", tags=["appointments"])

APP_TIMEZONE = ZoneInfo(os.getenv("APP_TIMEZONE", "Europe/Moscow"))
SERVICE_TOKEN = os.getenv("TELEGRAM_SERVICE_TOKEN", "")


def require_service_token(
    x_service_token: str | None = Header(default=None, alias="X-Service-Token"),
) -> None:
    if not SERVICE_TOKEN:
        logger.error("TELEGRAM_SERVICE_TOKEN is not configured")
        raise HTTPException(
            status_code=503,
            detail="Service authentication is not configured",
        )

    if not x_service_token or x_service_token != SERVICE_TOKEN:
        raise HTTPException(status_code=401, detail="Unauthorized")


class AppointmentCreated(BaseModel):
    appointment_id: str
    client_telegram_id: str
    client_name: str
    master_name: str
    service_name: str
    start_at: str
    duration_minutes: int


@router.post("/created")
async def appointment_created(payload: AppointmentCreated):
    result = await send_appointment_confirmation(payload.model_dump())

    if not result.get("ok"):
        raise HTTPException(status_code=502, detail="Appointment notification failed")

    return result


@router.get("/today", dependencies=[Depends(require_service_token)])
async def today_appointments():
    today = datetime.now(APP_TIMEZONE).strftime("%Y-%m-%d")

    try:
        items = await espo.get_today_appointments()
    except Exception:
        logger.exception("EspoCRM appointment request failed")
        raise HTTPException(
            status_code=502,
            detail="Appointment service is temporarily unavailable",
        )

    appointments = []

    for item in items:
        appointments.append(
            {
                "id": item.get("id"),
                "name": item.get("name"),
                "status": item.get("status"),
                "dateStart": item.get("dateStart"),
                "dateEnd": item.get("dateEnd"),
                "assignedUser": item.get("assignedUserName"),
                "parent": item.get("parentName"),
            }
        )

    return {
        "date": today,
        "count": len(appointments),
        "appointments": appointments,
    }