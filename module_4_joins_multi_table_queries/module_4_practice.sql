-- =====================================================
-- MODULE 4: JOINS AND MULTI-TABLE QUERIES
-- =====================================================

-- Goal:
-- In this module, I will learn how to combine data from multiple tables using joins.
-- I will practice INNER JOIN, LEFT JOIN, RIGHT JOIN, multiple joins, joins with aggregation,
-- and interview-style join problems.

-- Main concepts:
-- 1. INNER JOIN
-- 2. LEFT JOIN
-- 3. RIGHT JOIN
-- 4. Joining more than two tables
-- 5. ON vs WHERE
-- 6. Join + GROUP BY
-- 7. Finding unmatched records
-- 8. Avoiding duplicate rows from wrong join logic

-- =====================================================
-- EASY PRACTICE
-- =====================================================

-- Q1. Show each employee's first name, last name, and department name.



-- Q2. Show each employee's first name, last name, job title, and department name.



-- Q3. Show each department name with its location id.



-- Q4. Show each employee's full name and the department id they belong to.



-- Q5. Show each employee's full name and department name using INNER JOIN.



-- Q6. Show employee id, employee full name, department id, and department name.



-- Q7. Show all employees who belong to a department.



-- Q8. Show all employees with their department names, sorted by department name.



-- Q9. Show all employees with their department names, sorted by employee last name.



-- Q10. Show department name and manager id from the departments table.



-- =====================================================
-- MEDIUM PRACTICE
-- =====================================================

-- Q11. Show all employees and their department names, including employees who may not have a department.



-- Q12. Show all departments and employees in those departments, including departments that may not have employees.



-- Q13. Find employees who do not belong to any department.



-- Q14. Find departments that have no employees.



-- Q15. Count how many employees are in each department. Show department name and employee count.



-- Q16. Find departments that have more than 5 employees. Show department name and employee count.



-- Q17. Find the average salary of employees in each department. Show department name and average salary.



-- Q18. Find departments where average salary is greater than 60000. Show department name and average salary.



-- Q19. Find the highest salary in each department. Show department name and highest salary.



-- Q20. Find total salary paid in each department. Show department name and total salary.



-- =====================================================
-- JOIN + FILTERING PRACTICE
-- =====================================================

-- Q21. Show employees and department names only for employees whose salary is greater than 50000.



-- Q22. Show departments and employees only for department id 10.



-- Q23. Show employees whose department name is 'Sales'.



-- Q24. Show employees whose department name is 'IT'.



-- Q25. Show employees whose salary is greater than the average salary of their own department.



-- =====================================================
-- MULTI-TABLE JOIN PRACTICE
-- =====================================================

-- Q26. Show employee full name, department name, and location id.



-- Q27. Show employee full name, department name, and city.



-- Q28. Show department name, city, and country id.



-- Q29. Show employee full name, department name, city, and country id.



-- Q30. Show all departments with their city information, including departments even if no employee works there.



-- =====================================================
-- HARD / INTERVIEW PRACTICE
-- =====================================================

-- Q31. Find departments with no employees.



-- Q32. Find employees without departments.



-- Q33. Find the department or departments with the highest employee count.



-- Q34. Find the department or departments with the highest average salary.



-- Q35. Find employees who earn more than their department average salary.



-- Q36. Find departments where total salary is greater than the average total salary across departments.



-- Q37. Find department names where the number of employees is greater than the average employee count across departments.



-- Q38. Find employees who work in the same department as employee id 100.



-- Q39. Find employees who have the same job title as another employee.



-- Q40. Find departments where the maximum salary is greater than the company average salary.



-- =====================================================
-- PERSONAL NOTES
-- =====================================================

-- INNER JOIN returns only matching rows from both tables.

-- LEFT JOIN returns all rows from the left table and matching rows from the right table.
-- If no match exists, right table columns become NULL.

-- RIGHT JOIN returns all rows from the right table and matching rows from the left table.
-- In practice, LEFT JOIN is usually preferred.

-- ON is used to define how tables are connected.

-- WHERE is used to filter rows after the join result is created.

-- For unmatched records, use LEFT JOIN with IS NULL.

-- Example pattern:
-- SELECT columns
-- FROM table1
-- LEFT JOIN table2
-- ON table1.key = table2.key
-- WHERE table2.key IS NULL;

-- When using JOIN with GROUP BY:
-- 1. Join the tables first.
-- 2. Group by the meaningful column.
-- 3. Apply aggregate functions.
-- 4. Use HAVING if filtering grouped results.

-- End of Module 4