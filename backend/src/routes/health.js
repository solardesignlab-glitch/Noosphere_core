import { Router } from "express";
import mysql from "mysql2/promise";

const router = Router();

router.get(["/", "/health"], async (req, res) => {
  let db = "down";

  try {
    const connection = await mysql.createConnection({
      host: process.env.DB_HOST || "localhost",
      port: Number(process.env.DB_PORT || 3306),
      user: process.env.DB_USER,
      password: process.env.DB_PASSWORD,
      database: process.env.DB_NAME,
    });

    await connection.ping();
    await connection.end();

    db = "up";
  } catch (error) {
    console.error("Health DB check failed:", error.message);
  }

  res.json({
    status: "ok",
    service: "atmosfera-backend",
    db,
  });
});

router.get("/db-audit", async (req, res) => {
  let connection;

  try {
    connection = await mysql.createConnection({
      host: process.env.DB_HOST || "localhost",
      port: Number(process.env.DB_PORT || 3306),
      user: process.env.DB_USER,
      password: process.env.DB_PASSWORD,
      database: process.env.DB_NAME,
    });

    const [rows] = await connection.query("SHOW TABLES;");
    const key = `Tables_in_${process.env.DB_NAME || "ucp"}`;
    const tables = rows.map((row) => row[key]);

    res.json({
      status: "ok",
      service: "atmosfera-backend",
      db: "up",
      tables,
    });
  } catch (error) {
    console.error("DB audit error:", error.message);
    res.status(500).json({
      status: "error",
      error: error.message,
    });
  } finally {
    if (connection) {
      await connection.end();
    }
  }
});

export default router;
