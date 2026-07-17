# Hospital Management System

<div align="center">
  <img src="https://img.shields.io/badge/License-MIT-green.svg" alt="License" />
  <img src="https://img.shields.io/badge/Python-3.10%2B-3776AB?logo=python&logoColor=white" alt="Python" />
  <img src="https://img.shields.io/badge/Flask-3.x-000000?logo=flask&logoColor=white" alt="Flask" />
  <img src="https://img.shields.io/badge/MySQL-8.x-4479A1?logo=mysql&logoColor=white" alt="MySQL" />
  <img src="https://img.shields.io/badge/HTML5-E34F26?logo=html5&logoColor=white" alt="HTML5" />
  <img src="https://img.shields.io/badge/CSS3-1572B6?logo=css3&logoColor=white" alt="CSS3" />
  <img src="https://img.shields.io/badge/JavaScript-F7DF1E?logo=javascript&logoColor=black" alt="JavaScript" />
  <br />
  <img src="https://img.shields.io/github/stars/fahimsadik21-pixel/Hospital-Management-System?style=social" alt="GitHub stars" />
  <img src="https://img.shields.io/github/last-commit/fahimsadik21-pixel/Hospital-Management-System" alt="Last commit" />
  <img src="https://img.shields.io/github/repo-size/fahimsadik21-pixel/Hospital-Management-System" alt="Repository size" />
</div>

<p align="center">
  <strong>A modern, database-driven hospital administration platform designed to streamline operations across departments, doctors, patients, appointments, admissions, lab services, pharmacy, billing, and reporting.</strong>
</p>

<div align="center">
  <h3>🏥 From patient intake to billing and reporting, everything is connected in one place.</h3>
</div>

---

## Project Overview

Hospital Management System is a full-stack academic and portfolio-grade web application built with Flask and MySQL. It brings together the core workflows of a hospital into a centralized, responsive web experience that is practical for real-world administration and suitable for showcasing software engineering and database design skills.

### Why this project matters

- It replaces fragmented manual processes with a single digital workflow.
- It demonstrates relational database design and CRUD-based application development.
- It serves as a strong portfolio project for academic, technical, and recruiter review.

### Objectives

- Simplify departmental and operational management.
- Provide a clear interface for staff and administrators.
- Showcase a polished open-source project that is easy to run and extend.

### Real-world applications

This system is well suited for small and mid-sized clinics or hospitals that need a lightweight digital platform for managing patient flow, appointments, labs, pharmacy operations, and billing.

---

## Features

- Dashboard with summary metrics and recent activity
- Department management
- Doctor and specialist management
- Patient registration and record handling
- Appointment scheduling and tracking
- Admission and room assignment workflows
- Laboratory test and report management
- Pharmacy inventory and medicine tracking
- Billing and payment management
- Reporting and administrative summaries
- Responsive interface for desktop and tablet usage
- CRUD operations for core hospital entities
- Data validation and consistent form handling
- Authentication is planned for future releases

---

## Screenshots

<p align="center">
  <img src="screenshots/dashboard.png" width="90%" alt="Dashboard overview" />
</p>

<p align="center">
  <img src="screenshots/departments.png" width="48%" alt="Departments module" />
  <img src="screenshots/doctors.png" width="48%" alt="Doctors module" />
</p>

<p align="center">
  <img src="screenshots/patients.png" width="48%" alt="Patients module" />
  <img src="screenshots/appointments.png" width="48%" alt="Appointments module" />
</p>

<p align="center">
  <img src="screenshots/admissions.png" width="48%" alt="Admissions module" />
  <img src="screenshots/billing.png" width="48%" alt="Billing module" />
</p>

<p align="center">
  <img src="screenshots/laboratory.png" width="48%" alt="Laboratory module" />
  <img src="screenshots/pharmacy.png" width="48%" alt="Pharmacy module" />
</p>

<p align="center">
  <img src="screenshots/reports.png" width="90%" alt="Reports module" />
</p>

---

## Tech Stack

| Technology | Purpose |
| --- | --- |
| Python | Backend application logic |
| Flask | Web framework for routes and templates |
| MySQL | Relational database for hospital records |
| HTML5 | Page structure and layouts |
| CSS3 | Visual styling and responsive UI |
| JavaScript | Client-side interactions |
| Jinja2 | Dynamic template rendering |

---

## Project Structure

