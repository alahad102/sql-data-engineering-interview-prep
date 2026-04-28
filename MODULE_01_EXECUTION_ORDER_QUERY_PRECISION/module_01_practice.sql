/*
MODULE 01: EXECUTION ORDER AND QUERY PRECISION

Goal:
Write clean, precise SQL queries using SELECT, FROM, WHERE, ORDER BY, LIMIT, DISTINCT, and aliases.

Logical execution order:
1. FROM
2. WHERE
3. SELECT
4. ORDER BY
5. LIMIT

Mistake focus:
- Avoid SELECT * unless inspecting table
- Use single quotes for string values
- Use clean aliases
- Format queries clearly
*/

-- Part 1

-- Q1. Show all columns from customers.

SELECT * FROM customers;



-- Q2. Show only customer_id, first_name, last_name, city, state from customers.

SELECT customer_id, first_name, last_name, city, state
FROM
customers;



-- Q3. Show only product_id, product_name, unit_price from products.

SELECT product_id, product_name, unit_price
FROM products;



-- Q4. Show only order_id, customer_id, order_date, order_status from orders.

SELECT order_id, customer_id, order_date, order_status
FROM orders;


-- Q5. Show only employee_id, first_name, last_name, job_title, salary from employees.

SELECT employee_id, first_name, last_name, job_title,salary
FROM employees;

-- Q6. Show all active customers.

SELECT * FROM customers
WHERE customer_status = 'Active';

-- Q7. Show all customers from TX.

SELECT * FROM customers
WHERE state = 'Texas';


-- Q8. Show all orders with order_status = 'Delivered'. 

SELECT * FROM orders
WHERE order_status = 'Completed';

-- Q9. Show all products with unit_price greater than 100.

SELECT * FROM products
WHERE unit_price > 100;

-- Q10. Show all employees with salary greater than 70000.

SELECT * FROM employees
WHERE salary > 70000;


-- Q11. Show the 5 most recent orders.

SELECT * FROM orders
ORDER BY order_date DESC
LIMIT 5;

-- Q12. Show the 5 most expensive products.

SELECT * FROM products
ORDER BY unit_price DESC
LIMIT 5;

-- Q13. Show the 10 highest paid employees.

SELECT * FROM employees
ORDER BY salary DESC
LIMIT 10;
-- Q14. Show customer_id and full customer name as full_name.

SELECT 
    customer_id, 
    CONCAT(first_name,' ',last_name) as full_name
FROM customers;

-- Q15. Show order_id and total_amount as order_value.

SELECT order_id, SUM(net_amount) as total_amount
FROM fact_sales
GROUP BY order_id;




-- =====================================================
-- PART 2: DISTINCT, ORDER BY, LIMIT, AND EXECUTION ORDER
-- =====================================================

-- Q16. Show all unique customer states.
SELECT DISTINCT state
FROM customers;


-- Q17. Show all unique order statuses.

SELECT DISTINCT order_status
FROM orders;

-- Q18. Show all unique sales channels from orders.

SELECT DISTINCT channel
FROM orders;

-- Q19. Show all unique product categories using category_id from products.

SELECT DISTINCT category_id
FROM products;


-- Q20. Show all unique employee job titles.

SELECT DISTINCT job_title
FROM employees;


-- Q21. Show the 3 newest customers based on created_at.

SELECT CONCAT(first_name," ",last_name) as customer_name, signup_date
FROM customers
ORDER BY signup_date DESC
LIMIT 3;


-- Q22. Show the 3 oldest customers based on created_at.

SELECT CONCAT(first_name," ",last_name) as customer_name, signup_date
FROM customers
ORDER BY signup_date 
LIMIT 3;

-- Q23. Show the 5 cheapest products.

SELECT product_name, unit_price
FROM products
ORDER BY unit_price
LIMIT 5;



-- Q24. Show the 5 most recent payments.

SELECT payment_date
FROM payments
ORDER BY payment_date DESC
LIMIT 5;

