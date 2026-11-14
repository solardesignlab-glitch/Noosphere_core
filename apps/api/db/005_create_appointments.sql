-- 005: записи (appointments)
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
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

  INDEX idx_appointments_organization (organization_id),
  INDEX idx_appointments_org_start (organization_id, starts_at),
  INDEX idx_appointments_org_status (organization_id, status),
  INDEX idx_appointments_client (client_id),
  INDEX idx_appointments_service (service_id),
  INDEX idx_appointments_master_time (master_id, starts_at, ends_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
