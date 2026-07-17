-- Run this file in MySQL Workbench first
DROP DATABASE IF EXISTS HospitalManagementSystem;
CREATE DATABASE HospitalManagementSystem;
USE HospitalManagementSystem;

CREATE TABLE Departments (
    DepartmentID INT AUTO_INCREMENT PRIMARY KEY,
    DepartmentName VARCHAR(100) NOT NULL,
    FloorNumber INT,
    ContactNumber VARCHAR(15)
);

CREATE TABLE Doctors (
    DoctorID INT AUTO_INCREMENT PRIMARY KEY,
    FullName VARCHAR(100) NOT NULL,
    Gender ENUM('Male', 'Female', 'Other'),
    Specialization VARCHAR(100) NOT NULL,
    Phone VARCHAR(15) NOT NULL,
    Email VARCHAR(100),
    DepartmentID INT,
    ConsultationFee DECIMAL(10,2),
    AvailabilityStatus ENUM('Available', 'On Leave', 'In Surgery') DEFAULT 'Available',
    FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);

CREATE TABLE Patients (
    PatientID INT AUTO_INCREMENT PRIMARY KEY,
    FullName VARCHAR(100) NOT NULL,
    Gender ENUM('Male', 'Female', 'Other'),
    DateOfBirth DATE,
    BloodGroup VARCHAR(5),
    Phone VARCHAR(15),
    Email VARCHAR(100),
    Address VARCHAR(255),
    EmergencyContactName VARCHAR(100),
    EmergencyContactPhone VARCHAR(15),
    RegistrationDate DATE DEFAULT (CURRENT_DATE)
);

CREATE TABLE Nurses (
    NurseID INT AUTO_INCREMENT PRIMARY KEY,
    FullName VARCHAR(100) NOT NULL,
    Gender ENUM('Male', 'Female', 'Other'),
    Phone VARCHAR(15),
    Email VARCHAR(100),
    DepartmentID INT,
    Shift ENUM('Morning', 'Evening', 'Night'),
    MonthlySalary DECIMAL(10,2),
    FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);

CREATE TABLE Receptionists (
    ReceptionistID INT AUTO_INCREMENT PRIMARY KEY,
    FullName VARCHAR(100) NOT NULL,
    Phone VARCHAR(15),
    Email VARCHAR(100),
    Shift ENUM('Morning', 'Evening', 'Night'),
    MonthlySalary DECIMAL(10,2)
);

CREATE TABLE Appointments (
    AppointmentID INT AUTO_INCREMENT PRIMARY KEY,
    PatientID INT,
    DoctorID INT,
    AppointmentDate DATE,
    AppointmentTime TIME,
    Reason VARCHAR(255),
    Status ENUM('Scheduled', 'Completed', 'Cancelled') DEFAULT 'Scheduled',
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID),
    FOREIGN KEY (DoctorID) REFERENCES Doctors(DoctorID)
);

CREATE TABLE Diagnoses (
    DiagnosisID INT AUTO_INCREMENT PRIMARY KEY,
    AppointmentID INT,
    DoctorID INT,
    PatientID INT,
    DiagnosisDetails TEXT,
    DiagnosisDate DATE,
    FOREIGN KEY (AppointmentID) REFERENCES Appointments(AppointmentID),
    FOREIGN KEY (DoctorID) REFERENCES Doctors(DoctorID),
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID)
);

CREATE TABLE Prescriptions (
    PrescriptionID INT AUTO_INCREMENT PRIMARY KEY,
    AppointmentID INT,
    DoctorID INT,
    PatientID INT,
    PrescriptionDate DATE,
    Notes TEXT,
    FOREIGN KEY (AppointmentID) REFERENCES Appointments(AppointmentID),
    FOREIGN KEY (DoctorID) REFERENCES Doctors(DoctorID),
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID)
);

CREATE TABLE Medicines (
    MedicineID INT AUTO_INCREMENT PRIMARY KEY,
    MedicineName VARCHAR(100) NOT NULL,
    Category VARCHAR(50),
    UnitPrice DECIMAL(10,2),
    StockQuantity INT,
    ExpiryDate DATE
);

CREATE TABLE Prescription_Items (
    ItemID INT AUTO_INCREMENT PRIMARY KEY,
    PrescriptionID INT,
    MedicineID INT,
    Dosage VARCHAR(50),
    Frequency VARCHAR(50),
    DurationDays INT,
    FOREIGN KEY (PrescriptionID) REFERENCES Prescriptions(PrescriptionID),
    FOREIGN KEY (MedicineID) REFERENCES Medicines(MedicineID)
);

