-- =====================================================
-- MODULE 4: JOINS AND MULTI-TABLE QUERIES
-- DATABASE: data_engineer_practice
-- =====================================================

-- Goal:
-- Practice joins using the actual database tables.
-- Focus on real interview-style join problems without repeating the same type too much.

-- Tables used:
-- customers
-- orders
-- order_items
-- products
-- categories
-- suppliers
-- payments
-- shipments
-- inventory
-- departments
-- employees
-- fact_sales
-- dim_customer
-- dim_product
-- stg_orders
-- stg_customers

-- =====================================================
-- PART 1: BASIC INNER JOIN
-- =====================================================

-- Q1. Show each employee's first name, last name, and department name.

SELECT
    e.first_name, e.last_name,d.department_name
FROM
    employees AS e
JOIN
    departments AS d
ON
    e.department_id = d.department_id;


-- Q2. Show each employee's full name, job title, salary, and department name.

SELECT
    CONCAT(e.first_name,' ',e.last_name) as full_name, e.job_title, e.salary, d.department_name
FROM
    employees AS e
JOIN
    departments AS d
ON
    e.department_id = d.department_id;




-- Q3. Show each order id, order date, customer first name, customer last name, and order status.

SELECT
    o.order_id, o.order_date, c.first_name, c.last_name, o.order_status
FROM
    orders as o
JOIN
    customers as c
ON
    o.customer_id = c.customer_id;



-- Q4. Show each product name with its category name.

SELECT
    p.product_name, c.category_name
FROM
    products as p
JOIN
    categories as c
ON
    p.category_id = c.category_id;


-- Q5. Show each product name with its supplier name and supplier country.

SELECT
    p.product_name, s.supplier_name, s.country
FROM
    products as p
JOIN
    suppliers as s
ON
    p.supplier_id = s.supplier_id;


-- =====================================================
-- PART 2: BUSINESS JOIN QUESTIONS
-- =====================================================

-- Q6. Show each order id, customer full name, order date, and channel.

SELECT
    o.order_id, 
    concat(c.first_name,' ',c.last_name) as customer_full_name,
    o.order_date,
    o.channel
FROM
    orders as o
JOIN
    customers as c
ON
    o.customer_id = c.customer_id;


-- Q7. Show each order item with order id, product name, quantity, unit price, and discount amount.
SELECT
    o.order_id, p.product_name, o.quantity, o.unit_price, o.discount_amount
FROM
    order_items as o
JOIN
    products as p
ON 
    o.product_id = p.product_id;



-- Q8. Show each order id, product name, quantity, and line total before discount.

SELECT
    oi.order_id,
    p.product_name,
    oi.quantity,
    oi.quantity * oi.unit_price AS line_total_before_discount
FROM order_items AS oi
JOIN products AS p
    ON oi.product_id = p.product_id;

-- Q9. Show each order id, product name, quantity, and line total after discount.

SELECT
    oi.order_id,
    p.product_name,
    oi.quantity,
    ((oi.quantity * oi.unit_price) - oi.discount_amount) AS line_total_after_discount
FROM order_items AS oi
JOIN products AS p
    ON oi.product_id = p.product_id;



-- Q10. Show each payment with order id, customer full name, payment method, payment status, and amount.

SELECT
    o.order_id, CONCAT(c.first_name,' ',c.last_name) as full_name, p.payment_method, p.payment_status, p.amount
FROM
    orders as o
JOIN
    customers as c
ON 
    o.customer_id = c.customer_id
JOIN
    payments as p
ON
    p.order_id = o.order_id;



-- =====================================================
-- PART 3: LEFT JOIN AND MISSING DATA
-- =====================================================

-- Q11. Show all customers and their orders, including customers who never placed an order.

SELECT
    *
FROM
    customers as c
LEFT JOIN
    orders as o
ON
    c.customer_id = o.customer_id;



-- Q12. Find customers who never placed an order.

SELECT
    *
FROM 
    customers as c
LEFT JOIN
    orders as o
ON
    c.customer_id = o.customer_id
WHERE 
    order_id is NULL;

-- Q13. Show all orders and their shipment status, including orders that may not have shipment records.

SELECT  
    *
FROM
    orders as o
LEFT JOIN
    shipments as s
ON
    o.order_id = s.order_id;


-- Q14. Find orders that do not have a shipment record.

SELECT
    *
FROM 
    orders as o
LEFT JOIN
    shipments as s
ON
    o.order_id = s.order_id
WHERE
    s.shipment_id is NULL;

-- Q15. Show all products and their inventory stock quantity, including products that may not exist in inventory.

