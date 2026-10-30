import logging
import os

import httpx
from fastapi import APIRouter, HTTPException
from pydantic import BaseModel, Field

logger = logging.getLogger(__name__)

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
    "ux": OLLAMA_MODEL,
}

ALLOWED_MODELS = {OLLAMA_MODEL, OLLAMA_CODE_MODEL}


class ChatRequest(BaseModel):
    message: str = Field(min_length=1, max_length=8000)
    history: list[dict] = Field(default_factory=list, max_length=20)
    model: str | None = None


class TaskRequest(BaseModel):
    taskType: str
    message: str = Field(min_length=1, max_length=16000)
    context: str = Field(default="", max_length=32000)


class TestRequest(BaseModel):
    model: str
    message: str = Field(min_length=1, max_length=8000)
    systemPrompt: str = Field(default="", max_length=8000)


def validate_model(model: str) -> str:
    if model not in ALLOWED_MODELS:
        raise HTTPException(
            status_code=400,
            detail="Requested model is not allowed",
        )
    return model


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


@router.get("/models")
async def models():
    try:
        async with httpx.AsyncClient(timeout=10) as client:
            response = await client.get(f"{OLLAMA_URL}/api/tags")
            response.raise_for_status()
            data = response.json()
    except Exception:
        logger.exception("Ollama request failed")
        raise HTTPException(
            status_code=502,
            detail="AI service is temporarily unavailable",
        )

    models = []

    for item in data.get("models", []):
        details = item.get("details", {})

        models.append(
            {
                "id": item.get("name"),
                "name": item.get("name"),
                "provider": "ollama",
                "size": item.get("size"),
                "parameterSize": details.get("parameter_size"),
                "quantization": details.get("quantization_level"),
                "contextLength": details.get("context_length"),
                "modifiedAt": item.get("modified_at"),
                "capabilities": item.get("capabilities", []),
                "status": "installed",
            }
        )

    return {
        "provider": "ollama",
        "url": OLLAMA_URL,
        "count": len(models),
        "models": models,
    }


@router.post("/test")
async def test_model(request: TestRequest):
    validate_model(request.model)

    messages = []

    if request.systemPrompt:
        messages.append(
            {
                "role": "system",
                "content": request.systemPrompt,
            }
        )

    messages.append(
        {
            "role": "user",
            "content": request.message,
        }
    )

    try:
        async with httpx.AsyncClient(timeout=120) as client:
            response = await client.post(
                f"{OLLAMA_URL}/api/chat",
                json={
                    "model": request.model,
                    "messages": messages,
                    "stream": False,
                },
            )
            response.raise_for_status()
            data = response.json()
    except Exception:
        logger.exception("Ollama request failed")
        raise HTTPException(
            status_code=502,
            detail="AI service is temporarily unavailable",
        )

    return {
        "provider": "ollama",
        "model": request.model,
        "reply": data.get("message", {}).get("content", "").strip(),
    }


@router.post("/chat")
async def chat(request: ChatRequest):
    selected_model = request.model or OLLAMA_MODEL
    validate_model(selected_model)

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
        async with httpx.AsyncClient(timeout=120) as client:
            response = await client.post(
                f"{OLLAMA_URL}/api/chat",
                json={
                    "model": selected_model,
                    "messages": messages,
                    "stream": False,
                },
            )
            response.raise_for_status()
            data = response.json()
    except Exception:
        logger.exception("Ollama request failed")
        raise HTTPException(
            status_code=502,
            detail="AI service is temporarily unavailable",
        )

    return {
        "reply": data.get("message", {}).get("content", "").strip(),
        "provider": "ollama",
        "model": selected_model,
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
    except Exception:
        logger.exception("Ollama request failed")
        raise HTTPException(
            status_code=502,
            detail="AI service is temporarily unavailable",
        )

    return {
        "taskType": request.taskType,
        "provider": "ollama",
        "model": model,
        "reply": data.get("message", {}).get("content", "").strip(),
    }