import fs from "fs";
import crypto from "crypto";
import pool from "./src/shared/db/pool.js";

const usersPath = "./users.json";

if (!fs.existsSync(usersPath)) {
  console.error("users.json не найден");
  process.exit(1);
}

const localUsers = JSON.parse(fs.readFileSync(usersPath, "utf8"));

const organizationId = "11111111-1111-1111-1111-111111111111";

const [organization] = await pool.query(
  "SELECT id, name FROM organizations WHERE id = ? LIMIT 1",
  [organizationId]
);

if (!organization.length) {
  console.error("Организация не найдена:", organizationId);
  process.exit(1);
}

console.log("Целевая организация:", organization[0].name);

for (const localUser of localUsers) {
  const email = String(localUser.email || "").toLowerCase();

  if (!email || !localUser.passwordHash) {
    console.warn("Пропущен пользователь без email или passwordHash");
    continue;
  }

  const [existing] = await pool.query(
    "SELECT id FROM users WHERE email = ? LIMIT 1",
    [email]
  );

  let userId;

  if (existing.length) {
    userId = existing[0].id;
    console.log("Пользователь уже существует:", email);
  } else {
    userId = localUser.id || crypto.randomUUID();

    await pool.query(
      "INSERT INTO users (id, email, password_hash) VALUES (?, ?, ?)",
      [userId, email, localUser.passwordHash]
    );

    console.log("Создан пользователь:", email);
  }

  const [membership] = await pool.query(
    `SELECT id FROM organization_members
     WHERE user_id = ? AND organization_id = ? LIMIT 1`,
    [userId, organizationId]
  );

  if (membership.length) {
    console.log("Membership уже существует:", email);
  } else {
    await pool.query(
      `INSERT INTO organization_members
       (id, user_id, organization_id, role)
       VALUES (?, ?, ?, ?)`,
      [
        crypto.randomUUID(),
        userId,
        organizationId,
        localUser.role || "member"
      ]
    );

    console.log("Создан membership:", email, "→", organization[0].name);
  }
}

await pool.end();
console.log("USER_MIGRATION_COMPLETE");
