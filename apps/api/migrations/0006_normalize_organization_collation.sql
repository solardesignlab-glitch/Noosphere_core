ALTER TABLE appointments
  MODIFY organization_id CHAR(36) CHARACTER SET utf8mb4
  COLLATE utf8mb4_uca1400_ai_ci NOT NULL;

ALTER TABLE appointments
  ADD CONSTRAINT fk_appointments_organization
  FOREIGN KEY (organization_id) REFERENCES organizations(id);