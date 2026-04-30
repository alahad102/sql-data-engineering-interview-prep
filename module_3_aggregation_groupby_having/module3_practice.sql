-- =====================================================
-- MODULE 3: AGGREGATION, GROUP BY, HAVING
-- =====================================================

-- Goal:
-- In this module, I will learn how to summarize data using SQL.
-- Instead of only filtering rows, I will learn how to answer questions like:
-- how many, total, average, minimum, maximum, per group, and groups with conditions.

-- Main concepts:
-- 1. COUNT()
-- 2. SUM()
-- 3. AVG()
-- 4. MIN()
-- 5. MAX()
-- 6. GROUP BY
-- 7. HAVING
-- 8. WHERE vs HAVING
-- 9. COUNT(DISTINCT column)
-- 10. Aggregation with subqueries

-- Important idea:
-- WHERE filters rows before grouping.
-- HAVING filters groups after grouping.

-- Logical execution order:
-- FROM
-- WHERE
-- GROUP BY
-- HAVING
-- SELECT
-- ORDER BY
-- LIMIT

-- =====================================================
-- EASY PRACTICE
-- =====================================================

-- Q1. Count total rows from the Employee table.


SELECT count(*)
FROM employees;


-- Q2. Count how many employees have a salary value.

SELECT count(salary)
FROM employees
WHERE salary is NOT NULL;


-- Q3. Find the highest salary.


SELECT max(salary) as highest_salary
FROM employees;

-- Q4. Find the lowest salary.


SELECT min(salary) as lowest_salary
FROM employees;

-- Q5. Find the average salary.


SELECT avg(salary) as average_salary
FROM employees;



-- Q6. Find the total salary paid to all employees.


SELECT sum(salary) as total_salary
FROM employees;



-- Q7. Count how many unique departments exist.


SELECT count(DISTINCT department_name)
FROM departments;


-- Q8. Count employees in each department.

SELECT count(employee_id) as employees_per_department
FROM employees
GROUP BY department_id;


-- Q9. Find average salary in each department.

SELECT avg(salary) as average_salary_by_department
FROM employees
GROUP BY department_id;


-- Q10. Find maximum salary in each department.


SELECT max(salary) as max_salary_by_department
FROM employees
GROUP BY department_id;



-- =====================================================
-- MEDIUM PRACTICE
-- =====================================================

-- Q11. Find departments that have more than 5 employees.

SELECT 
    department_id, count(employee_id) as total_employee
FROM 
    employees
GROUP BY 
    department_id
HAVING 
    total_employee > 5;


-- Q12. Find departments where average salary is greater than 60000.

SELECT 
    department_id, avg(salary) as average_salary
FROM
    employees
GROUP BY 
    department_id
HAVING
    average_salary > 60000;


-- Q13. Find departments sorted by employee count from highest to lowest.

SELECT department_id, count(employee_id) as total_count
FROM employees
GROUP BY department_id
ORDER BY total_count DESC;


-- Q14. Find the top 3 departments with the highest average salary.

SELECT department_id, AVG(salary) as average_salary
FROM
    employees
GROUP BY department_id
ORDER BY average_salary DESC
LIMIT 3;


-- Q15. Find departments where the difference between max salary and min salary is greater than 30000.

SELECT
    department_id, (max(salary) - min(salary)) as difference_salary
FROM
    employees
GROUP BY
    department_id
HAVING difference_salary > 30000;


-- Q16. Count unique job titles in each department.




-- Q17. Find departments with at least 2 unique job titles.




-- =====================================================
-- WHERE VS HAVING PRACTICE
-- =====================================================

-- Q18. Find departments with more than 3 employees,
-- but only count employees whose salary is greater than 50000.




-- Q19. Find job titles with total salary greater than 150000,
-- but only include employees from department 10.




-- =====================================================
-- HARD / INTERVIEW PRACTICE
-- =====================================================

-- Q20. Find employees whose salary is greater than the average salary of all employees.




-- Q21. Find departments whose average salary is greater than the overall average salary.




-- Q22. Find job titles whose average salary is greater than the company average salary.




-- Q23. Find duplicate department IDs.
-- Meaning: departments that appear more than once in Employee.
1



-- Q24. Find the department or departments with the maximum employee count.




-- Q25. Find the department or departments with the highest average salary.




-- =====================================================
-- PERSONAL NOTES
-- =====================================================

-- COUNT(*) counts all rows.
-- COUNT(column_name) ignores NULL values.
-- COUNT(DISTINCT column_name) counts unique non-null values.

-- In SELECT with GROUP BY:
-- every selected column must either be inside an aggregate function
-- or be included in GROUP BY.

-- I should think in this order:
-- 1. What table?
-- 2. Do I need WHERE?
-- 3. What is the group?
-- 4. What aggregate function?
-- 5. Do I need HAVING?
-- 6. Do I need ORDER BY or LIMIT?

-- End of Module 3