CREATE TABLE Wards (
    WardID INT AUTO_INCREMENT PRIMARY KEY,
    WardName VARCHAR(50),
    WardType ENUM('General', 'Cabin', 'ICU', 'Emergency'),
    FloorNumber INT
);

CREATE TABLE Rooms (
    RoomID INT AUTO_INCREMENT PRIMARY KEY,
    WardID INT,
    RoomNumber VARCHAR(20) NOT NULL,
    BedCount INT,
    DailyCharge DECIMAL(10,2),
    AvailabilityStatus ENUM('Available', 'Occupied', 'Under Maintenance') DEFAULT 'Available',
    FOREIGN KEY (WardID) REFERENCES Wards(WardID)
);

CREATE TABLE Admissions (
    AdmissionID INT AUTO_INCREMENT PRIMARY KEY,
    PatientID INT,
    DoctorID INT,
    RoomID INT,
    AdmissionDate DATE,
    DischargeDate DATE,
    AdmissionReason VARCHAR(255),
    Status ENUM('Admitted', 'Discharged') DEFAULT 'Admitted',
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID),
    FOREIGN KEY (DoctorID) REFERENCES Doctors(DoctorID),
    FOREIGN KEY (RoomID) REFERENCES Rooms(RoomID)
);

CREATE TABLE Lab_Tests (
    TestID INT AUTO_INCREMENT PRIMARY KEY,
    TestName VARCHAR(100) NOT NULL,
    Category VARCHAR(50),
    TestFee DECIMAL(10,2)
);

CREATE TABLE Lab_Reports (
    ReportID INT AUTO_INCREMENT PRIMARY KEY,
    PatientID INT,
    DoctorID INT,
    TestID INT,
    TestDate DATE,
    ResultDetails TEXT,
    Status ENUM('Pending', 'Completed') DEFAULT 'Pending',
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID),
    FOREIGN KEY (DoctorID) REFERENCES Doctors(DoctorID),
    FOREIGN KEY (TestID) REFERENCES Lab_Tests(TestID)
);

CREATE TABLE Bills (
    BillID INT AUTO_INCREMENT PRIMARY KEY,
    PatientID INT,
    AppointmentID INT NULL,
    AdmissionID INT NULL,
    BillDate DATE,
    TotalAmount DECIMAL(12,2),
    BillStatus ENUM('Paid', 'Unpaid', 'Partially Paid') DEFAULT 'Unpaid',
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID),
    FOREIGN KEY (AppointmentID) REFERENCES Appointments(AppointmentID),
    FOREIGN KEY (AdmissionID) REFERENCES Admissions(AdmissionID)
);

CREATE TABLE Payments (
    PaymentID INT AUTO_INCREMENT PRIMARY KEY,
    BillID INT,
    AmountPaid DECIMAL(12,2),
    PaymentDate DATE,
    PaymentMethod ENUM('Cash', 'Card', 'Bank Transfer', 'bKash', 'Nagad'),
    FOREIGN KEY (BillID) REFERENCES Bills(BillID)
);

CREATE TABLE Doctor_Attendance (
    AttendanceID INT AUTO_INCREMENT PRIMARY KEY,
    DoctorID INT,
    AttendanceDate DATE,
    Shift ENUM('Morning', 'Evening', 'Night'),
    Status ENUM('Present', 'Absent', 'On Leave'),
    FOREIGN KEY (DoctorID) REFERENCES Doctors(DoctorID)
);

CREATE TABLE Nurse_Attendance (
    AttendanceID INT AUTO_INCREMENT PRIMARY KEY,
    NurseID INT,
    AttendanceDate DATE,
    Shift ENUM('Morning', 'Evening', 'Night'),
    Status ENUM('Present', 'Absent', 'On Leave'),
    FOREIGN KEY (NurseID) REFERENCES Nurses(NurseID)
);

INSERT INTO Departments (DepartmentName, FloorNumber, ContactNumber) VALUES
('Cardiology', 2, '01710000001'),
('Neurology', 3, '01710000002'),
('Orthopedics', 4, '01710000003'),
('Pediatrics', 5, '01710000004'),
('Gynecology', 6, '01710000005'),
('Emergency', 1, '01710000006'),
('Radiology', 2, '01710000007'),
('Pathology', 3, '01710000008');

