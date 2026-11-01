CREATE TABLE IF NOT EXISTS clients (
  id CHAR(36) PRIMARY KEY,
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

  INDEX idx_clients_organization_name (organization_id, name),
  INDEX idx_clients_organization_phone (organization_id, phone),
  INDEX idx_clients_organization_email (organization_id, email),
  INDEX idx_clients_person (person_id)
);