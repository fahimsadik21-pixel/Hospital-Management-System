from __future__ import annotations

from datetime import datetime
from typing import Any

from flask import Flask, flash, redirect, render_template, request, url_for
import mysql.connector
from mysql.connector import Error

app = Flask(__name__)
app.secret_key = "hospital-secret-key-change-me"

DB_CONFIG = {
    "host": "localhost",
    "user": "root",
    "password": "12345678",
    "database": "HospitalManagementSystem",
}


def get_db_connection():
    return mysql.connector.connect(**DB_CONFIG)


def fetch_all(query: str, params: tuple[Any, ...] = ()):
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)
    cursor.execute(query, params)
    rows = cursor.fetchall()
    cursor.close()
    conn.close()
    return rows


def fetch_one(query: str, params: tuple[Any, ...] = ()):
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)
    cursor.execute(query, params)
    row = cursor.fetchone()
    cursor.close()
    conn.close()
    return row


def execute_query(query: str, params: tuple[Any, ...] = ()):
    conn = get_db_connection()
    cursor = conn.cursor()
    cursor.execute(query, params)
    conn.commit()
    cursor.close()
    conn.close()


@app.context_processor
def inject_now():
    return {"current_year": datetime.now().year}


@app.route("/")
def dashboard():
    stats = {
        "patients": fetch_one("SELECT COUNT(*) AS total FROM Patients")["total"],
        "doctors": fetch_one("SELECT COUNT(*) AS total FROM Doctors")["total"],
        "appointments": fetch_one("SELECT COUNT(*) AS total FROM Appointments")["total"],
        "admitted": fetch_one("SELECT COUNT(*) AS total FROM Admissions WHERE Status='Admitted'")["total"],
        "rooms_available": fetch_one("SELECT COUNT(*) AS total FROM Rooms WHERE AvailabilityStatus='Available'")["total"],
        "revenue": fetch_one("SELECT COALESCE(SUM(AmountPaid), 0) AS total FROM Payments")["total"],
    }

    recent_appointments = fetch_all(
        """
        SELECT a.AppointmentID, p.FullName AS patient_name, d.FullName AS doctor_name,
               a.AppointmentDate, a.AppointmentTime, a.Status
        FROM Appointments a
        JOIN Patients p ON a.PatientID = p.PatientID
        JOIN Doctors d ON a.DoctorID = d.DoctorID
        ORDER BY a.AppointmentDate DESC, a.AppointmentTime DESC
        LIMIT 8
        """
    )

    recent_bills = fetch_all(
        """
        SELECT b.BillID, p.FullName AS patient_name, b.TotalAmount, b.BillStatus, b.BillDate
        FROM Bills b
        JOIN Patients p ON b.PatientID = p.PatientID
        ORDER BY b.BillDate DESC, b.BillID DESC
        LIMIT 8
        """
    )

    department_load = fetch_all(
        """
        SELECT dp.DepartmentName, COUNT(d.DoctorID) AS total_doctors
        FROM Departments dp
        LEFT JOIN Doctors d ON dp.DepartmentID = d.DepartmentID
        GROUP BY dp.DepartmentID, dp.DepartmentName
        ORDER BY dp.DepartmentName
        """
    )

    return render_template(
        "dashboard.html",
        stats=stats,
        recent_appointments=recent_appointments,
        recent_bills=recent_bills,
        department_load=department_load,
    )


@app.route("/departments")
def departments():
    rows = fetch_all("SELECT * FROM Departments ORDER BY DepartmentName")
    return render_template("departments.html", departments=rows)


@app.route("/doctors")
def doctors():
    rows = fetch_all(
        """
        SELECT d.*, dp.DepartmentName
        FROM Doctors d
        LEFT JOIN Departments dp ON d.DepartmentID = dp.DepartmentID
        ORDER BY d.DoctorID DESC
        """
    )
    departments = fetch_all("SELECT DepartmentID, DepartmentName FROM Departments ORDER BY DepartmentName")
    return render_template("doctors.html", doctors=rows, departments=departments)


@app.route("/doctors/add", methods=["POST"])
def add_doctor():
    form = request.form
    execute_query(
        """
        INSERT INTO Doctors (FullName, Gender, Specialization, Phone, Email, DepartmentID, ConsultationFee, AvailabilityStatus)
        VALUES (%s,%s,%s,%s,%s,%s,%s,%s)
        """,
        (
            form.get("FullName"),
            form.get("Gender"),
            form.get("Specialization"),
            form.get("Phone"),
            form.get("Email"),
            form.get("DepartmentID"),
            form.get("ConsultationFee"),
            form.get("AvailabilityStatus"),
        ),
    )
    flash("Doctor added successfully.", "success")
    return redirect(url_for("doctors"))


