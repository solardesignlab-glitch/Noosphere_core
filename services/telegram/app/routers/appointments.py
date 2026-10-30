from datetime import datetime

from fastapi import APIRouter, HTTPException
from pydantic import BaseModel

from app.services.appointment_service import send_appointment_confirmation
from app.services.espo_service import espo

router = APIRouter(prefix="/appointments", tags=["appointments"])


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
        raise HTTPException(status_code=502, detail=result)
    return result


@router.get("/today")
async def today_appointments():
    today = datetime.now().strftime("%Y-%m-%d")

    try:
        items = await espo.get_today_appointments()
    except Exception as exc:
        raise HTTPException(status_code=502, detail=f"EspoCRM error: {exc}")

    appointments = []

    for item in items:
        appointments.append(
            {
                "id": item.get("id"),
                "name": item.get("name"),
                "status": item.get("status"),
                "dateStart": item.get("dateStart"),
                "dateEnd": item.get("dateEnd"),
                "description": item.get("description"),
                "assignedUser": item.get("assignedUserName"),
                "parent": item.get("parentName"),
            }
        )

    return {
        "date": today,
        "count": len(appointments),
        "appointments": appointments,
    }