# Bharath Employee Payroll Management System

Frontend + backend using HTML/CSS/JavaScript, Node.js, Express, and MySQL (same structure as the Lab Equipment CRUD project).

Manage employees, define each employee's salary (basic, allowance, deduction, net), generate monthly payroll, and track payment status.

## Database tables
- `employee`: `employee_id` (INT, PK), `name`, `email`, `phone`, `department`, `designation`, `join_date`
- `salary`: `salary_id` (INT, PK), `employee_id` (INT, FK), `basic_salary` DECIMAL(10,2), `allowance` DECIMAL(10,2), `deduction` DECIMAL(10,2), `net_salary` DECIMAL(10,2)
- `payroll`: `payroll_id` (INT, PK), `employee_id` (INT, FK), `salary_id` (INT, FK), `month` INT, `year` INT, `payment_date` DATE, `payment_status` VARCHAR(30)

`net_salary = basic_salary + allowance - deduction` (calculated automatically by the server).

## Setup

1. Install Node.js (LTS) and MySQL Server (or use MySQL through XAMPP).
2. Open MySQL Workbench/phpMyAdmin or another MySQL client.
3. Run the contents of `database.sql` to create the `employee_payroll` database and its tables.
4. Open this project folder in VS Code.
5. Copy `.env.example` to a new file named `.env`.
6. Edit `.env` and set `DB_USER` and `DB_PASSWORD` to your own MySQL credentials. Keep `.env` private.
7. Open a terminal in this folder and run:

   ```bash
   npm install
   npm start
   ```

8. Open **http://localhost:3000** in your browser. Use this URL, not `file://` or Live Server, so the frontend and API share the same origin.

## Pages
| Page | Purpose |
|---|---|
| `index.html` | Home |
| `list.html` | All employees |
| `listOne.html` | Search employee by ID |
| `insert.html` | Add employee |
| `update.html` | Update employee |
| `delete.html` | Delete employee |
| `salary.html` | Add / edit / delete salary records |
| `payroll.html` | Generate payroll, mark Paid / On Hold |
| `reports.html` | Monthly summary, department summary, payroll not generated |

## Workflow
1. Add employees (`insert.html`).
2. Add a salary record for each employee (`salary.html`). Net salary is calculated automatically.
3. Generate payroll for a month (`payroll.html`) by giving the employee ID, salary ID, month and year. It starts as `Pending`.
4. Click **Pay** to mark it `Paid` (payment date is set to today) or **Hold** to set it `On Hold`.
5. View totals in `reports.html`.

## API
**Employees (CRUD)**
- `POST /employees`, `GET /employees`, `GET /employees/:employee_id`, `PUT /employees/:employee_id`, `DELETE /employees/:employee_id`

**Salary**
- `GET /salaries`, `POST /salaries`, `PUT /salaries/:salary_id`, `DELETE /salaries/:salary_id`

**Payroll**
- `GET /payroll` (optional `?status=Pending&month=10&year=2026`)
- `POST /payroll` — generate payroll
- `PUT /payroll/:payroll_id/pay`, `PUT /payroll/:payroll_id/hold`
- `DELETE /payroll/:payroll_id` (unpaid records only)

**Reports**
- `GET /reports/monthly-summary`, `GET /reports/department-summary`, `GET /reports/not-generated?month=10&year=2026`
- `GET /health` — server health check

## Notes
- Sample data is included in `database.sql` (4 employees, 4 salary records, 4 payroll records). Remove the sample INSERTs if you want empty tables.
- One payroll record is allowed per employee per month.
- Employees with salary/payroll records cannot be deleted (foreign key protection).
- Do not commit or share your real `.env` file.

## Push to GitHub
```bash
git init
git add .
git commit -m "Bharath Employee Payroll Management System"
git branch -M main
git remote add origin https://github.com/<your-username>/employee-payroll-fullstack.git
git push -u origin main
```
