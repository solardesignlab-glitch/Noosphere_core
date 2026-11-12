import fs from "node:fs";
import path from "node:path";
import { fileURLToPath } from "node:url";
import { getPool } from "./db.js";

const __dirname = path.dirname(fileURLToPath(import.meta.url));

async function main() {
  const sqlPath = path.join(__dirname, "db", "002_create_clients.sql");
  const sql = fs.readFileSync(sqlPath, "utf8");

  const pool = getPool();

  try {
    await pool.query(sql);
    console.log("Clients migration completed");
  } catch (error) {
    console.error("Clients migration failed");
    console.error(error);
    process.exitCode = 1;
  } finally {
    await pool.end();
  }
}

main();
