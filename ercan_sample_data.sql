INSERT INTO MODEL (model_name, manufacturer, capacity) VALUES
('Boeing 737', 'Boeing', 180),
('Airbus A320', 'Airbus', 150),
('Bombardier CRJ900', 'Bombardier', 90),
('Airbus A380', 'Airbus', 500),
('Boeing 787', 'Boeing', 290);

INSERT INTO AIRPLANE (plane_no, model_id, status) VALUES
('5Y-KQA', 1, 'ACTIVE'),
('5Y-KQB', 1, 'MAINTENANCE'),
('ET-APK', 2, 'ACTIVE'),
('TC-JNB', 4, 'ACTIVE'),
('9V-SKA', 5, 'ACTIVE');

INSERT INTO HANGAR (hangar_no, location) VALUES
('H001', 'North Terminal'),
('H002', 'South Terminal'),
('H003', 'Maintenance Bay'),
('H004', 'East Terminal'),
('H005', 'West Terminal');

INSERT INTO HANGAR_OCCUPANCY (plane_id, hangar_id, check_in_date, check_out_date) VALUES
(1, 1, '2026-05-01', '2026-05-10'),
(2, 3, '2026-05-05', NULL),
(4, 2, '2026-05-15', NULL);

INSERT INTO TEST (test_name, description, max_score) VALUES
('Engine Test', 'Check engine performance and thrust', 100),
('Wing Inspection', 'Check wing integrity and surface', 100),
('Avionics Check', 'Test electronic systems and navigation', 100),
('Landing Gear', 'Check landing gear operation', 100),
('Emergency Systems', 'Test emergency equipment', 100);

INSERT INTO EMPLOYEE (emp_name, emp_type, union_no, hire_date) VALUES
('Alpha Samura', 'TECHNICIAN', 'UNION001', '2020-01-15'),
('Matarr Barrow', 'TECHNICIAN', 'UNION002', '2021-03-20'),
('Ebrima Khan', 'CONTROLLER', 'UNION003', '2019-11-10'),
('Daniel Johnson', 'TECHNICIAN', 'UNION004', '2022-01-10'),
('Fatima Hassan', 'TECHNICIAN', 'UNION005', '2021-11-20'),
('Ousman Jallow', 'PILOT', 'UNION006', '2020-05-15');

INSERT INTO TECHNICIAN (emp_id, expertise_model_id, certification_date) VALUES
(1, 1, '2020-06-01'),
(2, 2, '2021-08-15'),
(4, 3, '2022-03-01'),
(5, 4, '2022-02-15');

INSERT INTO PILOT (emp_id, license_number, flight_hours, medical_cert_expiry) VALUES
(3, 'PIL-001', 2500, '2027-01-01'),
(6, 'PIL-002', 1800, '2026-12-15');

INSERT INTO TESTING_EVENT (plane_id, test_id, tech_id, test_date, hours_spent, score) VALUES
(1, 1, 1, '2026-05-15', 2.5, 95),
(1, 2, 1, '2026-05-15', 1.5, 88),
(3, 1, 2, '2026-05-14', 3.0, 92),
(2, 3, 2, '2026-05-10', 2.0, 78),
(4, 1, 3, '2026-05-12', 3.5, 96),
(5, 2, 4, '2026-05-13', 1.5, 85);

INSERT INTO MAINTENANCE_RECORD (plane_id, maintenance_type, start_date, end_date, cost, description) VALUES
(2, 'Engine Overhaul', '2026-04-01', '2026-04-15', 50000.00, 'Full engine inspection and repair'),
(1, 'Routine Check', '2026-05-01', '2026-05-02', 5000.00, 'Regular maintenance check'),
(3, 'Avionics Update', '2026-05-10', '2026-05-12', 12000.00, 'Navigation system upgrade');

INSERT INTO FLIGHT_SCHEDULE (flight_no, plane_id, departure_airport, arrival_airport, departure_datetime, arrival_datetime, status) VALUES
('TK123', 1, 'Istanbul', 'London', '2026-05-20 08:00:00', '2026-05-20 10:30:00', 'SCHEDULED'),
('KQ456', 4, 'Nairobi', 'Berlin', '2026-05-21 22:00:00', '2026-05-22 06:00:00', 'SCHEDULED'),
('KL789', 3, 'Amsterdam', 'Paris', '2026-05-22 09:30:00', '2026-05-22 11:00:00', 'SCHEDULED');

INSERT INTO SUPPLIER (supplier_name, contact_person, phone, email, address) VALUES
('Lefkosa Aviation Parts Ltd', 'Mohammed Ali', '+903456789', 'mohammed@aviation.com', 'Lefkosa Airport Road'),
('Cyprus Aero Supplies Co', 'Ahmad Hassan', '+907654321', 'ahmad@aero.com', 'Sanayi Industrial Park'),
('Turkish Technic', 'Mehmet Demir', '+902123456', 'mehmet@turkishtechnic.com', 'Istanbul, Turkey');