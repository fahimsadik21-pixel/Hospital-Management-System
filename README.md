# Hospital Management System

A production-ready hospital portfolio project built with Python, Flask, MySQL, and server-side Jinja2 templates.

## Project Overview

Hospital Management System is a database-focused web application designed to manage core workflows in a hospital setting. It demonstrates a full-stack Flask application with modules for patient registration, doctor management, appointments, admissions, laboratory reports, pharmacy inventory, billing, and operational reporting.

## Features

- Dashboard analytics with recent activity and operational KPIs
- Department management overview
- Doctor management and specialization tracking
- Patient registration and profile record storage
- Appointment scheduling and status tracking
- Patient admissions and room allocation
- Laboratory report entry and test management
- Pharmacy medicine inventory tracking
- Billing ledger and payment recording
- Summary reports for operational insights

## Technology Stack

- Python 3
- Flask
- MySQL
- HTML
- CSS
- JavaScript
- Jinja2 templates

## Project Architecture

- Frontend: `templates/` contains Jinja2 HTML templates and `static/` contains CSS and JavaScript assets.
- Backend: `app.py` serves Flask routes, database helpers, and page rendering logic.
- Database: `schema.sql` defines the MySQL schema and seeded hospital data.
- Request flow: browser request → Flask route → MySQL query → template render → browser response.

## Project Structure

```text
Hospital-Management-System/
├── app.py                  # Flask application entry point
├── config.json             # Application metadata and database reference values
├── schema.sql              # MySQL database schema and seed data
├── requirements.txt        # Python package dependencies
├── README.md               # Project overview and setup guide
├── LICENSE                 # MIT open source license
├── CHANGELOG.md            # Release history and notes
├── CONTRIBUTING.md         # Contribution guidelines
├── CODE_OF_CONDUCT.md      # Community expectations
├── SECURITY.md             # Security reporting policy
├── static/                 # Static frontend assets
│   ├── css/
│   │   └── styles.css
│   └── js/
│       └── app.js
└── templates/              # Flask HTML templates
    ├── base.html
    ├── dashboard.html
    ├── departments.html
    ├── doctors.html
    ├── patients.html
    ├── appointments.html
    ├── admissions.html
    ├── labs.html
    ├── pharmacy.html
    ├── billing.html
    ├── reports.html
    └── error.html
```

## Installation Guide

1. Clone the repository:
   ```bash
   git clone https://github.com/<your-username>/Hospital-Management-System.git
   cd Hospital-Management-System
   ```
2. Create a Python virtual environment:
   ```bash
   python -m venv .venv
   ```
3. Activate the environment:
   - Windows PowerShell:
     ```powershell
     .\.venv\Scripts\Activate.ps1
     ```
   - macOS / Linux:
     ```bash
     source .venv/bin/activate
     ```
4. Install dependencies:
   ```bash
   pip install -r requirements.txt
   ```
5. Configure MySQL and import the schema:
   - Open MySQL Workbench or the MySQL CLI.
   - Run `schema.sql` to create the database and seed sample data.
6. Update your database credentials in `app.py` if needed.
7. Start the application:
   ```bash
   python app.py
   ```
8. Open the app in your browser:
   ```text
   http://127.0.0.1:5000
   ```

## Database Setup

- `schema.sql` creates the `HospitalManagementSystem` database and defines the core hospital tables.
- The schema includes Departments, Doctors, Patients, Appointments, Admissions, Lab_Tests, Lab_Reports, Medicines, Bills, and Payments.
- The file also seeds sample departments, doctors, patients, appointments, and medical records for demonstration.
- Database credentials are currently defined in `app.py` under `DB_CONFIG`.

## Usage Guide

- Access the dashboard at the application root to view key metrics and recent activity.
- Use the sidebar navigation to open each module.
- Add new doctors, patients, appointments, admissions, lab reports, medicines, bills, and payments using the built-in forms.
- Each module renders database records in a responsive table layout.
- Flash messages provide immediate feedback after create actions.

---

# 📸 Application Screenshots

The following screenshots showcase the key modules of the **Hospital Management System**.

---

## 📊 Dashboard

A centralized dashboard providing quick access to all hospital management modules.

<p align="center">
  <img src="screenshots/dashboard.png" alt="Dashboard" width="100%">
</p>

---

## 🏢 Department Management

Manage hospital departments including department information and contact details.

<p align="center">
  <img src="screenshots/departments.png" alt="Departments" width="100%">
</p>

---

## 👨‍⚕️ Doctor Management

Register, update, and manage doctor profiles, specializations, consultation fees, and availability.

<p align="center">
  <img src="screenshots/doctors.png" alt="Doctors" width="100%">
</p>

---

## 🧑 Patient Management

Register patients and maintain complete patient records with emergency contact information.

<p align="center">
  <img src="screenshots/patients.png" alt="Patients" width="100%">
</p>

---

## 📅 Appointment Scheduling

Schedule appointments between patients and doctors while maintaining appointment history.

<p align="center">
  <img src="screenshots/appointments.png" alt="Appointments" width="100%">
</p>

---

## 🛏️ Admission & Room Management

Manage patient admissions, room allocation, admission status, and discharge records.

<p align="center">
  <img src="screenshots/admissions.png" alt="Admissions" width="100%">
</p>

---

## 🧪 Laboratory Management

Create laboratory reports, manage medical tests, and monitor report status.

<p align="center">
  <img src="screenshots/laboratory.png" alt="Laboratory" width="100%">
</p>

---

## 💊 Pharmacy Management

Maintain medicine inventory including stock quantity, expiry dates, and pricing.

<p align="center">
  <img src="screenshots/pharmacy.png" alt="Pharmacy" width="100%">
</p>

---

## 💳 Billing & Payment Management

Generate bills, record payments, and monitor payment status.

<p align="center">
  <img src="screenshots/billing.png" alt="Billing" width="100%">
</p>

---

## 📈 Analytics & Reports

Generate analytical reports and monitor hospital activities using summarized statistics.

<p align="center">
  <img src="screenshots/reports.png" alt="Reports" width="100%">
</p>

---

## Future Improvements

- Add authentication and role-based access control.
- Enable record editing, deletion, and search filters.
- Implement REST API endpoints for integration and mobile support.
- Add responsive and mobile-first UI enhancements.
- Add Docker Compose support for an integrated Flask + MySQL deployment.
- Improve form validation and server-side input sanitization.

## License

This project is released under the MIT License. See `LICENSE` for details.

## Author

Professional portfolio project prepared for recruiter review, university presentation, and database showcase.

- GitHub: `@your-github-username`
- Contact: `contact@example.com`

## Acknowledgements

- Flask community for a lightweight Python web framework.
- MySQL for the relational database platform.
- Open-source frontend design patterns and responsive UI conventions.

## Contribution

See `CONTRIBUTING.md` for contribution guidelines.

## Support

If you find an issue or want to suggest improvements, please open an issue in the repository.
