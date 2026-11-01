export function tenantContext(req, res, next) {
  if (!req.user) {
    return res.status(401).json({
      detail: "Требуется авторизация"
    });
  }

  if (!req.user.organizationId) {
    return res.status(403).json({
      detail: "Пользователь не привязан к организации"
    });
  }

  req.organizationId = req.user.organizationId;

  next();
}
