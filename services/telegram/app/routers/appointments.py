from fastapi import APIRouter, HTTPException
from pydantic import BaseModel

from app.services.appointment_service import send_appointment_confirmation

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
