
-- Clinic Booking System Database

-- Drop existing tables if they exist
DROP TABLE IF EXISTS Prescription_Medicine;
DROP TABLE IF EXISTS Prescriptions;
DROP TABLE IF EXISTS Appointments;
DROP TABLE IF EXISTS Medicines;
DROP TABLE IF EXISTS Patients;
DROP TABLE IF EXISTS Doctors;
DROP TABLE IF EXISTS Departments;

-- Departments Table
CREATE TABLE Departments (
    department_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE
);

-- Doctors Table
CREATE TABLE Doctors (
    doctor_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    specialty VARCHAR(100),
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES Departments(department_id)
);

-- Patients Table
CREATE TABLE Patients (
    patient_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    date_of_birth DATE,
    phone VARCHAR(15) UNIQUE,
    email VARCHAR(100) UNIQUE
);

-- Appointments Table
CREATE TABLE Appointments (
    appointment_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT,
    doctor_id INT,
    appointment_date DATETIME NOT NULL,
    reason TEXT,
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id)
);

-- Prescriptions Table
CREATE TABLE Prescriptions (
    prescription_id INT AUTO_INCREMENT PRIMARY KEY,
    appointment_id INT,
    notes TEXT,
    FOREIGN KEY (appointment_id) REFERENCES Appointments(appointment_id)
);

-- Medicines Table
CREATE TABLE Medicines (
    medicine_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT
);

-- Many-to-Many Table: Prescription_Medicine
CREATE TABLE Prescription_Medicine (
    prescription_id INT,
    medicine_id INT,
    dosage VARCHAR(50),
    PRIMARY KEY (prescription_id, medicine_id),
    FOREIGN KEY (prescription_id) REFERENCES Prescriptions(prescription_id),
    FOREIGN KEY (medicine_id) REFERENCES Medicines(medicine_id)
);

-- Sample Data Insertion

-- Departments
INSERT INTO Departments (name) VALUES 
('Cardiology'), 
('Neurology'), 
('General Medicine');

-- Doctors
INSERT INTO Doctors (name, specialty, department_id) VALUES 
('Dr. Alice Smith', 'Cardiologist', 1),
('Dr. Bob Jones', 'Neurologist', 2),
('Dr. Clara White', 'General Physician', 3);

-- Patients
INSERT INTO Patients (name, date_of_birth, phone, email) VALUES 
('John Doe', '1985-06-15', '1234567890', 'john@example.com'),
('Jane Roe', '1990-09-30', '0987654321', 'jane@example.com');

-- Appointments
INSERT INTO Appointments (patient_id, doctor_id, appointment_date, reason) VALUES 
(1, 1, '2025-05-10 10:00:00', 'Routine Checkup'),
(2, 3, '2025-05-12 14:30:00', 'Flu Symptoms');

-- Prescriptions
INSERT INTO Prescriptions (appointment_id, notes) VALUES 
(1, 'Prescribed blood pressure medication'),
(2, 'Recommended rest and paracetamol');

-- Medicines
INSERT INTO Medicines (name, description) VALUES 
('Atenolol', 'Used to treat high blood pressure'),
('Paracetamol', 'Used to relieve pain and reduce fever');

-- Prescription_Medicine
INSERT INTO Prescription_Medicine (prescription_id, medicine_id, dosage) VALUES 
(1, 1, '50mg once daily'),
(2, 2, '500mg every 6 hours');
