import os

import httpx
from fastapi import APIRouter, HTTPException
from pydantic import BaseModel

router = APIRouter(prefix="/api/ai", tags=["AI"])

OLLAMA_URL = os.getenv("OLLAMA_URL", "http://host.docker.internal:11434")
OLLAMA_MODEL = os.getenv("OLLAMA_MODEL", "qwen2.5:7b")
OLLAMA_CODE_MODEL = os.getenv("OLLAMA_CODE_MODEL", "qwen2.5-coder-32k")
GEMINI_API_KEY = os.getenv("GEMINI_API_KEY", "")

TASK_MODELS = {
    "chat": OLLAMA_MODEL,
    "code_review": OLLAMA_CODE_MODEL,
    "specification": OLLAMA_CODE_MODEL,
    "audit": OLLAMA_CODE_MODEL,
}


class ChatRequest(BaseModel):
    message: str
    history: list[dict] = []


class TaskRequest(BaseModel):
    taskType: str
    message: str
    context: str = ""


@router.get("/health")
async def health():
    try:
        async with httpx.AsyncClient(timeout=5) as client:
            response = await client.get(f"{OLLAMA_URL}/api/tags")
        ollama_ok = response.status_code == 200
    except Exception:
        ollama_ok = False

    return {
        "status": "ok" if ollama_ok else "degraded",
        "gemini_configured": bool(GEMINI_API_KEY),
        "ollama_url": OLLAMA_URL,
        "ollama_model": OLLAMA_MODEL,
        "ollama_code_model": OLLAMA_CODE_MODEL,
        "ollama_available": ollama_ok,
    }


@router.post("/chat")
async def chat(request: ChatRequest):
    messages = [
        {
            "role": "system",
            "content": (
                "Ты — вежливый AI-ассистент салона красоты «Атмосфера». "
                "Отвечай кратко, по-русски и помогай клиентам с записью, "
                "услугами, мастерами и временем визита."
            ),
        }
    ]

    for item in request.history[-10:]:
        role = item.get("role", "user")
        content = item.get("content", "")
        if role in ("user", "assistant") and content:
            messages.append({"role": role, "content": content})

    messages.append({"role": "user", "content": request.message})

    try:
        async with httpx.AsyncClient(timeout=60) as client:
            response = await client.post(
                f"{OLLAMA_URL}/api/chat",
                json={
                    "model": OLLAMA_MODEL,
                    "messages": messages,
                    "stream": False,
                },
            )
            response.raise_for_status()
            data = response.json()
    except Exception as exc:
        raise HTTPException(status_code=502, detail=f"Ollama error: {exc}")

    return {
        "reply": data.get("message", {}).get("content", "").strip(),
        "provider": "ollama",
        "model": OLLAMA_MODEL,
    }


@router.post("/task")
async def task(request: TaskRequest):
    if request.taskType not in TASK_MODELS:
        raise HTTPException(
            status_code=400,
            detail=f"Unknown taskType. Allowed: {', '.join(TASK_MODELS)}",
        )

    model = TASK_MODELS[request.taskType]

    messages = [
        {
            "role": "system",
            "content": (
                "Ты — технический ассистент проекта Атмосфера. "
                "Отвечай по делу, на русском языке, без выдумок. "
                "Если данных недостаточно, прямо скажи об этом."
            ),
        }
    ]

    if request.context:
        messages.append(
            {
                "role": "user",
                "content": (
                    f"Тип задачи: {request.taskType}\n\n"
                    f"Контекст:\n{request.context}\n\n"
                    f"Задача:\n{request.message}"
                ),
            }
        )
    else:
        messages.append(
            {
                "role": "user",
                "content": (
                    f"Тип задачи: {request.taskType}\n\n"
                    f"Задача:\n{request.message}"
                ),
            }
        )

    try:
        async with httpx.AsyncClient(timeout=180) as client:
            response = await client.post(
                f"{OLLAMA_URL}/api/chat",
                json={
                    "model": model,
                    "messages": messages,
                    "stream": False,
                },
            )
            response.raise_for_status()
            data = response.json()
    except Exception as exc:
        raise HTTPException(status_code=502, detail=f"Ollama error: {exc}")

    return {
        "taskType": request.taskType,
        "provider": "ollama",
        "model": model,
        "reply": data.get("message", {}).get("content", "").strip(),
    }