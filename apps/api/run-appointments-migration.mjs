import pool from "./src/shared/db/pool.js";

const sql = `
CREATE TABLE IF NOT EXISTS appointments (
  id CHAR(36) PRIMARY KEY,
  organization_id CHAR(36) NOT NULL,
  client_id CHAR(36) NOT NULL,
  master_id CHAR(36) NOT NULL,
  service_id CHAR(36) NOT NULL,
  starts_at DATETIME NOT NULL,
  ends_at DATETIME NOT NULL,
  status VARCHAR(32) NOT NULL DEFAULT 'scheduled',
  notes TEXT NULL,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP NULL DEFAULT NULL,
  INDEX idx_appointments_organization (organization_id),
  INDEX idx_appointments_master_time (master_id, starts_at, ends_at)
);
`;

async function main() {
  try {
    await pool.query(sql);
    console.log("Appointments migration completed.");
  } catch (error) {
    console.error("Appointments migration failed:");
    console.error(error);
    process.exitCode = 1;
  } finally {
    await pool.end();
  }
}

main();