@app.route("/patients")
def patients():
    rows = fetch_all("SELECT * FROM Patients ORDER BY PatientID DESC")
    return render_template("patients.html", patients=rows)


@app.route("/patients/add", methods=["POST"])
def add_patient():
    form = request.form
    execute_query(
        """
        INSERT INTO Patients (
            FullName, Gender, DateOfBirth, BloodGroup, Phone, Email, Address,
            EmergencyContactName, EmergencyContactPhone
        ) VALUES (%s,%s,%s,%s,%s,%s,%s,%s,%s)
        """,
        (
            form.get("FullName"),
            form.get("Gender"),
            form.get("DateOfBirth"),
            form.get("BloodGroup"),
            form.get("Phone"),
            form.get("Email"),
            form.get("Address"),
            form.get("EmergencyContactName"),
            form.get("EmergencyContactPhone"),
        ),
    )
    flash("Patient registered successfully.", "success")
    return redirect(url_for("patients"))


@app.route("/appointments")
def appointments():
    rows = fetch_all(
        """
        SELECT a.*, p.FullName AS patient_name, d.FullName AS doctor_name
        FROM Appointments a
        JOIN Patients p ON a.PatientID = p.PatientID
        JOIN Doctors d ON a.DoctorID = d.DoctorID
        ORDER BY a.AppointmentDate DESC, a.AppointmentTime DESC
        """
    )
    patients_list = fetch_all("SELECT PatientID, FullName FROM Patients ORDER BY FullName")
    doctors_list = fetch_all("SELECT DoctorID, FullName, Specialization FROM Doctors ORDER BY FullName")
    return render_template(
        "appointments.html",
        appointments=rows,
        patients=patients_list,
        doctors=doctors_list,
    )


@app.route("/appointments/add", methods=["POST"])
def add_appointment():
    form = request.form
    execute_query(
        """
        INSERT INTO Appointments (PatientID, DoctorID, AppointmentDate, AppointmentTime, Reason, Status)
        VALUES (%s,%s,%s,%s,%s,%s)
        """,
        (
            form.get("PatientID"),
            form.get("DoctorID"),
            form.get("AppointmentDate"),
            form.get("AppointmentTime"),
            form.get("Reason"),
            form.get("Status"),
        ),
    )
    flash("Appointment created successfully.", "success")
    return redirect(url_for("appointments"))


@app.route("/admissions")
def admissions():
    rows = fetch_all(
        """
        SELECT a.*, p.FullName AS patient_name, d.FullName AS doctor_name, r.RoomNumber
        FROM Admissions a
        JOIN Patients p ON a.PatientID = p.PatientID
        JOIN Doctors d ON a.DoctorID = d.DoctorID
        JOIN Rooms r ON a.RoomID = r.RoomID
        ORDER BY a.AdmissionID DESC
        """
    )
    patients_list = fetch_all("SELECT PatientID, FullName FROM Patients ORDER BY FullName")
    doctors_list = fetch_all("SELECT DoctorID, FullName FROM Doctors ORDER BY FullName")
    rooms = fetch_all("SELECT RoomID, RoomNumber, AvailabilityStatus FROM Rooms ORDER BY RoomNumber")
    return render_template("admissions.html", admissions=rows, patients=patients_list, doctors=doctors_list, rooms=rooms)


@app.route("/admissions/add", methods=["POST"])
def add_admission():
    form = request.form
    execute_query(
        """
        INSERT INTO Admissions (PatientID, DoctorID, RoomID, AdmissionDate, DischargeDate, AdmissionReason, Status)
        VALUES (%s,%s,%s,%s,%s,%s,%s)
        """,
        (
            form.get("PatientID"),
            form.get("DoctorID"),
            form.get("RoomID"),
            form.get("AdmissionDate"),
            form.get("DischargeDate") or None,
            form.get("AdmissionReason"),
            form.get("Status"),
        ),
    )

    if form.get("Status") == "Admitted":
        execute_query("UPDATE Rooms SET AvailabilityStatus='Occupied' WHERE RoomID=%s", (form.get("RoomID"),))

    flash("Admission saved successfully.", "success")
    return redirect(url_for("admissions"))


@app.route("/labs")
def labs():
    reports = fetch_all(
        """
        SELECT lr.*, p.FullName AS patient_name, d.FullName AS doctor_name, lt.TestName
        FROM Lab_Reports lr
        JOIN Patients p ON lr.PatientID = p.PatientID
        JOIN Doctors d ON lr.DoctorID = d.DoctorID
        JOIN Lab_Tests lt ON lr.TestID = lt.TestID
        ORDER BY lr.ReportID DESC
        """
    )
    tests = fetch_all("SELECT * FROM Lab_Tests ORDER BY TestName")
    patients_list = fetch_all("SELECT PatientID, FullName FROM Patients ORDER BY FullName")
    doctors_list = fetch_all("SELECT DoctorID, FullName FROM Doctors ORDER BY FullName")
    return render_template("labs.html", reports=reports, tests=tests, patients=patients_list, doctors=doctors_list)