SELECT
    *
FROM
    products as p
LEFT JOIN
    inventory as i
ON
    p.product_id = i.product_id;

-- =====================================================
-- PART 4: JOIN WITH AGGREGATION
-- =====================================================

-- Q16. Count total orders placed by each customer.

SELECT
    concat(c.first_name,' ',c.last_name) as full_name,
    count(order_id) as total_orders_count
FROM
    customers as c
JOIN
    orders as o
ON 
    c.customer_id = o.customer_id
GROUP BY
    c.customer_id,
    full_name;



-- Q17. Find customers who placed more than 2 orders.

SELECT 
    concat(c.first_name,' ',c.last_name) as Full_name,
    count(o.order_id) as total_orders_count
FROM
    customers as c
JOIN
    orders as o
ON 
    c.customer_id = o.customer_id
GROUP BY 
    Full_name
HAVING 
    total_orders_count > 2;

--better version

SELECT 
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS full_name,
    COUNT(o.order_id) AS total_orders_count
FROM customers AS c
JOIN orders AS o
    ON c.customer_id = o.customer_id
GROUP BY 
    c.customer_id,
    full_name
HAVING 
    COUNT(o.order_id) > 2;

-- Q18. Find total sales amount per customer using orders and order_items.

SELECT
    customer_id, sum(quantity*unit_price) as total_amount
FROM
    orders as o
JOIN
    order_items as oi
ON
    o.order_id = oi.order_id
GROUP BY
    o.customer_id;

--better version

SELECT
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_full_name,
    SUM((oi.quantity * oi.unit_price) - oi.discount_amount) AS total_sales_amount
FROM customers AS c
JOIN orders AS o
    ON c.customer_id = o.customer_id
JOIN order_items AS oi
    ON o.order_id = oi.order_id
GROUP BY
    c.customer_id,
    customer_full_name;

-- Q19. Find total quantity sold for each product.

SELECT
    p.product_name, sum(fs.quantity) as total_quantity_sold
FROM 
    products as p
JOIN
    fact_sales as fs
ON
    p.product_id = fs.product_id
GROUP BY
    p.product_id,
    p.product_name;

-- Q20. Find total revenue per product category.


SELECT 
    c.category_name,
    SUM((oi.quantity * oi.unit_price) - oi.discount_amount) AS total_revenue
FROM 
    categories AS c
JOIN 
    products AS p
ON 
    c.category_id = p.category_id
JOIN 
    order_items AS oi
ON 
    p.product_id = oi.product_id
GROUP BY 
    c.category_id,
    c.category_name;

-- =====================================================
-- PART 5: MULTI-TABLE JOINS
-- =====================================================

-- Q21. Show order id, customer full name, product name, category name, quantity, and net line amount.

SELECT
    oi.order_id,
    concat(c.first_name,' ',c.last_name) as full_name,
    p.product_name,
    ct.category_name,
    oi.quantity,
    ((oi.quantity * oi.unit_price) - oi.discount_amount) as net_line_amount
FROM
    order_items as oi
JOIN
    products as p
ON
    oi.product_id = p.product_id
JOIN
    categories as ct
ON
    ct.category_id = p.category_id
JOIN
    orders as o
ON
    o.order_id = oi.order_id
JOIN
    customers as c
ON 
    c.customer_id = o.customer_id;



-- Q22. Show customer full name, product name, supplier name, and order date for every purchased product.

SELECT
    concat(c.first_name,' ',c.last_name) as Full_name,
    p.product_name,
    s.supplier_name,
    o.order_date
FROM
    customers as c
JOIN
    orders as o
ON
    c.customer_id = o.customer_id
JOIN
    order_items as oi
ON
    oi.order_id = o.order_id
JOIN
    products as p
ON
    p.product_id = oi.product_id
JOIN
    suppliers as s 
ON
    s.supplier_id = p.supplier_id;


-- Q23. Show category name and total revenue for each category.

SELECT
    ct.category_id, ct.category_name, sum((oi.quantity * oi.unit_price) - oi.discount_amount) as total_revenue
FROM 
    order_items as oi
JOIN
    products as p
ON
    oi.product_id = p.product_id
JOIN
    categories as ct
ON
    ct.category_id = p.category_id
GROUP BY
    category_id,
    category_name;



-- Q24. Show supplier name and total revenue generated from their products.


SELECT
    s.supplier_id, s.supplier_name, sum((oi.quantity * oi.unit_price) - oi.discount_amount) as total_revenue
FROM
    products as p
JOIN
    suppliers as s
ON
    p.supplier_id = s.supplier_id
