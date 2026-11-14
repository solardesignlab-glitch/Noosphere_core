import dotenv from "dotenv";
dotenv.config();

const { default: bcrypt } = await import("bcryptjs");
const { default: pool } = await import("./src/shared/db/pool.js");

const email = String(process.env.OWNER_EMAIL || "").toLowerCase();
const newPassword = process.env.NEW_OWNER_PASSWORD;

if (!email || !newPassword) {
  console.error("Need OWNER_EMAIL in .env and NEW_OWNER_PASSWORD in environment");
  process.exit(1);
}

const hash = await bcrypt.hash(newPassword, 12);

const [res] = await pool.query(
  "UPDATE users SET password_hash = ? WHERE email = ?",
  [hash, email]
);

console.log("updated rows:", res.affectedRows);
await pool.end();
