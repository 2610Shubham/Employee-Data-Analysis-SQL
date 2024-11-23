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


### **3. `salaries` Table**

This table stores historical salary data for employees, allowing for tracking of salary changes over time.

| Column Name      | Data Type     | Description                                             |
|------------------|---------------|---------------------------------------------------------|
| `salary_id`      | INT           | Primary Key: Unique identifier for each salary record. |
| `employee_id`    | INT           | Foreign Key: References the `emp_id` from the `employees` table. |
| `salary`         | DECIMAL(10,2) | Salary value of the employee.                           |
| `effective_date` | DATE          | Date the salary became effective.                       |

### **4. `employee_performance` Table**

This table records performance reviews for employees, including performance scores and review dates.

| Column Name         | Data Type    | Description                                                |
|---------------------|--------------|------------------------------------------------------------|
| `performance_id`    | INT          | Primary Key: Unique identifier for each performance record. |
| `employee_id`       | INT          | Foreign Key: References the `emp_id` from the `employees` table. |
| `performance_score` | INT          | The employee's performance score (between 1 and 5).         |
| `review_date`       | DATE         | Date of the performance review.                            |
| `manager_id`        | INT          | Foreign Key: References the `emp_id` from the `employees` table, identifying the reviewer. |

### **5. `employee_leave` Table**

This table tracks employee leave records, including leave type, start and end dates.

| Column Name   | Data Type    | Description                                              |
|---------------|--------------|----------------------------------------------------------|
| `leave_id`    | INT          | Primary Key: Unique identifier for each leave record.    |
| `employee_id` | INT          | Foreign Key: References the `emp_id` from the `employees` table. |
| `leave_type`  | VARCHAR(50)  | Type of leave taken (e.g., vacation, sick leave, etc.).  |
| `start_date`  | DATE         | Start date of the leave.                                 |
| `end_date`    | DATE         | End date of the leave.                                   |

---

## **Relationships**

### **Employees ↔ Departments**
- **One-to-Many**: Each employee is assigned to one department, but a department can have multiple employees.
- **Relationship**: The `department_id` in the `employees` table is a foreign key referencing `dep_id` in the `departments` table.
- **Manager Relationship**: The `manager_id` in the `departments` table is a foreign key referencing the `emp_id` in the `employees` table, indicating the manager of the department.

---

### **Employees ↔ Salaries**
- **One-to-Many**: An employee can have multiple salary records over time, but each salary record belongs to one employee.
- **Relationship**: The `employee_id` in the `salaries` table is a foreign key referencing `emp_id` in the `employees` table.

---

### **Employees ↔ Employee Performance**
- **One-to-Many**: Each employee can have multiple performance reviews, but each review belongs to one employee.
- **Relationship**: The `employee_id` in the `employee_performance` table is a foreign key referencing `emp_id` in the `employees` table.
- **Manager Relationship**: The `manager_id` in the `employee_performance` table is a foreign key referencing the `emp_id` in the `employees` table, indicating the manager who conducted the performance review.

---

### **Employees ↔ Employee Leave**
- **One-to-Many**: An employee can have multiple leave records, but each leave record belongs to one employee.
- **Relationship**: The `employee_id` in the `employee_leave` table is a foreign key referencing `emp_id` in the `employees` table.

---


## **Queries & Analysis**

### **Employee Demographics & Department Overview**

- **1. Total Number of Employees in Each Department**: This query gives the count of employees in each department, which is useful for understanding the size of each department.
```sql
SELECT 
    department_name,
    COUNT(emp_id) AS 'Total Employee Cnt per Department'
FROM
    employees
        INNER JOIN
    departments ON employees.department_id = departments.dep_id
GROUP BY department_name;
```
  
- **2. Department with the Most Employees**: This query identifies the department with the highest number of employees.
```sql
SELECT 
    d.department_name, COUNT(e.emp_id) AS Employees_cnt
FROM
    departments d
        INNER JOIN
    employees e ON d.dep_id = e.department_id
GROUP BY department_name
ORDER BY Employees_cnt DESC
LIMIT 1;
```

- **3. Employees Who Have Worked for More Than 5 Years**: This query returns employees who have been with the company for more than five years.
```sql
SELECT 
    emp_id,
    first_name,
    last_name,
    joining_date,
    ROUND(DATEDIFF(CURDATE(), joining_date) / 365,
            0) AS Years_Of_Service
FROM
    employees
WHERE
    DATEDIFF(CURDATE(), JOINING_DATE) / 365 > 5
ORDER BY Years_Of_Service DESC;
```

