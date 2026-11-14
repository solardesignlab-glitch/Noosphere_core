import fs from "node:fs/promises";
import path from "node:path";
import { fileURLToPath } from "node:url";
import mysql from "mysql2/promise";

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const migrationsDir = path.join(__dirname, "migrations");

const {
  DB_HOST = "127.0.0.1",
  DB_PORT = "3306",
  DB_USER = "root",
  DB_PASSWORD = "",
  DB_NAME = "atmoos",
} = process.env;

const pool = mysql.createPool({
  host: DB_HOST,
  port: Number(DB_PORT),
  user: DB_USER,
  password: DB_PASSWORD,
  database: DB_NAME,
  waitForConnections: true,
  connectionLimit: 2,
  multipleStatements: true,
});

async function ensureMigrationsTable() {
  await pool.query(`
    CREATE TABLE IF NOT EXISTS schema_migrations (
      id VARCHAR(255) PRIMARY KEY,
      applied_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
    ) ENGINE=InnoDB;
  `);
}

async function getAppliedMigrations() {
  const [rows] = await pool.query(
    "SELECT id FROM schema_migrations ORDER BY id ASC"
  );

  return new Set(rows.map((row) => row.id));
}

async function getMigrationFiles() {
  const entries = await fs.readdir(migrationsDir);

  return entries
    .filter((name) => name.endsWith(".sql"))
    .sort();
}

function splitSqlStatements(sql) {
  return sql
    .split(/^\s*--\s*statement:\s*$/gim)
    .map((statement) => statement.trim())
    .filter(Boolean);
}

async function applyMigration(file, sql) {
  const connection = await pool.getConnection();

  try {
    await connection.beginTransaction();

    const statements = splitSqlStatements(sql);

    for (const statement of statements) {
      await connection.query(statement);
    }

    await connection.query(
      "INSERT INTO schema_migrations (id) VALUES (?)",
      [file]
    );

    await connection.commit();

    console.log(`APPLIED: ${file}`);
  } catch (error) {
    await connection.rollback();

    console.error(`FAILED: ${file}`);
    console.error(error.message);

    process.exitCode = 1;
  } finally {
    connection.release();
  }
}

async function showStatus(applied, files) {
  console.log("Migration status:");

  for (const file of files) {
    console.log(`${applied.has(file) ? "[x]" : "[ ]"} ${file}`);
  }

  const pending = files.filter((file) => !applied.has(file));

  console.log(`\nApplied: ${files.length - pending.length}`);
  console.log(`Pending: ${pending.length}`);
}

async function main() {
  const showStatusOnly = process.argv.includes("--status");

  await ensureMigrationsTable();

  const applied = await getAppliedMigrations();
  const files = await getMigrationFiles();

  if (showStatusOnly) {
    await showStatus(applied, files);
    return;
  }

  const pending = files.filter((file) => !applied.has(file));

  if (pending.length === 0) {
    console.log("Database is up to date.");
    return;
  }

  for (const file of pending) {
    const sql = await fs.readFile(
      path.join(migrationsDir, file),
      "utf8"
    );

    await applyMigration(file, sql);

    if (process.exitCode === 1) {
      break;
    }
  }
}

main()
  .catch((error) => {
    console.error("MIGRATION RUNNER ERROR:", error.message);
    process.exitCode = 1;
  })
  .finally(async () => {
    await pool.end();
  });