```text
Hospital-Management-System/
├── app.py                  # Flask application entry point
├── config.json             # Project metadata and configuration reference
├── schema.sql              # MySQL schema and seeded sample data
├── requirements.txt        # Python dependencies
├── static/                 # CSS and JavaScript assets
│   ├── css/
│   └── js/
├── templates/              # Jinja2 HTML templates
│   ├── base.html
│   ├── dashboard.html
│   ├── departments.html
│   ├── doctors.html
│   ├── patients.html
│   ├── appointments.html
│   ├── admissions.html
│   ├── labs.html
│   ├── pharmacy.html
│   ├── billing.html
│   ├── reports.html
│   └── error.html
├── screenshots/            # Application screenshots for documentation
└── README.md               # Project documentation
```

---

## Database

The application uses a MySQL database named HospitalManagementSystem and is defined in [schema.sql](schema.sql).

### Core tables

- Departments
- Doctors
- Patients
- Nurses
- Receptionists
- Appointments
- Diagnoses
- Prescriptions
- Medicines
- Wards
- Rooms
- Admissions
- Lab_Tests
- Lab_Reports
- Bills
- Payments
- Doctor_Attendance
- Nurse_Attendance

### Relationships

- Departments have many Doctors and Nurses.
- Patients can have many Appointments, Admissions, Lab Reports, and Bills.
- Doctors can be linked to Appointments, Diagnoses, Prescriptions, Admissions, and Lab Reports.
- Appointments can generate Prescriptions, Bills, and Diagnoses.
- Admissions are associated with Rooms and Patients.

### Keys

- Primary keys are defined on each table’s main identifier column.
- Foreign keys connect related entities such as PatientID, DoctorID, RoomID, AppointmentID, and AdmissionID.

---

## Installation

### 1. Clone the repository

```bash
git clone https://github.com/fahimsadik21-pixel/Hospital-Management-System.git
cd Hospital-Management-System
```

### 2. Create and activate a virtual environment

```bash
python -m venv .venv
```

Windows PowerShell:

```powershell
.\.venv\Scripts\Activate.ps1
```

macOS / Linux:

```bash
source .venv/bin/activate
```

### 3. Install dependencies

```bash
pip install -r requirements.txt
```

### 4. Set up MySQL

Create a MySQL database named HospitalManagementSystem and import the schema:

```bash
mysql -u root -p < schema.sql
```

If your credentials differ, update the connection values in [app.py](app.py) before launching the app.

### 5. Run the application

```bash
python app.py
```

Open the app at:

```text
http://127.0.0.1:5000
```

<details>
<summary>🛠️ Quick start summary</summary>

```bash
git clone https://github.com/fahimsadik21-pixel/Hospital-Management-System.git
cd Hospital-Management-System
python -m venv .venv
source .venv/bin/activate  # or .\.venv\Scripts\Activate.ps1 on Windows
pip install -r requirements.txt
mysql -u root -p < schema.sql
python app.py
```

</details>

---

## Usage

1. Open the dashboard to review key hospital statistics.
2. Use the sidebar navigation to move between departments, doctors, patients, appointments, admissions, labs, pharmacy, billing, and reports.
3. Add or manage records through the built-in forms and tables.
4. Review billing and reporting summaries after entering operational data.

---

## Key Modules

| Module | Description |
| --- | --- |
| Dashboard | High-level operational view with key stats |
| Departments | Manage hospital departments and their details |
| Doctors | Maintain doctor profiles, specialties, and availability |
| Patients | Register and track patient information |
| Appointments | Book and review appointments |
| Admissions | Handle room-based patient admissions |
| Laboratory | Manage test requests and reports |
| Pharmacy | Track medicines and inventory |
| Billing | Record bills and payments |
| Reports | View summary information for operations |

---

## Roadmap

Planned enhancements for future releases:

- Role-based authentication and user sessions
- Email and SMS notifications
- Inventory and stock lifecycle management
- Online payment gateway integration
- REST API support for external integrations
- Analytics dashboard with charts and forecasts
- Cloud deployment and containerization improvements

---

## Contributing

Contributions are welcome and appreciated.

1. Fork the repository.
2. Create a feature branch.
3. Make your changes and ensure they are documented.
4. Submit a pull request with a clear summary.

Please review [CONTRIBUTING.md](CONTRIBUTING.md) for project guidelines before contributing.

---

## License

This project is licensed under the MIT License. See [LICENSE](LICENSE) for details.

---

## Author

Built by Fahim Sadik.

- GitHub: [fahimsadik21-pixel](https://github.com/fahimsadik21-pixel)
- Project: Hospital Management System

---

## Acknowledgements

- Flask community for the web framework
- MySQL for reliable relational data storage
- Open-source contributors and the broader developer community
- Academic and portfolio project reviewers who value practical software design