- **4. Department with the Highest Average Performance Score**: This query identifies the department with the best overall performance scores.
```sql
SELECT 
    d.department_name,
    ROUND(AVG(ep.performance_score), 1) AS Avg_Performance
FROM
    departments d
        INNER JOIN
    employees e ON d.dep_id = e.department_id
        INNER JOIN
    employee_performance ep ON e.emp_id = ep.employee_id
GROUP BY d.department_name
ORDER BY Avg_Performance DESC
LIMIT 1;
```


### **Salary & Compensation**

- **5.Average Salary by Department**: This query calculates the average salary in each department.
```sql
SELECT 
    department_name, ROUND(AVG(salary), 2) AS 'Avg Salary'
FROM
    departments
        INNER JOIN
    employees ON employees.department_id = departments.dep_id
GROUP BY department_name
ORDER BY department_name;
```


- **6. Highest and Lowest Salary in Each Department**: This query provides the highest and lowest salaries in each department, helping identify salary disparities.
```sql
SELECT 
    department_name,
    MAX(salary) AS 'Highest Salary',
    MIN(salary) AS 'Lowest Salary'
FROM
    employees
        INNER JOIN
    departments ON employees.department_id = departments.dep_id
GROUP BY department_name;
```


- **7. Employees with Salary Greater than the Department Average**: This query finds employees earning more than the average salary in their department.
```sql
SELECT 
    e.emp_id,
    e.first_name,
    e.last_name,
    e.salary,
    d.department_name
FROM
    employees e
        INNER JOIN
    departments d ON e.department_id = d.dep_id
WHERE
    e.salary > (SELECT 
            AVG(salary)
        FROM
            employees
        WHERE
            e.department_id = d.dep_id
            );
```

- **8. Total Salary Expenditure by Department**: This query calculates the total salary expenditure for each department, useful for budget planning and analysis.
```sql
SELECT 
    d.department_name, SUM(e.salary) AS Total_salary
FROM
    departments d
        INNER JOIN
    employees e ON d.dep_id = e.department_id
GROUP BY d.department_name
ORDER BY Total_salary DESC;
```

### **Employee Performance & Engagement**

- **9. Employees with a Performance Score of 5**: This query lists employees who have received a top performance score.
```sql
SELECT 
    e.emp_id, e.first_name, e.last_name, ep.Performance_Score
FROM
    employees e
        JOIN
    employee_Performance ep ON e.emp_id = ep.employee_ID
WHERE
    ep.Performance_Score = 5;
```

- **10. Average Performance Score by Department**: This query calculates the average performance score for each department.
```sql
SELECT 
    d.department_name,
    ROUND(AVG(ep.performance_score), 1) AS avg_performance_score
FROM
    departments d
        INNER JOIN
    employees e ON d.dep_id = e.department_id
        INNER JOIN
    employee_performance ep ON e.emp_id = ep.employee_id
GROUP BY d.department_name
ORDER BY avg_performance_score DESC;
```

- **11. Employees with the Most Leaves Taken**: This query identifies the employee with the most leave days.
```sql
SELECT 
    e.emp_id,
    e.first_name,
    e.last_name,
    COUNT(el.leave_id) AS Total_Leaves
FROM
    employees e
        INNER JOIN
    employee_leave el ON e.emp_id = el.employee_id
GROUP BY e.emp_id , e.first_name , e.last_name
ORDER BY Total_Leaves DESC
LIMIT 1;
```

- **12. Employees with No Leaves Taken**: This query lists employees who have not taken any leaves.
```sql
SELECT 
    e.emp_id, e.first_name, e.last_name
FROM
    employees e
        LEFT JOIN
    employee_leave el ON e.emp_id = el.employee_id
WHERE
    el.employee_id IS NULL;
```

### **Employee Management**

- **13. List of Employees with Their Manager's Name**: This query provides a list of employees along with their manager's name, which is helpful for organizational structure analysis.
```sql
SELECT 
    e.emp_id,
    e.first_name AS employee_first_name,
    e.last_name AS employee_last_name,
    m.first_name AS manager_first_name,
    m.last_name AS manager_last_name
FROM
    departments d
        INNER JOIN
    employees e ON d.dep_id = e.department_id
        LEFT JOIN
    employees m ON d.manager_id = m.emp_id;
```
---

