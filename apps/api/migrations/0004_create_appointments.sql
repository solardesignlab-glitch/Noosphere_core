CREATE TABLE IF NOT EXISTS appointments (
  id CHAR(36) NOT NULL PRIMARY KEY,
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
  KEY idx_appointments_organization (organization_id),
  KEY idx_appointments_master_time (master_id, starts_at, ends_at),
  CONSTRAINT fk_appointments_client FOREIGN KEY (client_id) REFERENCES clients(id),
  CONSTRAINT fk_appointments_master FOREIGN KEY (master_id) REFERENCES masters(id),
  CONSTRAINT fk_appointments_organization FOREIGN KEY (organization_id) REFERENCES organizations(id),
  CONSTRAINT fk_appointments_service FOREIGN KEY (service_id) REFERENCES services(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