-- Q25. Show the 5 most recent support tickets.

SELECT ticket_id, created_date
FROM support_tickets
ORDER BY created_date DESC
LIMIT 5;



-- Q26. Show the 5 most recent completed orders.
-- Write execution thinking before the query.

SELECT * FROM orders
WHERE order_status = "Completed"
ORDER BY order_date DESC
limit 5;



-- Q27. Show the 5 highest salary employees whose salary is greater than 70000.
-- Write execution thinking before the query.

SELECT 
    employee_id,
    first_name,
    last_name,
    job_title,
    salary
FROM employees
WHERE salary > 70000
ORDER BY salary DESC
LIMIT 5;



-- Q28. Show the 10 most expensive products where unit_price is greater than 50.
-- Write execution thinking before the query.

SELECT product_name, unit_price
FROM products
WHERE unit_price > 50
ORDER BY unit_price DESC
LIMIT 10;


-- =====================================================
-- PART 3: DEBUGGING WRONG QUERIES
-- =====================================================

-- Q29. Fix this query.
-- Wrong query:
-- SELECT customer_id, first_name, last_name
-- WHERE state = 'Texas'
-- FROM customers;


SELECT customer_id, first_name, last_name
FROM customers
WHERE state = 'Texas';




-- Q30. Fix this query.
-- Wrong query:
-- SELECT product_name, unit_price
-- FROM products
-- ORDER BY unit_price DESC
-- WHERE unit_price > 100;

SELECT product_name, unit_price
FROM products
WHERE unit_price > 100
ORDER BY unit_price DESC;


-- Q31. Fix this query.
-- Wrong query:
-- SELECT order_id, customer_id, order_date
-- FROM orders
-- LIMIT 5
-- ORDER BY order_date DESC;

SELECT order_id, customer_id, order_date
FROM orders
ORDER BY order_date DESC
LIMIT 5;



-- Q32. Fix this query.
-- Wrong query:
-- SELECT DISTINCT customer_id, order_status
-- FROM orders;
-- Goal: show only unique order statuses.

SELECT DISTINCT order_status
FROM orders;


-- Q33. Fix this query.
-- Wrong query:
-- SELECT first_name + ' ' + last_name AS full_name
-- FROM customers;
-- Goal: show full customer name in MySQL.


SELECT CONCAT(first_name,' ',last_name) AS full_name
FROM customers;




-- Q34. Fix this query.
-- Wrong query:
-- SELECT product_name unit_price
-- FROM products;
-- Goal: show product_name and unit_price.

SELECT product_name, unit_price
FROM products;



-- Q35. Fix this query.
-- Wrong query:
-- SELECT order_id, customer_id, order_status
-- FROM orders
-- WHERE order_status = Completed;
-- Goal: show completed orders.

SELECT order_id, customer_id, order_status
FROM orders
WHERE order_status = 'Completed';



-- Q36. Fix this query.
-- Wrong query:
-- SELECT employee_id, first_name, salary
-- FROM employees
-- WHERE salary > 70000
-- LIMIT 5
-- ORDER BY salary DESC;

SELECT employee_id, first_name, salary
FROM employees
WHERE salary > 70000
ORDER BY salary DESC
LIMIT 5;



-- Q37. Fix this query.
-- Wrong query:
-- SELECT customer_id, first_name, last_name
-- FROM customers
-- WHERE state = 'Texas'
-- ORDER BY signup_date DESC
-- LIMIT;
-- Goal: show 5 newest Texas customers.

SELECT customer_id, first_name, last_name
FROM customers
WHERE state = 'Texas'
ORDER BY signup_date DESC
LIMIT 5;



-- Q38. Fix this query.
-- Wrong query:
-- SELECT customer_id, CONCAT(first_name, last_name) AS full_name
-- FROM customers;
-- Goal: full_name should have a space between first and last name.


SELECT customer_id, CONCAT(first_name,' ',last_name) AS full_name
FROM customers;