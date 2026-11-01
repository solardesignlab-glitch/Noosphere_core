import pool from "./src/shared/db/pool.js";

const fk = await pool.query(`
  SELECT
    TABLE_NAME,
    COLUMN_NAME,
    CONSTRAINT_NAME,
    REFERENCED_TABLE_NAME,
    REFERENCED_COLUMN_NAME
  FROM information_schema.KEY_COLUMN_USAGE
  WHERE REFERENCED_TABLE_NAME = 'organizations'
    AND TABLE_SCHEMA = DATABASE()
`);

console.log("FOREIGN_KEYS:", fk[0]);

const tables = await pool.query("SHOW TABLES");
console.log("TABLES:", tables[0]);

const create = await pool.query("SHOW CREATE TABLE organizations");
console.log("ORGANIZATIONS_SCHEMA:");
console.log(create[0][0]["Create Table"]);

const orgs = await pool.query("SELECT * FROM organizations LIMIT 10");
console.log("ORGANIZATIONS_DATA:", orgs[0]);

await pool.end();
