import pool from "./src/shared/db/pool.js";

const [rows] = await pool.query(
  "SELECT id, organization_id, name, phone, email, specialty, is_active, created_at FROM masters",
);

console.log("Всего мастеров:", rows.length);
console.log(rows);

await pool.end();
