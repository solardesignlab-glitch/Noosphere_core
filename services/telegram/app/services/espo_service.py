import logging
from datetime import datetime

import httpx

from app.config import ESPOCRM_URL, ESPOCRM_API_USERNAME, ESPOCRM_API_PASSWORD

logger = logging.getLogger(__name__)


class EspoClient:
    def __init__(self):
        self.base_url = ESPOCRM_URL
        self.auth = (ESPOCRM_API_USERNAME, ESPOCRM_API_PASSWORD)

    async def request(self, method: str, path: str, json: dict | None = None):
        url = f"{self.base_url}/api/v1{path}"
        async with httpx.AsyncClient(timeout=20, auth=self.auth) as client:
            response = await client.request(method, url, json=json)
            response.raise_for_status()
            if response.status_code == 204 or not response.content:
                return {}
            return response.json()

    async def search_lead_by_telegram(self, telegram_id: str):
        data = await self.request(
            "GET",
            f"/Lead?where[0][type]=equals&where[0][attribute]=cTelegramId&where[0][value]={telegram_id}",
        )
        items = data.get("list", [])
        return items[0] if items else None

    async def create_lead(self, telegram_id: str, name: str, username: str, message: str):
        payload = {
            "firstName": name,
            "lastName": "",
            "source": "Telegram",
            "status": "New",
            "description": message,
            "cTelegramId": telegram_id,
            "cTelegramUsername": username,
        }
        return await self.request("POST", "/Lead", payload)

    async def update_appointment_status(self, appointment_id: str, status: str):
        return await self.request("PUT", f"/Appointment/{appointment_id}", {"status": status})

    async def create_task(self, name: str, description: str):
        payload = {
            "name": name,
            "description": description,
            "status": "Not Started",
            "priority": "High",
        }
        return await self.request("POST", "/Task", payload)

    async def get_appointments_by_date(self, date: str):
        path = (
            "/Appointment"
            "?orderBy=dateStart"
            "&order=asc"
            "&limit=100"
            f"&where[0][type]=and"
            f"&where[0][value][0][type]=equals"
            f"&where[0][value][0][attribute]=dateStart"
            f"&where[0][value][0][value]={date}"
        )

        data = await self.request("GET", path)
        return data.get("list", [])

    async def get_today_appointments(self):
        today = datetime.now().strftime("%Y-%m-%d")
        return await self.get_appointments_by_date(today)


espo = EspoClient()


async def find_or_create_lead(telegram_id: str, name: str, username: str, message: str):
    try:
        lead = await espo.search_lead_by_telegram(telegram_id)
        if lead:
            return lead
        return await espo.create_lead(telegram_id, name, username, message)
    except Exception:
        logger.exception("EspoCRM lead processing failed")
        return None