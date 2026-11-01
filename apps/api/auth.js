import bcrypt from "bcryptjs";
import jwt from "jsonwebtoken";
import crypto from "crypto";
import pool from "./src/shared/db/pool.js";

const ROLES = ["owner", "developer", "client"];

export async function seedOwner() {
  const email = String(process.env.OWNER_EMAIL || "").toLowerCase();
  const password = process.env.OWNER_PASSWORD;

  if (!email || !password) {
    console.warn("OWNER_EMAIL или OWNER_PASSWORD не заданы");
    return;
  }

  const [existing] = await pool.query(
    "SELECT id FROM users WHERE email = ? LIMIT 1",
    [email]
  );

  if (existing.length) {
    return;
  }

  const passwordHash = await bcrypt.hash(password, 12);
  const userId = crypto.randomUUID();

  await pool.query(
    "INSERT INTO users (id, email, password_hash) VALUES (?, ?, ?)",
    [userId, email, passwordHash]
  );

  const [organizations] = await pool.query(
    "SELECT id FROM organizations WHERE name = ? LIMIT 1",
    ["AtmoOS Core"]
  );

  if (!organizations.length) {
    console.warn("Организация AtmoOS Core не найдена");
    return;
  }

  await pool.query(
    `INSERT INTO organization_members
     (id, user_id, organization_id, role)
     VALUES (?, ?, ?, ?)`,
    [crypto.randomUUID(), userId, organizations[0].id, "owner"]
  );

  console.log("Создан владелец:", email);
}

export async function signToken(user) {
  return jwt.sign(
    {
      sub: user.id,
      email: user.email,
      role: user.role,
      organizationId: user.organizationId
    },
    process.env.JWT_SECRET,
    {
      expiresIn: process.env.JWT_EXPIRES_IN || "12h"
    }
  );
}

export function requireAuth(req, res, next) {
  const header = req.headers.authorization || "";
  const token = header.startsWith("Bearer ") ? header.slice(7) : null;

  if (!token) {
    return res.status(401).json({
      detail: "Требуется авторизация"
    });
  }

  try {
    const payload = jwt.verify(token, process.env.JWT_SECRET);

    req.user = {
      id: payload.sub,
      email: payload.email,
      role: payload.role,
      organizationId: payload.organizationId
    };

    next();
  } catch {
    return res.status(401).json({
      detail: "Недействительный или истёкший токен"
    });
  }
}

export function requireRole(...roles) {
  return (req, res, next) => {
    if (!req.user) {
      return res.status(401).json({
        detail: "Требуется авторизация"
      });
    }

    if (!roles.includes(req.user.role)) {
      return res.status(403).json({
        detail: "Недостаточно прав"
      });
    }

    next();
  };
}

export async function registerUser({ email, password, role, organizationId }) {
  if (!email || !password) {
    throw Object.assign(new Error("Нужны email и password"), { status: 400 });
  }

  if (!ROLES.includes(role)) {
    throw Object.assign(new Error("Недопустимая роль"), { status: 400 });
  }

  if (!organizationId) {
    throw Object.assign(new Error("Нужна organizationId"), { status: 400 });
  }

  const normalizedEmail = String(email).toLowerCase();

  const [existing] = await pool.query(
    "SELECT id FROM users WHERE email = ? LIMIT 1",
    [normalizedEmail]
  );

  if (existing.length) {
    throw Object.assign(
      new Error("Пользователь уже существует"),
      { status: 409 }
    );
  }

  const userId = crypto.randomUUID();
  const passwordHash = await bcrypt.hash(password, 12);

  await pool.query(
    "INSERT INTO users (id, email, password_hash) VALUES (?, ?, ?)",
    [userId, normalizedEmail, passwordHash]
  );

  await pool.query(
    `INSERT INTO organization_members
     (id, user_id, organization_id, role)
     VALUES (?, ?, ?, ?)`,
    [crypto.randomUUID(), userId, organizationId, role]
  );

  return {
    id: userId,
    email: normalizedEmail,
    role,
    organizationId
  };
}

export async function authenticateUser({ email, password }) {
  const normalizedEmail = String(email || "").toLowerCase();

  const [rows] = await pool.query(
    `SELECT
       u.id,
       u.email,
       u.password_hash,
       m.role,
       m.organization_id AS organizationId
     FROM users u
     JOIN organization_members m ON m.user_id = u.id
     WHERE u.email = ?
     LIMIT 1`,
    [normalizedEmail]
  );

  const user = rows[0];

  if (!user) {
    throw Object.assign(
      new Error("Неверный email или пароль"),
      { status: 401 }
    );
  }

  const isValid = await bcrypt.compare(
    String(password || ""),
    user.password_hash
  );

  if (!isValid) {
    throw Object.assign(
      new Error("Неверный email или пароль"),
      { status: 401 }
    );
  }

  return {
    id: user.id,
    email: user.email,
    role: user.role,
    organizationId: user.organizationId
  };
}
