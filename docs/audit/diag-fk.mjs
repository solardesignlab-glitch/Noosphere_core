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

const [cols] = await pool.query(
  `SELECT TABLE_NAME, COLUMN_NAME, COLUMN_TYPE,
          CHARACTER_SET_NAME, COLLATION_NAME
   FROM information_schema.COLUMNS
   WHERE TABLE_SCHEMA = ?
     AND TABLE_NAME IN ('organizations','clients','masters','services','appointments')
     AND COLUMN_NAME IN ('id','organization_id','client_id','master_id','service_id')
   ORDER BY TABLE_NAME, ORDINAL_POSITION`,
  [process.env.DB_NAME],
);

console.table(cols);

const fks = [
  ["fk_diag_client", "client_id", "clients"],
  ["fk_diag_master", "master_id", "masters"],
  ["fk_diag_service", "service_id", "services"],
  ["fk_diag_organization", "organization_id", "organizations"],
];

for (const [name, column, refTable] of fks) {
  try {
    await pool.query(
      `ALTER TABLE appointments ADD CONSTRAINT ${name}
       FOREIGN KEY (${column}) REFERENCES ${refTable}(id)`,
    );
    await pool.query(`ALTER TABLE appointments DROP FOREIGN KEY ${name}`);
    console.log("OK:", column, "->", refTable);
  } catch (error) {
    console.log("FAIL:", column, "->", refTable, "->", error.message);
  }
}

await pool.end();