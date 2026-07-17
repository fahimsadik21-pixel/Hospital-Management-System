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

## Screenshots

> Add actual screenshots to `screenshots/` and update the image paths below.

- Dashboard
  ![Dashboard](screenshots/dashboard.png)
- Departments
  ![Departments](screenshots/departments.png)
- Doctors
  ![Doctors](screenshots/doctors.png)
- Patients
  ![Patients](screenshots/patients.png)
- Appointments
  ![Appointments](screenshots/appointments.png)
- Admissions
  ![Admissions](screenshots/admissions.png)
- Laboratory
  ![Laboratory](screenshots/laboratory.png)
- Pharmacy
  ![Pharmacy](screenshots/pharmacy.png)
- Billing
  ![Billing](screenshots/billing.png)
- Reports
  ![Reports](screenshots/reports.png)

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
