import os

TELEGRAM_BOT_TOKEN = os.getenv("TELEGRAM_BOT_TOKEN", "")
ESPOCRM_URL = os.getenv("ESPOCRM_URL", "http://espocrm:80").rstrip("/")
ESPOCRM_API_USERNAME = os.getenv("ESPOCRM_API_USERNAME", "")
ESPOCRM_API_PASSWORD = os.getenv("ESPOCRM_API_PASSWORD", "")
ADMIN_TELEGRAM_ID = os.getenv("ADMIN_TELEGRAM_ID", "")
WEBHOOK_SECRET = os.getenv("WEBHOOK_SECRET", "")

if not TELEGRAM_BOT_TOKEN:
    raise RuntimeError("TELEGRAM_BOT_TOKEN is required")

if not ESPOCRM_API_USERNAME or not ESPOCRM_API_PASSWORD:
    raise RuntimeError("EspoCRM API credentials are required")
