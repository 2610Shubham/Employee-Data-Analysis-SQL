# **Employee Data Analysis Project**

## **Project Overview**
This project performs an in-depth analysis of employee data to derive insights related to department demographics, salary distributions, performance evaluations, leave management, and employee-manager relationships. The analysis leverages various SQL queries to generate reports based on employee performance, salary and more. This project aims to help HR departments and organizational management better understand employee performance, compensation, and overall organizational health.

## **Schema Description**

The database schema consists of several tables that store detailed information about employees, departments, performance scores, salaries, and leaves. Below are the key tables:

### **1. `departments` Table**

This table holds the department information, including the department's ID, name, manager, and location.

| Column Name      | Data Type     | Description                                             |
|------------------|---------------|---------------------------------------------------------|
| `dep_id`         | INT           | Primary Key: Unique identifier for each department.    |
| `department_name`| VARCHAR(100)  | Name of the department.                                |
| `manager_id`     | INT           | Foreign Key: References the `emp_id` from employees table, identifying the department manager. |
| `location`       | VARCHAR(100)  | Location of the department.                            |

### **2. `employees` Table**

This table contains employee details, including personal information, department affiliation, salary, and job title.

| Column Name      | Data Type     | Description                                             |
|------------------|---------------|---------------------------------------------------------|
| `emp_id`         | INT           | Primary Key: Unique identifier for each employee.      |
| `first_name`     | VARCHAR(100)  | Employee's first name.                                 |
| `last_name`      | VARCHAR(100)  | Employee's last name.                                  |
| `date_of_birth`  | DATE          | Employee's date of birth.                              |
| `gender`         | VARCHAR(10)   | Employee's gender.                                     |
| `joining_date`   | DATE          | Date the employee joined the organization.             |
| `department_id`  | INT           | Foreign Key: References the `dep_id` from the `departments` table. |
| `salary`         | DECIMAL(10,2) | Employee's salary.                                     |
| `job_title`      | VARCHAR(100)  | Employee's job title.                                  |
| `location`       | VARCHAR(100)  | Employee's location.                                   |

