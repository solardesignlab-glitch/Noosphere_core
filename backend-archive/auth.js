import bcrypt from "bcryptjs";
import jwt from "jsonwebtoken";
import fs from "fs";
import path from "path";
import { fileURLToPath } from "url";

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

const usersPath = path.join(__dirname, "users.json");

const ROLES = ["owner", "developer", "client"];

function readUsers() {
  if (!fs.existsSync(usersPath)) {
    return [];
  }

  try {
    return JSON.parse(fs.readFileSync(usersPath, "utf8"));
  } catch {
    return [];
  }
}

function writeUsers(users) {
  fs.writeFileSync(usersPath, JSON.stringify(users, null, 2), "utf8");
}

export async function seedOwner() {
  const users = readUsers();

  if (users.some((user) => user.role === "owner")) {
    return;
  }

  const email = process.env.OWNER_EMAIL;
  const password = process.env.OWNER_PASSWORD;

  if (!email || !password) {
    console.warn("OWNER_EMAIL или OWNER_PASSWORD не заданы: владелец не создан");
    return;
  }

  const passwordHash = await bcrypt.hash(password, 12);

  users.push({
    id: crypto.randomUUID(),
    email: email.toLowerCase(),
    passwordHash,
    role: "owner",
    organizationId: "atmosfera",
    createdAt: new Date().toISOString()
  });

  writeUsers(users);

  console.log(`Создан владелец: ${email}`);
}

export function signToken(user) {
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
    return res.status(401).json({ detail: "Требуется авторизация" });
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
    return res.status(401).json({ detail: "Недействительный или истёкший токен" });
  }
}

export function requireRole(...roles) {
  return (req, res, next) => {
    if (!req.user) {
      return res.status(401).json({ detail: "Требуется авторизация" });
    }

    if (!roles.includes(req.user.role)) {
      return res.status(403).json({ detail: "Недостаточно прав" });
    }

    next();
  };
}

export async function registerUser({ email, password, role }) {
  if (!email || !password) {
    throw Object.assign(new Error("Нужны email и password"), { status: 400 });
  }

  if (!ROLES.includes(role)) {
    throw Object.assign(new Error("Недопустимая роль"), { status: 400 });
  }

  const users = readUsers();
  const normalizedEmail = email.toLowerCase();

  if (users.some((user) => user.email === normalizedEmail)) {
    throw Object.assign(new Error("Пользователь уже существует"), { status: 409 });
  }

  const passwordHash = await bcrypt.hash(password, 12);

  const user = {
    id: crypto.randomUUID(),
    email: normalizedEmail,
    passwordHash,
    role,
    organizationId: "atmosfera",
    createdAt: new Date().toISOString()
  };

  users.push(user);
  writeUsers(users);

  return {
    id: user.id,
    email: user.email,
    role: user.role,
    organizationId: user.organizationId
  };
}

export async function authenticateUser({ email, password }) {
  const users = readUsers();
  const user = users.find(
    (item) => item.email === String(email || "").toLowerCase()
  );

  if (!user) {
    throw Object.assign(new Error("Неверный email или пароль"), { status: 401 });
  }

  const isValid = await bcrypt.compare(String(password || ""), user.passwordHash);

  if (!isValid) {
    throw Object.assign(new Error("Неверный email или пароль"), { status: 401 });
  }

  return user;
}