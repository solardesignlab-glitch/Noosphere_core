import { env } from '../config/env.js';
import { HttpError } from '../utils/http-error.js';

const baseUrl = env.espocrm.baseUrl.replace(/\/$/, '');

async function espocrmRequest(path, options = {}) {
  const url = `${baseUrl}/api/v1${path}`;

  const response = await fetch(url, {
    ...options,
    headers: {
      'Content-Type': 'application/json',
      'X-Api-Key': env.espocrm.apiKey,
      ...(options.headers || {})
    }
  });

  if (!response.ok) {
    const text = await response.text();
    throw new HttpError(
      response.status >= 400 && response.status < 500 ? response.status : 502,
      'ESPOCRM_ERROR',
      'Ошибка интеграции с EspoCRM',
      [text]
    );
  }

  if (response.status === 204) {
    return null;
  }

  return response.json();
}

export const espocrmAdapter = {
  request: espocrmRequest,

  async findRecords(entity, params = {}) {
    const search = new URLSearchParams(params).toString();
    const path = search ? `/${entity}?${search}` : `/${entity}`;
    return espocrmRequest(path);
  },

  async getRecord(entity, id) {
    return espocrmRequest(`/${entity}/${id}`);
  },

  async createRecord(entity, payload) {
    return espocrmRequest(`/${entity}`, {
      method: 'POST',
      body: JSON.stringify(payload)
    });
  },

  async updateRecord(entity, id, payload) {
    return espocrmRequest(`/${entity}/${id}`, {
      method: 'PUT',
      body: JSON.stringify(payload)
    });
  }
};
