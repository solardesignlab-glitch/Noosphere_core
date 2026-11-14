import mysql from "mysql2/promise";
import dotenv from "dotenv";

dotenv.config({ path: "apps/api/.env" });

const pool = mysql.createPool({
  host: process.env.DB_HOST || "localhost",
  port: Number(process.env.DB_PORT || 3306),
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
  database: process.env.DB_NAME,
});

const targets = [
  ["fk_appointments_client", "client_id", "clients"],
  ["fk_appointments_master", "master_id", "masters"],
  ["fk_appointments_service", "service_id", "services"],
  ["fk_appointments_organization", "organization_id", "organizations"],
];

const [existing] = await pool.query(
  `SELECT CONSTRAINT_NAME FROM information_schema.TABLE_CONSTRAINTS
   WHERE TABLE_SCHEMA = ? AND TABLE_NAME = 'appointments'
     AND CONSTRAINT_TYPE = 'FOREIGN KEY'`,
  [process.env.DB_NAME],
);
const existingNames = new Set(existing.map((r) => r.CONSTRAINT_NAME));

for (const [name, column, refTable] of targets) {
  if (existingNames.has(name)) {
    console.log("SKIP (уже есть):", name);
    continue;
  }

  try {
    await pool.query(
      `ALTER TABLE appointments ADD CONSTRAINT ${name}
       FOREIGN KEY (${column}) REFERENCES ${refTable}(id)`,
    );
    console.log("ADDED:", name);
  } catch (error) {
    console.error("FAIL:", name, "->", error.message);
    process.exitCode = 1;
  }
}

const [check] = await pool.query(`SHOW CREATE TABLE appointments`);
console.log(check[0]["Create Table"]);

await pool.end();