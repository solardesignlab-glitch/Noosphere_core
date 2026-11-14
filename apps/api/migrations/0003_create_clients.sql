CREATE TABLE IF NOT EXISTS clients (
  id CHAR(36) NOT NULL PRIMARY KEY,
  organization_id CHAR(36) NOT NULL,
  person_id CHAR(36) NULL,
  source VARCHAR(64) NULL,
  name VARCHAR(255) NOT NULL,
  phone VARCHAR(32) NULL,
  email VARCHAR(255) NULL,
  notes TEXT NULL,
  is_active TINYINT(1) NOT NULL DEFAULT 1,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  KEY idx_clients_organization_name (organization_id, name),
  KEY idx_clients_organization_phone (organization_id, phone),
  KEY idx_clients_organization_email (organization_id, email),
  KEY idx_clients_person (person_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
