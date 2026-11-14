ALTER TABLE appointments
  ADD CONSTRAINT fk_appointments_client
  FOREIGN KEY (client_id) REFERENCES clients(id),
  ADD CONSTRAINT fk_appointments_master
  FOREIGN KEY (master_id) REFERENCES masters(id),
  ADD CONSTRAINT fk_appointments_service
  FOREIGN KEY (service_id) REFERENCES services(id);