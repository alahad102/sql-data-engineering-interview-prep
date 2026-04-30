# Module 3: Aggregation, GROUP BY, and HAVING

## What I learned in this module

In Module 3, I learned how to summarize data using SQL aggregate functions and grouping.

Before this module, I was mainly practicing how to select rows, filter rows, sort results, and remove duplicates. In this module, I started learning how SQL answers summary-style business questions such as how many records exist, what the total value is, what the average value is, what the minimum or maximum value is, how many records exist in each group, which groups satisfy a condition, and which group has the highest or lowest aggregated result.

## Main SQL concepts learned

### 1. Aggregate functions

I learned the main aggregate functions:

COUNT()
SUM()
AVG()
MIN()
MAX()

These functions summarize multiple rows into a single value.

I also learned the difference between:

COUNT(*)
COUNT(column_name)
COUNT(DISTINCT column_name)

Important understanding:

COUNT(*) counts all rows.
COUNT(column_name) counts only non-null values.
COUNT(DISTINCT column_name) counts unique non-null values.

## 2. GROUP BY

I learned that GROUP BY is used when I want aggregate results for each group.

For example, instead of finding the average salary of the whole company, I can find the average salary for each department.

Example:

SELECT 
    department_id,
    AVG(salary) AS average_salary
FROM employees
GROUP BY department_id;

I learned that when using GROUP BY, every selected column should either be inside an aggregate function or be included in the GROUP BY.

A key mistake I corrected was forgetting to include the grouped column in the SELECT result. For example, if I group by department_id, I should also show department_id in the output so the result is meaningful.

## 3. HAVING

I learned that HAVING is used to filter grouped results after aggregation.

Example:

SELECT 
    department_id,
    COUNT(*) AS employee_count
FROM employees
GROUP BY department_id
HAVING COUNT(*) > 5;

This means group employees by department, count employees in each department, and show only departments with more than 5 employees.

## 4. WHERE vs HAVING

One of the most important lessons in this module was the difference between WHERE and HAVING.

WHERE filters individual rows before grouping.

HAVING filters groups after aggregation.

Important understanding:

WHERE filters rows.
HAVING filters groups.

A mistake I made and corrected was confusing salary > 150000 with SUM(salary) > 150000.

salary > 150000 checks each individual employee salary.

SUM(salary) > 150000 checks the total salary of a whole group.

## 5. Logical SQL execution order

I learned the logical order in which SQL processes a query:

FROM
WHERE
GROUP BY
HAVING
SELECT
ORDER BY
LIMIT

This helped me understand why aliases created in SELECT may not always be safe to use in earlier parts of the query, depending on the database.

For interview-safe SQL, it is often better to write:

HAVING COUNT(*) > 5

instead of depending only on:

HAVING employee_count > 5

Even though MySQL often allows aliases in HAVING, using the aggregate expression directly is more portable and professional.

## 6. Aggregation with subqueries

I also practiced harder problems where aggregation is combined with subqueries.

Examples of problems I practiced:

Find employees whose salary is greater than the company average salary.
Find departments whose average salary is greater than the overall average salary.
Find job titles whose average salary is greater than the company average salary.
Find departments with the maximum employee count.
Find departments with the highest average salary.

This helped me understand how to compare grouped results against another aggregated result.

Example pattern:

SELECT 
    department_id,
    AVG(salary) AS avg_salary
FROM employees
GROUP BY department_id
HAVING AVG(salary) = (
    SELECT MAX(avg_salary)
    FROM (
        SELECT 
            AVG(salary) AS avg_salary
        FROM employees
        GROUP BY department_id
    ) AS t1
);

## 7. Handling ties

I learned that using ORDER BY with LIMIT 1 can find the top result, but it may miss ties.

For example, if two departments have the same highest average salary, LIMIT 1 may return only one of them.

For interview-style questions that say “department or departments,” I should use a tie-safe solution with a subquery instead of only using LIMIT 1.

## Important mistakes I corrected

In this module, I corrected these important mistakes:

1. When using GROUP BY, I should show the grouped column in the SELECT output.
2. COUNT(column_name) already ignores NULL, so adding WHERE column_name IS NOT NULL is often unnecessary.
3. salary > 150000 is not the same as SUM(salary) > 150000.
4. WHERE filters rows before grouping.
5. HAVING filters groups after aggregation.
6. ORDER BY with LIMIT 1 is simple but not always tie-safe.
7. For interview-safe SQL, using aggregate expressions directly in HAVING is better than depending only on aliases.

## Final takeaway

Module 3 helped me move from simple row-level SQL to summary and group-level SQL.

I learned how to think in this order:

1. What table am I reading from?
2. Do I need to filter individual rows first using WHERE?
3. What column should I group by?
4. What aggregate function do I need?
5. Do I need to filter grouped results using HAVING?
6. Do I need to sort or limit the final result?

By the end of this module, I practiced and understood:

COUNT()
SUM()
AVG()
MIN()
MAX()
GROUP BY
HAVING
COUNT(DISTINCT)
WHERE vs HAVING
Aggregation with subqueries
Tie-safe grouped queries

This module is important for SQL interviews, LeetCode-style SQL problems, and real data engineering work because many real-world questions require grouped summaries and aggregate analysis.