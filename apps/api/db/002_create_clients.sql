-- 002: клиенты (clients)
CREATE TABLE IF NOT EXISTS clients (
  id CHAR(36) PRIMARY KEY,
  organization_id CHAR(36) NOT NULL,
  person_id CHAR(36) NULL,
  name VARCHAR(255) NOT NULL,
  phone VARCHAR(64) NULL,
  email VARCHAR(255) NULL,
  source VARCHAR(64) NULL,
  notes TEXT NULL,
  is_active TINYINT(1) NOT NULL DEFAULT 1,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

  INDEX idx_clients_org (organization_id),
  INDEX idx_clients_org_name (organization_id, name),
  INDEX idx_clients_org_phone (organization_id, phone),
  INDEX idx_clients_org_email (organization_id, email),
  INDEX idx_clients_person (person_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;