INSERT INTO Doctors (FullName, Gender, Specialization, Phone, Email, DepartmentID, ConsultationFee, AvailabilityStatus) VALUES
('Dr. Ahmed Rahman', 'Male', 'Cardiologist', '01810000001', 'ahmed@hospital.com', 1, 1000.00, 'Available'),
('Dr. Nusrat Jahan', 'Female', 'Neurologist', '01810000002', 'nusrat@hospital.com', 2, 1200.00, 'Available'),
('Dr. Imran Kabir', 'Male', 'Orthopedic Surgeon', '01810000003', 'imran@hospital.com', 3, 1500.00, 'In Surgery'),
('Dr. Farzana Islam', 'Female', 'Pediatrician', '01810000004', 'farzana@hospital.com', 4, 900.00, 'Available'),
('Dr. Shakil Ahmed', 'Male', 'Gynecologist', '01810000005', 'shakil@hospital.com', 5, 1100.00, 'On Leave'),
('Dr. Rima Akter', 'Female', 'Emergency Specialist', '01810000006', 'rima@hospital.com', 6, 800.00, 'Available');

INSERT INTO Patients (FullName, Gender, DateOfBirth, BloodGroup, Phone, Email, Address, EmergencyContactName, EmergencyContactPhone) VALUES
('Md. Arif Hossain', 'Male', '1998-05-10', 'A+', '01911000001', 'arif@gmail.com', 'Dhaka', 'Rahim Hossain', '01922000001'),
('Sadia Akter', 'Female', '2000-02-18', 'B+', '01911000002', 'sadia@gmail.com', 'Gazipur', 'Hasina Akter', '01922000002'),
('Tanvir Hasan', 'Male', '1995-08-22', 'O+', '01911000003', 'tanvir@gmail.com', 'Narayanganj', 'Rashida Begum', '01922000003'),
('Nusrat Mimi', 'Female', '2003-11-11', 'AB+', '01911000004', 'mimi@gmail.com', 'Dhaka', 'Selina Begum', '01922000004'),
('Rakibul Islam', 'Male', '1989-01-15', 'B-', '01911000005', 'rakib@gmail.com', 'Mymensingh', 'Jalal Uddin', '01922000005');

INSERT INTO Nurses (FullName, Gender, Phone, Email, DepartmentID, Shift, MonthlySalary) VALUES
('Shamima Rahman', 'Female', '01730000001', 'shamima@hospital.com', 1, 'Morning', 30000.00),
('Rafiq Hasan', 'Male', '01730000002', 'rafiq@hospital.com', 2, 'Evening', 32000.00),
('Tania Akter', 'Female', '01730000003', 'tania@hospital.com', 6, 'Night', 35000.00),
('Mokhlesur Rahman', 'Male', '01730000004', 'mokhles@hospital.com', 4, 'Morning', 31000.00);

INSERT INTO Receptionists (FullName, Phone, Email, Shift, MonthlySalary) VALUES
('Jannat Akter', '01740000001', 'jannat@hospital.com', 'Morning', 25000.00),
('Sabbir Ahmed', '01740000002', 'sabbir@hospital.com', 'Evening', 25500.00);

INSERT INTO Appointments (PatientID, DoctorID, AppointmentDate, AppointmentTime, Reason, Status) VALUES
(1, 1, '2026-04-10', '10:00:00', 'Chest pain', 'Completed'),
(2, 2, '2026-04-11', '11:00:00', 'Migraine', 'Completed'),
(3, 3, '2026-04-12', '12:00:00', 'Leg fracture', 'Scheduled'),
(4, 4, '2026-04-12', '09:30:00', 'Fever', 'Completed'),
(5, 6, '2026-04-13', '08:30:00', 'Emergency injury', 'Completed');

INSERT INTO Diagnoses (AppointmentID, DoctorID, PatientID, DiagnosisDetails, DiagnosisDate) VALUES
(1, 1, 1, 'Mild cardiac issue, advised ECG and medicine.', '2026-04-10'),
(2, 2, 2, 'Migraine confirmed, advised rest and test.', '2026-04-11'),
(4, 4, 4, 'Seasonal viral fever.', '2026-04-12'),
(5, 6, 5, 'Soft tissue injury.', '2026-04-13');

