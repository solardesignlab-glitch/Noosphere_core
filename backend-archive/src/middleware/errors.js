export function errorHandler(error, req, res, next) {
  console.error("Unhandled error:", error);

  res.status(error.status || 500).json({
    error: error.message || "Внутренняя ошибка сервера",
  });
}
