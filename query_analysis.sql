# Employee Demographics & Department Overview:


-- 1. Total Number of Employees in Each Department
SELECT 
    department_name,
    COUNT(emp_id) AS 'Total Employee Cnt per Department'
FROM
    employees
        INNER JOIN
    departments ON employees.department_id = departments.dep_id
GROUP BY department_name;

-- 2. Department with the Most Employees
SELECT 
    d.department_name, COUNT(e.emp_id) AS Employees_cnt
FROM
    departments d
        INNER JOIN
    employees e ON d.dep_id = e.department_id
GROUP BY department_name
ORDER BY Employees_cnt DESC
LIMIT 1;
    
-- 3. Employees Who Have Worked for More Than 5 Years
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
    
-- 4. Department with the Highest Average Performance Score
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
    

# Salary & Compensation:
-- 5. Average Salary by Department
SELECT 
    department_name, ROUND(AVG(salary), 2) AS 'Avg Salary'
FROM
    departments
        INNER JOIN
    employees ON employees.department_id = departments.dep_id
GROUP BY department_name
ORDER BY department_name;

-- 6. Highest and Lowest Salary in Each Department
SELECT 
    department_name,
    MAX(salary) AS 'Highest Salary',
    MIN(salary) AS 'Lowest Salary'
FROM
    employees
        INNER JOIN
    departments ON employees.department_id = departments.dep_id
GROUP BY department_name;

-- 7. Employees with Salary Greater than the Department Average
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
            
-- 8. Total Salary Expenditure by Department
SELECT 
    d.department_name, SUM(e.salary) AS Total_salary
FROM
    departments d
        INNER JOIN
    employees e ON d.dep_id = e.department_id
GROUP BY d.department_name
ORDER BY Total_salary DESC;


# Employee Performance & Engagement:

-- 9. Employees with a Performance Score of 5
SELECT 
    e.emp_id, e.first_name, e.last_name, ep.Performance_Score
FROM
    employees e
        JOIN
    employee_Performance ep ON e.emp_id = ep.employee_ID
WHERE
    ep.Performance_Score = 5;
    
-- 10. Average Performance Score by Department
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
    
-- 11. Employees with the Most Leaves Taken
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

-- 12. Employees with No Leaves Taken
SELECT 
    e.emp_id, e.first_name, e.last_name
FROM
    employees e
        LEFT JOIN
    employee_leave el ON e.emp_id = el.employee_id
WHERE
    el.employee_id IS NULL;


# Employee Management:
-- 13. List of Employees with Their Manager's Name
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




    
