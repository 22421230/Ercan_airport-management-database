CREATE DATABASE Ercan_airport_management;
USE Ercan_airport_management;

CREATE TABLE MODEL (
    model_id INT PRIMARY KEY AUTO_INCREMENT,
    model_name VARCHAR(50) NOT NULL,
    manufacturer VARCHAR(50),
    capacity INT
);

CREATE TABLE AIRPLANE (
    plane_id INT PRIMARY KEY AUTO_INCREMENT,
    plane_no VARCHAR(20) UNIQUE NOT NULL,
    model_id INT,
    status VARCHAR(20) DEFAULT 'ACTIVE',
    FOREIGN KEY (model_id) REFERENCES MODEL(model_id)
);

CREATE TABLE HANGAR (
    hangar_id INT PRIMARY KEY AUTO_INCREMENT,
    hangar_no VARCHAR(20) UNIQUE NOT NULL,
    location VARCHAR(100)
);

CREATE TABLE HANGAR_OCCUPANCY (
    occupancy_id INT PRIMARY KEY AUTO_INCREMENT,
    plane_id INT,
    hangar_id INT,
    check_in_date DATE,
    check_out_date DATE,
    FOREIGN KEY (plane_id) REFERENCES AIRPLANE(plane_id),
    FOREIGN KEY (hangar_id) REFERENCES HANGAR(hangar_id)
);

CREATE TABLE TEST (
    test_id INT PRIMARY KEY AUTO_INCREMENT,
    test_name VARCHAR(50) NOT NULL,
    description VARCHAR(200),
    max_score INT
);

CREATE TABLE EMPLOYEE (
    emp_id INT PRIMARY KEY AUTO_INCREMENT,
    emp_name VARCHAR(100) NOT NULL,
    emp_type VARCHAR(20) CHECK (emp_type IN ('TECHNICIAN', 'CONTROLLER', 'PILOT')),
    union_no VARCHAR(30) UNIQUE,
    hire_date DATE
);

CREATE TABLE TECHNICIAN (
    tech_id INT PRIMARY KEY AUTO_INCREMENT,
    emp_id INT UNIQUE,
    expertise_model_id INT,
    certification_date DATE,
    FOREIGN KEY (emp_id) REFERENCES EMPLOYEE(emp_id),
    FOREIGN KEY (expertise_model_id) REFERENCES MODEL(model_id)
);

CREATE TABLE PILOT (
    pilot_id INT PRIMARY KEY AUTO_INCREMENT,
    emp_id INT UNIQUE,
    license_number VARCHAR(30) UNIQUE NOT NULL,
    flight_hours INT DEFAULT 0,
    medical_cert_expiry DATE,
    FOREIGN KEY (emp_id) REFERENCES EMPLOYEE(emp_id)
);

CREATE TABLE TESTING_EVENT (
    event_id INT PRIMARY KEY AUTO_INCREMENT,
    plane_id INT,
    test_id INT,
    tech_id INT,
    test_date DATE,
    hours_spent DECIMAL(5,2),
    score INT,
    FOREIGN KEY (plane_id) REFERENCES AIRPLANE(plane_id),
    FOREIGN KEY (test_id) REFERENCES TEST(test_id),
    FOREIGN KEY (tech_id) REFERENCES TECHNICIAN(tech_id)
);

CREATE TABLE MAINTENANCE_RECORD (
    maintenance_id INT PRIMARY KEY AUTO_INCREMENT,
    plane_id INT,
    maintenance_type VARCHAR(50),
    start_date DATE,
    end_date DATE,
    cost DECIMAL(10,2),
    description TEXT,
    FOREIGN KEY (plane_id) REFERENCES AIRPLANE(plane_id)
);

CREATE TABLE FLIGHT_SCHEDULE (
    flight_id INT PRIMARY KEY AUTO_INCREMENT,
    flight_no VARCHAR(20) NOT NULL,
    plane_id INT,
    departure_airport VARCHAR(50),
    arrival_airport VARCHAR(50),
    departure_datetime DATETIME,
    arrival_datetime DATETIME,
    status VARCHAR(20) DEFAULT 'SCHEDULED',
    FOREIGN KEY (plane_id) REFERENCES AIRPLANE(plane_id)
);

CREATE TABLE SUPPLIER (
    supplier_id INT PRIMARY KEY AUTO_INCREMENT,
    supplier_name VARCHAR(100) NOT NULL,
    contact_person VARCHAR(100),
    phone VARCHAR(20),
    email VARCHAR(100),
    address TEXT
);