@app.route("/labs/add-report", methods=["POST"])
def add_lab_report():
    form = request.form
    execute_query(
        """
        INSERT INTO Lab_Reports (PatientID, DoctorID, TestID, TestDate, ResultDetails, Status)
        VALUES (%s,%s,%s,%s,%s,%s)
        """,
        (
            form.get("PatientID"),
            form.get("DoctorID"),
            form.get("TestID"),
            form.get("TestDate"),
            form.get("ResultDetails"),
            form.get("Status"),
        ),
    )
    flash("Lab report created successfully.", "success")
    return redirect(url_for("labs"))


@app.route("/pharmacy")
def pharmacy():
    medicines = fetch_all("SELECT * FROM Medicines ORDER BY MedicineID DESC")
    return render_template("pharmacy.html", medicines=medicines)


@app.route("/pharmacy/add", methods=["POST"])
def add_medicine():
    form = request.form
    execute_query(
        """
        INSERT INTO Medicines (MedicineName, Category, UnitPrice, StockQuantity, ExpiryDate)
        VALUES (%s,%s,%s,%s,%s)
        """,
        (
            form.get("MedicineName"),
            form.get("Category"),
            form.get("UnitPrice"),
            form.get("StockQuantity"),
            form.get("ExpiryDate"),
        ),
    )
    flash("Medicine added successfully.", "success")
    return redirect(url_for("pharmacy"))


@app.route("/billing")
def billing():
    bills = fetch_all(
        """
        SELECT b.*, p.FullName AS patient_name
        FROM Bills b
        JOIN Patients p ON b.PatientID = p.PatientID
        ORDER BY b.BillID DESC
        """
    )
    payments = fetch_all(
        """
        SELECT py.*, b.PatientID, p.FullName AS patient_name
        FROM Payments py
        JOIN Bills b ON py.BillID = b.BillID
        JOIN Patients p ON b.PatientID = p.PatientID
        ORDER BY py.PaymentID DESC
        """
    )
    patients_list = fetch_all("SELECT PatientID, FullName FROM Patients ORDER BY FullName")
    return render_template("billing.html", bills=bills, payments=payments, patients=patients_list)


@app.route("/billing/add-bill", methods=["POST"])
def add_bill():
    form = request.form
    execute_query(
        """
        INSERT INTO Bills (PatientID, AppointmentID, AdmissionID, BillDate, TotalAmount, BillStatus)
        VALUES (%s,%s,%s,%s,%s,%s)
        """,
        (
            form.get("PatientID"),
            form.get("AppointmentID") or None,
            form.get("AdmissionID") or None,
            form.get("BillDate"),
            form.get("TotalAmount"),
            form.get("BillStatus"),
        ),
    )
    flash("Bill created successfully.", "success")
    return redirect(url_for("billing"))


@app.route("/billing/add-payment", methods=["POST"])
def add_payment():
    form = request.form
    execute_query(
        """
        INSERT INTO Payments (BillID, AmountPaid, PaymentDate, PaymentMethod)
        VALUES (%s,%s,%s,%s)
        """,
        (
            form.get("BillID"),
            form.get("AmountPaid"),
            form.get("PaymentDate"),
            form.get("PaymentMethod"),
        ),
    )
    flash("Payment recorded successfully.", "success")
    return redirect(url_for("billing"))


@app.route("/reports")
def reports():
    summary = {
        "paid_bills": fetch_one("SELECT COUNT(*) AS total FROM Bills WHERE BillStatus='Paid'")["total"],
        "unpaid_bills": fetch_one("SELECT COUNT(*) AS total FROM Bills WHERE BillStatus='Unpaid'")["total"],
        "pending_labs": fetch_one("SELECT COUNT(*) AS total FROM Lab_Reports WHERE Status='Pending'")["total"],
        "available_doctors": fetch_one("SELECT COUNT(*) AS total FROM Doctors WHERE AvailabilityStatus='Available'")["total"],
    }
    doctor_revenue = fetch_all(
        """
        SELECT d.FullName, COUNT(a.AppointmentID) AS total_appointments,
               COALESCE(SUM(d.ConsultationFee), 0) AS estimated_consultation_value
        FROM Doctors d
        LEFT JOIN Appointments a ON d.DoctorID = a.DoctorID
        GROUP BY d.DoctorID, d.FullName
        ORDER BY estimated_consultation_value DESC
        """
    )
    return render_template("reports.html", summary=summary, doctor_revenue=doctor_revenue)


@app.errorhandler(Error)
def handle_mysql_error(error):
    return render_template("error.html", message=str(error)), 500


if __name__ == "__main__":
    app.run(debug=True)
