from fastapi import FastAPI

from app.routers.telegram import router as telegram_router
from app.routers.appointments import router as appointments_router
from app.routers.ai import router as ai_router

app = FastAPI(
    title="Atmosfera AI & Telegram Adapter",
    version="0.2.0",
    description="Telegram adapter and AI assistant for Atmosfera MVP",
)

app.include_router(telegram_router)
app.include_router(appointments_router)
app.include_router(ai_router)


@app.get("/health")
async def health():
    return {"status": "ok"}