INSERT INTO Prescriptions (AppointmentID, DoctorID, PatientID, PrescriptionDate, Notes) VALUES
(1, 1, 1, '2026-04-10', 'Avoid oily food and stress'),
(2, 2, 2, '2026-04-11', 'Sleep properly and reduce screen time'),
(4, 4, 4, '2026-04-12', 'Take soft diet and rest'),
(5, 6, 5, '2026-04-13', 'Follow dressing routine');

INSERT INTO Medicines (MedicineName, Category, UnitPrice, StockQuantity, ExpiryDate) VALUES
('Napa', 'Tablet', 2.00, 1000, '2027-12-31'),
('Seclo', 'Capsule', 8.00, 500, '2027-10-31'),
('Ace', 'Tablet', 3.00, 700, '2027-08-31'),
('Antacid Syrup', 'Syrup', 120.00, 150, '2027-11-30'),
('Ceevit', 'Tablet', 1.50, 900, '2027-09-30');

INSERT INTO Prescription_Items (PrescriptionID, MedicineID, Dosage, Frequency, DurationDays) VALUES
(1, 2, '1 Capsule', '2 times daily', 7),
(1, 5, '1 Tablet', '1 time daily', 10),
(2, 1, '1 Tablet', '3 times daily', 5),
(3, 1, '1 Tablet', '3 times daily', 4),
(4, 4, '2 Spoon', '2 times daily', 5);

INSERT INTO Wards (WardName, WardType, FloorNumber) VALUES
('General Ward A', 'General', 2),
('Cabin Block B', 'Cabin', 3),
('ICU Unit', 'ICU', 1),
('Emergency Ward', 'Emergency', 1);

INSERT INTO Rooms (WardID, RoomNumber, BedCount, DailyCharge, AvailabilityStatus) VALUES
(1, 'G201', 4, 1500.00, 'Available'),
(1, 'G202', 4, 1500.00, 'Occupied'),
(2, 'C301', 1, 4000.00, 'Occupied'),
(2, 'C302', 1, 4000.00, 'Available'),
(3, 'ICU01', 1, 8000.00, 'Occupied'),
(4, 'E101', 2, 2500.00, 'Available');

INSERT INTO Admissions (PatientID, DoctorID, RoomID, AdmissionDate, DischargeDate, AdmissionReason, Status) VALUES
(1, 1, 3, '2026-04-10', NULL, 'Observation for chest problem', 'Admitted'),
(3, 3, 5, '2026-04-12', NULL, 'Fracture treatment', 'Admitted'),
(5, 6, 2, '2026-04-13', '2026-04-15', 'Emergency trauma', 'Discharged');

INSERT INTO Lab_Tests (TestName, Category, TestFee) VALUES
('CBC', 'Blood Test', 500.00),
('X-Ray', 'Imaging', 1200.00),
('ECG', 'Cardiac Test', 1500.00),
('MRI', 'Imaging', 5000.00),
('Blood Sugar', 'Blood Test', 300.00);

INSERT INTO Lab_Reports (PatientID, DoctorID, TestID, TestDate, ResultDetails, Status) VALUES
(1, 1, 3, '2026-04-10', 'Minor abnormality detected.', 'Completed'),
(2, 2, 1, '2026-04-11', 'Values within acceptable range.', 'Completed'),
(3, 3, 2, '2026-04-12', 'Hairline fracture detected.', 'Completed'),
(4, 4, 5, '2026-04-12', 'Normal sugar level.', 'Completed'),
(5, 6, 1, '2026-04-13', 'Pending sample review.', 'Pending');

INSERT INTO Bills (PatientID, AppointmentID, AdmissionID, BillDate, TotalAmount, BillStatus) VALUES
(1, 1, 1, '2026-04-10', 8500.00, 'Partially Paid'),
(2, 2, NULL, '2026-04-11', 1700.00, 'Paid'),
(3, 3, 2, '2026-04-12', 12000.00, 'Unpaid'),
(4, 4, NULL, '2026-04-12', 1200.00, 'Paid'),
(5, 5, 3, '2026-04-13', 6000.00, 'Paid');

INSERT INTO Payments (BillID, AmountPaid, PaymentDate, PaymentMethod) VALUES
(1, 3000.00, '2026-04-10', 'Cash'),
(2, 1700.00, '2026-04-11', 'bKash'),
(4, 1200.00, '2026-04-12', 'Card'),
(5, 6000.00, '2026-04-13', 'Nagad');
