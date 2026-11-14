import fs from "node:fs";
import path from "node:path";
import { fileURLToPath } from "node:url";
import pool from "./src/shared/db/pool.js";

const __dirname = path.dirname(fileURLToPath(import.meta.url));

async function main() {
  const sqlPath = path.join(__dirname, "db", "004_create_masters.sql");
  const sql = fs.readFileSync(sqlPath, "utf8");

  try {
    await pool.query(sql);
    console.log("Masters migration completed.");
  } catch (error) {
    console.error("Masters migration failed:");
    console.error(error);
    process.exitCode = 1;
  } finally {
    await pool.end();
  }
}

main();