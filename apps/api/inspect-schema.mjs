import mysql from "mysql2/promise";
import "dotenv/config";

const conn = await mysql.createConnection({
  host: process.env.DB_HOST || "127.0.0.1",
  port: Number(process.env.DB_PORT || 3306),
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
  database: process.env.DB_NAME
});

const tables = ["masters", "services", "clients", "appointments"];

for (const table of tables) {
  const [rows] = await conn.query(`DESCRIBE ??`, [table]);
  console.log(`\n=== ${table} ===`);
  console.table(rows);
}

await conn.end();