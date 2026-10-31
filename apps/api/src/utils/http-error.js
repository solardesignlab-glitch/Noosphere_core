export class HttpError extends Error {
  constructor(status, code, message, details = []) {
    super(message);
    this.status = status;
    this.code = code;
    this.details = details;
  }
}

export const badRequest = (message, details = []) =>
  new HttpError(400, 'BAD_REQUEST', message, details);

export const unauthorized = (message = 'Требуется авторизация') =>
  new HttpError(401, 'UNAUTHORIZED', message);

export const forbidden = (message = 'Доступ запрещён') =>
  new HttpError(403, 'FORBIDDEN', message);

export const notFound = (message = 'Ресурс не найден') =>
  new HttpError(404, 'NOT_FOUND', message);

export const conflict = (message = 'Конфликт данных') =>
  new HttpError(409, 'CONFLICT', message);