JOIN
    order_items as oi
ON
    oi.product_id = p.product_id
GROUP BY
    supplier_id,
    supplier_name;


-- Q25. Show customer full name and total amount paid successfully.

SELECT
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS full_name,
    SUM(p.amount) AS total_amount_paid
FROM 
    customers AS c
JOIN 
    orders AS o
ON 
    c.customer_id = o.customer_id
JOIN 
    payments AS p
ON 
    o.order_id = p.order_id
WHERE 
    p.payment_status = 'Successful'
GROUP BY
    c.customer_id,
    full_name;



-- =====================================================
-- PART 6: JOIN + FILTERING
-- =====================================================

-- Q26. Show customers who placed orders through the Online channel.

SELECT DISTINCT
    c.customer_id, concat(c.first_name,' ',c.last_name) as Full_name, o.channel
FROM
    customers as c
JOIN
    orders as o
ON
    c.customer_id = o.customer_id
WHERE
    o.channel = 'Online';



-- Q27. Show products sold in completed orders only.


SELECT DISTINCT
    p.product_id, p.product_name, o.order_status
FROM 
    products as p
JOIN
    order_items as oi
ON
    p.product_id = oi.product_id
JOIN 
    orders as o
ON
    o.order_id = oi.order_id
WHERE 
    o.order_status = 'Completed';


-- Q28. Show customers who had failed or pending payments.

SELECT
    concat(c.first_name,' ',c.last_name) as Full_name, p.payment_status
FROM
    customers as c
JOIN
    orders as o 
ON
    c.customer_id = o.customer_id
JOIN
    payments as p
ON
    p.order_id = o.order_id
WHERE
    p.payment_status IN ('Failed','Pending');



-- Q29. Show orders that were delivered by FedEx.

SELECT
    o.order_id, s.carrier
FROM
    orders as o
JOIN
    shipments as s
ON
    o.order_id = s.order_id
WHERE
    s.carrier = 'FedEx'
    AND
    s.shipment_status = 'Delivered';



-- Q30. Show active products that have stock quantity less than 50.

SELECT
    p.product_name, i.stock_quantity, p.product_status
FROM
    products as p
JOIN
    inventory as i
ON
    p.product_id = i.product_id
WHERE
    i.stock_quantity < 50
    AND
    p.product_status = 'Active';




-- =====================================================
-- PART 7: EMPLOYEE SELF JOIN
-- =====================================================

-- Q31. Show each employee with their manager name.

SELECT e.employee_id, 
       CONCAT(e.first_name,' ',e.last_name) as employee_name, 
       m.manager_id,
       CONCAT(m.first_name,' ',m.last_name) as manager_name
FROM
    employees as e
JOIN
    employees as m
ON
    e.manager_id = m.employee_id;

SELECT
    e.employee_id,
    m.employee_id,
    e.first_name,
    m.first_name,
    e.manager_id,
    m.manager_id   
FROM
    employees as e
LEFT JOIN
    employees as m
ON
    e.employee_id = m.manager_id;


-- Q32. Show employees who do not have a manager.





-- Q33. Show each manager and the number of employees reporting to them.



-- Q34. Show employees whose salary is greater than their manager's salary.



-- =====================================================
-- PART 8: DATA ENGINEERING STYLE JOIN QUESTIONS
-- =====================================================

-- Q35. Compare orders table with fact_sales.
-- Show order ids that exist in orders but do not exist in fact_sales.



-- Q36. Show fact_sales records with customer full name from dim_customer.



-- Q37. Show fact_sales records with product name and category name from dim_product.



-- Q38. Find staging orders where customer_id does not exist in the customers table.



-- Q39. Find staging customers where customer_id already exists in the customers table.



-- Q40. Find staging customers where customer_id does not exist in the customers table.



-- =====================================================
-- PART 9: HARD INTERVIEW JOIN QUESTIONS
-- =====================================================

-- Q41. Find the customer or customers with the highest total spending.



-- Q42. Find the product or products with the highest total quantity sold.



-- Q43. Find the category or categories with the highest total revenue.



-- Q44. Find customers whose total spending is greater than the average customer spending.



-- Q45. Find products whose total revenue is greater than the average product revenue.



-- Q46. Find departments where the average salary is greater than the company average salary.



-- Q47. Find employees whose salary is greater than the average salary of their own department.



-- Q48. Find customers who placed an order but never made a successful payment.



-- Q49. Find orders where payment amount does not match the calculated order net amount.



-- Q50. Find products that were ordered but are missing from inventory.



-- =====================================================
-- END OF MODULE 4
-- =====================================================