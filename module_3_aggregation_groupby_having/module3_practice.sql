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
-- Concept: COUNT(*)



-- Q2. Count how many employees have a salary value.
-- Concept: COUNT(column_name)



-- Q3. Find the highest salary.
-- Concept: MAX()



-- Q4. Find the lowest salary.
-- Concept: MIN()



-- Q5. Find the average salary.
-- Concept: AVG()



-- Q6. Find the total salary paid to all employees.
-- Concept: SUM()



-- Q7. Count how many unique departments exist.
-- Concept: COUNT(DISTINCT column_name)



-- Q8. Count employees in each department.
-- Concept: GROUP BY



-- Q9. Find average salary in each department.
-- Concept: GROUP BY + AVG()



-- Q10. Find maximum salary in each department.
-- Concept: GROUP BY + MAX()



-- =====================================================
-- MEDIUM PRACTICE
-- =====================================================

-- Q11. Find departments that have more than 5 employees.
-- Concept: GROUP BY + HAVING



-- Q12. Find departments where average salary is greater than 60000.
-- Concept: GROUP BY + HAVING + AVG()



-- Q13. Find departments sorted by employee count from highest to lowest.
-- Concept: GROUP BY + ORDER BY



-- Q14. Find the top 3 departments with the highest average salary.
-- Concept: GROUP BY + AVG() + ORDER BY + LIMIT



-- Q15. Find departments where the difference between max salary and min salary is greater than 30000.
-- Concept: MAX() - MIN() + HAVING



-- Q16. Count unique job titles in each department.
-- Concept: COUNT(DISTINCT)



-- Q17. Find departments with at least 2 unique job titles.
-- Concept: COUNT(DISTINCT) + HAVING



-- =====================================================
-- WHERE VS HAVING PRACTICE
-- =====================================================

-- Q18. Find departments with more than 3 employees,
-- but only count employees whose salary is greater than 50000.
-- Concept: WHERE filters rows first, HAVING filters groups later.



-- Q19. Find job titles with total salary greater than 150000,
-- but only include employees from department 10.
-- Concept: WHERE + GROUP BY + HAVING



-- =====================================================
-- HARD / INTERVIEW PRACTICE
-- =====================================================

-- Q20. Find employees whose salary is greater than the average salary of all employees.
-- Concept: subquery with AVG()



-- Q21. Find departments whose average salary is greater than the overall average salary.
-- Concept: GROUP BY + HAVING + subquery



-- Q22. Find job titles whose average salary is greater than the company average salary.
-- Concept: GROUP BY + HAVING + subquery



-- Q23. Find duplicate department IDs.
-- Meaning: departments that appear more than once in Employee.
-- Concept: GROUP BY + HAVING COUNT(*) > 1



-- Q24. Find the department or departments with the maximum employee count.
-- Concept: grouped result compared with max grouped count



-- Q25. Find the department or departments with the highest average salary.
-- Concept: grouped result compared with max average salary



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