import fs from "fs";
import pool from "./src/shared/db/pool.js";

const sql = fs.readFileSync("./db/003_create_services.sql", "utf8");
const statements = sql
  .split(";")
  .map((item) => item.trim())
  .filter(Boolean);

for (const statement of statements) {
  await pool.query(statement);
  console.log("OK:", statement.slice(0, 60).replace(/\s+/g, " "));
}

await pool.end();
console.log("SERVICES_MIGRATION_COMPLETE");