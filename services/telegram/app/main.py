from fastapi import FastAPI

from app.routers.telegram import router as telegram_router
from app.routers.appointments import router as appointments_router

app = FastAPI(
    title="UCP Telegram Adapter",
    version="0.1.0",
    description="Telegram-адаптер для MVP «Управляемая клиентская платформа»",
)

app.include_router(telegram_router)
app.include_router(appointments_router)


@app.get("/health")
async def health():
    return {"status": "ok"}
