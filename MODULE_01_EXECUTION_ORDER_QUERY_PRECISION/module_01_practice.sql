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

-- Q7. Show all customers from TX.
-- Q8. Show all orders with order_status = 'Delivered'. 
-- Q9. Show all products with unit_price greater than 100.
-- Q10. Show all employees with salary greater than 70000.


-- Q11. Show the 5 most recent orders.

-- Q12. Show the 5 most expensive products.

-- Q13. Show the 10 highest paid employees.

-- Q14. Show customer_id and full customer name as full_name.

-- Q15. Show order_id and total_amount as order_value.