USE data_engineer_practice;

-- ============================================================
-- SQL DIAGNOSTIC TEST
-- Goal: Check current SQL level before starting modules
-- Instruction: Write your answer below each question.
-- Do not worry if you cannot solve all. This is only diagnostic.
-- ============================================================


/*
Q1. Show all columns from the customers table.
*/

-- My Answer:

SELECT * FROM customers;



/*
Q2. Find all active customers. Show customer_id, first_name, last_name, city, and state.
*/

-- My Answer:

SELECT 
    customer_id, first_name, last_name, city, state 
FROM 
    customers
WHERE
    customer_status = 'Active';



/*
Q3. Find customers whose email is missing.
*/

-- My Answer:

SELECT * FROM customers
WHERE email IS NULL;


/*
Q4. Find all orders placed through the Online channel.
Show order_id, customer_id, order_date, and order_status.
*/

-- My Answer:

SELECT order_id, customer_id, order_date, order_status 
FROM orders
WHERE channel = "Online";




/*
Q5. Count the total number of customers.
*/

-- My Answer:

SELECT count(customer_id)
FROM customers;



/*
Q6. Count how many customers are from each state.
Show state and total_customers.
*/

-- My Answer:

SELECT state, count(customer_id)
FROM customers
GROUP BY state;



/*
Q7. Find states that have more than 1 customer.
Show state and total_customers.
*/

-- My Answer:

SELECT state, count(customer_id) as total_customers
FROM customers
GROUP BY state
HAVING total_customers > 1;

/*
Q8. Find the total net sales amount from fact_sales.
Net amount is already available in the net_amount column.
*/

-- My Answer:

SELECT sum(net_amount)
FROM fact_sales;

/*
Q9. Find total net sales by customer_id.
Show customer_id and total_sales.
Sort by total_sales descending.
*/

-- My Answer:

SELECT customer_id, sum(net_amount)
FROM fact_sales
GROUP BY customer_id;



/*
Q10. Find customer names with their order IDs.
Show customer_id, full customer name, order_id, and order_date.
Use customers and orders tables.
*/

-- My Answer:

SELECT c.customer_id, CONCAT(c.first_name, ' ', c.last_name) as 'full customer name', o.order_id, o.order_date
FROM customers as c
JOIN
orders as o
ON
c.customer_id = o.customer_id;



/*
Q11. Find customers who never placed an order.
Show customer_id, first_name, last_name.
*/

-- My Answer:

SELECT c.customer_id, c.first_name, c.last_name, o.order_id
FROM customers as c
LEFT JOIN
orders as o
on c.customer_id = o.customer_id
WHERE o.order_id IS NULL;



/*
Q12. Find product names with their category names.
Show product_id, product_name, category_name.
*/

-- My Answer:

SELECT 
    p.product_id,
    p.product_name,
    c.category_name
FROM
    products as p
JOIN
    categories as c
ON
    p.category_id = c.category_id;

/*
Q13. Find total quantity sold for each product.
Show product_id, product_name, total_quantity_sold.
Sort by total_quantity_sold descending.
*/

-- My Answer:

SELECT 
    p.product_id,
    p.product_name, 
    count(f.quantity) as total_quantity_sold
FROM 
    products as p
JOIN
    fact_sales as f
ON 
    p.product_id = f.product_id

GROUP BY product_id, product_name
ORDER BY total_quantity_sold DESC;





/*
Q14. Find each employee with their department name.
Show employee_id, employee full name, department_name, salary.
*/

-- My Answer:
SELECT 
    e.employee_id, 
    CONCAT(e.first_name," ",e.last_name) as "employee full name", 
    d.department_name, e.salary
FROM
    employees as e
JOIN
    departments as d
ON
    e.department_id = d.department_id;




/*
Q15. Find employees earning more than the average salary of all employees.
Show employee_id, full name, and salary.
*/

-- My Answer:

SELECT 
    employee_id, CONCAT(first_name ,' ', last_name) as 'full name', salary
FROM
    employees
HAVING 
    salary > (SELECT AVG(salary) FROM employees);


/*
Q16. Find the highest paid employee in each department.
Show department_id, employee_id, full name, and salary.
You can solve using any method you know.
*/

-- My Answer:



/*
Q17. Find monthly total net sales.
Show month and total_sales.
Hint: use order_date from fact_sales.
*/

-- My Answer:



/*
Q18. Classify each order item in fact_sales as:
- 'High Value' if net_amount >= 500
- 'Medium Value' if net_amount >= 100 and less than 500
- 'Low Value' otherwise

Show order_id, product_id, net_amount, and value_category.
*/

-- My Answer:



/*
Q19. Find duplicate customer_id values in stg_customers.
Show customer_id and duplicate_count.
*/

-- My Answer:



/*
Q20. Find records from stg_orders where customer_id does not exist in the customers table.
Show stg_order_id, order_id, customer_id, order_date.
*/

-- My Answer:



-- ============================================================
-- Mistake Notes
-- After review, write your mistakes here.
-- ============================================================

/*
Mistake Notes:

1.

2.

3.
*/