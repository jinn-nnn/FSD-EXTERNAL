CREATE DATABASE IF NOT EXISTS employee_payroll;
USE employee_payroll;

-- Table 1: employee
CREATE TABLE IF NOT EXISTS employee (
    employee_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone VARCHAR(15),
    department VARCHAR(50) NOT NULL,
    designation VARCHAR(50) NOT NULL,
    join_date DATE NOT NULL
);

-- Table 2: salary
CREATE TABLE IF NOT EXISTS salary (
    salary_id INT AUTO_INCREMENT PRIMARY KEY,
    employee_id INT NOT NULL,
    basic_salary DECIMAL(10,2) NOT NULL,
    allowance DECIMAL(10,2) NOT NULL DEFAULT 0,
    deduction DECIMAL(10,2) NOT NULL DEFAULT 0,
    net_salary DECIMAL(10,2) NOT NULL,
    CHECK (basic_salary >= 0),
    CHECK (allowance >= 0),
    CHECK (deduction >= 0),
    FOREIGN KEY (employee_id) REFERENCES employee(employee_id)
);

-- Table 3: payroll
CREATE TABLE IF NOT EXISTS payroll (
    payroll_id INT AUTO_INCREMENT PRIMARY KEY,
    employee_id INT NOT NULL,
    salary_id INT NOT NULL,
    month INT NOT NULL,
    year INT NOT NULL,
    payment_date DATE NULL,
    payment_status VARCHAR(30) NOT NULL DEFAULT 'Pending',
    CHECK (month BETWEEN 1 AND 12),
    CHECK (year >= 2000),
    CHECK (payment_status IN ('Pending', 'Paid', 'On Hold')),
    UNIQUE (employee_id, month, year),
    FOREIGN KEY (employee_id) REFERENCES employee(employee_id),
    FOREIGN KEY (salary_id) REFERENCES salary(salary_id)
);

-- Optional sample data for testing
INSERT INTO employee (employee_id, name, email, phone, department, designation, join_date)
VALUES
(101, 'Ravi Kumar', 'ravi.kumar@company.com', '9876543210', 'IT', 'Software Engineer', '2022-06-15'),
(102, 'Anitha Reddy', 'anitha.reddy@company.com', '9123456780', 'HR', 'HR Executive', '2021-03-01'),
(103, 'Suresh Babu', 'suresh.babu@company.com', '9988776655', 'Finance', 'Accountant', '2020-08-10'),
(104, 'Priya Sharma', 'priya.sharma@company.com', '9090909090', 'IT', 'Team Lead', '2019-01-20')
ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO salary (salary_id, employee_id, basic_salary, allowance, deduction, net_salary)
VALUES
(1, 101, 45000.00, 8000.00, 3500.00, 49500.00),
(2, 102, 35000.00, 6000.00, 2500.00, 38500.00),
(3, 103, 40000.00, 7000.00, 3000.00, 44000.00),
(4, 104, 65000.00, 12000.00, 6000.00, 71000.00)
ON DUPLICATE KEY UPDATE basic_salary = VALUES(basic_salary);

INSERT INTO payroll (payroll_id, employee_id, salary_id, month, year, payment_date, payment_status)
VALUES
(1, 101, 1, 10, 2026, '2026-10-31', 'Paid'),
(2, 102, 2, 10, 2026, '2026-10-31', 'Paid'),
(3, 103, 3, 10, 2026, NULL, 'Pending'),
(4, 104, 4, 10, 2026, NULL, 'On Hold')
ON DUPLICATE KEY UPDATE payment_status = VALUES(payment_status);
