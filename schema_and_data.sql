-- Drop the database if it exists
DROP DATABASE IF EXISTS employeedb;

-- Create the database
CREATE DATABASE employeedb;

-- Switch to the created database
USE employeedb;


CREATE TABLE departments (
    dep_id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    department_name VARCHAR(100) NOT NULL,
    manager_id INT,  -- Manager will be added as a foreign key later
    location VARCHAR(100)
);

CREATE TABLE employees (
    emp_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    date_of_birth DATE NOT NULL,
    gender VARCHAR(10),
    joining_date DATE NOT NULL,
    department_id INT,  -- Links to departments table
    salary DECIMAL(10 , 2 ) NOT NULL,
    job_title VARCHAR(100),
    location VARCHAR(100),
    CONSTRAINT fk_department_id FOREIGN KEY (department_id)
        REFERENCES departments (dep_id)
);

-- Once both departments and employees tables are created, add the foreign key for manager_id:
ALTER TABLE departments 
ADD CONSTRAINT fk_manager_id FOREIGN KEY (manager_id)
REFERENCES employees (emp_id);

CREATE TABLE salaries (
    salary_id INT PRIMARY KEY AUTO_INCREMENT,
    employee_id INT,  -- Links to employees table
    salary DECIMAL(10 , 2 ) NOT NULL,
    effective_date DATE NOT NULL,
    CONSTRAINT fk_employee_id FOREIGN KEY (employee_id)
        REFERENCES employees (emp_id)
);


CREATE TABLE employee_performance (
    performance_id INT PRIMARY KEY AUTO_INCREMENT,
    employee_id INT NOT NULL,  -- Links to employees table
    performance_score INT,
    review_date DATE NOT NULL,
    manager_id INT NOT NULL,  -- Links to employees table
    CONSTRAINT score_between_1_and_5 CHECK (performance_score BETWEEN 1 AND 5),
    CONSTRAINT fk_emp_performance_manager_id FOREIGN KEY (manager_id)
        REFERENCES employees (emp_id),
    CONSTRAINT fk_emp_performance_employee_id FOREIGN KEY (employee_id)
        REFERENCES employees (emp_id)
);



CREATE TABLE employee_leave (
    leave_id INT PRIMARY KEY AUTO_INCREMENT,
    employee_id INT NOT NULL,  -- Links to employees table
    leave_type VARCHAR(50) NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    CONSTRAINT fk_emp_leave_employee_id FOREIGN KEY (employee_id)
        REFERENCES employees (emp_id)
);


INSERT INTO Departments (dep_id, department_name, manager_id, location)
VALUES 
(1, 'Human Resources', NULL, 'New York'),
(2, 'Engineering', NULL, 'San Francisco'),
(3, 'Sales', NULL, 'Chicago'),
(4, 'Marketing', NULL, 'Boston'),
(5, 'Finance', NULL, 'Los Angeles');

INSERT INTO Employees (emp_id, first_name, last_name, date_of_birth, gender, joining_date, department_id, salary, job_title, location)
VALUES 
(1, 'Alice', 'Smith', '1985-02-14', 'Female', '2010-06-15', 2, 95000.00, 'Senior Engineer', 'San Francisco'),
(2, 'Bob', 'Johnson', '1990-08-22', 'Male', '2015-09-01', 2, 85000.00, 'Software Engineer', 'San Francisco'),
(3, 'Charlie', 'Brown', '1980-12-12', 'Male', '2005-01-20', 3, 75000.00, 'Sales Manager', 'Chicago'),
(4, 'Diana', 'Williams', '1992-03-28', 'Female', '2018-07-19', 1, 65000.00, 'HR Specialist', 'New York'),
(5, 'Evan', 'Taylor', '1987-11-10', 'Male', '2012-10-05', 4, 72000.00, 'Marketing Analyst', 'Boston'),
(6, 'Grace', 'Lee', '1995-06-05', 'Female', '2021-01-12', 5, 78000.00, 'Financial Analyst', 'Los Angeles'),
(7, 'John', 'Doe', '1989-03-22', 'Male', '2017-05-23', 4, 70000.00, 'Marketing Manager', 'Boston');


-- Setting the manager_id for each department
UPDATE Departments
SET manager_id = 1
WHERE dep_id = 2;  -- Engineering department manager is Alice Smith

UPDATE Departments
SET manager_id = 3
WHERE dep_id = 3;  -- Sales department manager is Charlie Brown

UPDATE Departments
SET manager_id = 4
WHERE dep_id = 1;  -- HR department manager is Diana Williams

UPDATE Departments
SET manager_id = 5
WHERE dep_id = 4;  -- Marketing department manager is Evan Taylor



INSERT INTO Salaries (salary_id, employee_id, salary, effective_date)
VALUES 
(1, 1, 95000.00, '2020-01-01'),
(2, 1, 90000.00, '2018-01-01'),
(3, 2, 85000.00, '2021-06-01'),
(4, 3, 75000.00, '2019-09-01'),
(5, 4, 65000.00, '2022-03-01'),
(6, 5, 72000.00, '2020-10-01'),
(7, 6, 78000.00, '2021-01-12');


INSERT INTO Employee_Performance (performance_id, employee_id, performance_score, review_date, manager_id)
VALUES 
(1, 1, 5, '2023-06-01', 1),
(2, 2, 4, '2023-06-01', 1),
(3, 3, 3, '2022-12-15', 3),
(4, 4, 4, '2023-03-20', 4),
(5, 5, 5, '2023-05-10', 5),
(6, 6, 4, '2023-04-15', 5),
(7, 7, 3, '2023-07-01', 4);


INSERT INTO Employee_Leave (leave_id, employee_id, leave_type, start_date, end_date)
VALUES 
(1, 1, 'Vacation', '2023-08-01', '2023-08-15'),
(2, 2, 'Sick Leave', '2023-09-10', '2023-09-12'),
(3, 3, 'Vacation', '2023-07-05', '2023-07-15'),
(4, 4, 'Maternity Leave', '2023-01-10', '2023-03-10'),
(5, 5, 'Sick Leave', '2023-06-20', '2023-06-22'),
(6, 6, 'Vacation', '2023-05-01', '2023-05-10'),
(7, 7, 'Personal Leave', '2023-09-01', '2023-09-05');






