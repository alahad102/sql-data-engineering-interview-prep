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



-- Q17. Find customers who placed more than 2 orders.



-- Q18. Find total sales amount per customer using orders and order_items.



-- Q19. Find total quantity sold for each product.



-- Q20. Find total revenue per product category.



-- =====================================================
-- PART 5: MULTI-TABLE JOINS
-- =====================================================

-- Q21. Show order id, customer full name, product name, category name, quantity, and net line amount.



-- Q22. Show customer full name, product name, supplier name, and order date for every purchased product.



-- Q23. Show category name and total revenue for each category.



-- Q24. Show supplier name and total revenue generated from their products.



-- Q25. Show customer full name and total amount paid successfully.



-- =====================================================
-- PART 6: JOIN + FILTERING
-- =====================================================

-- Q26. Show customers who placed orders through the Online channel.



-- Q27. Show products sold in completed orders only.



-- Q28. Show customers who had failed or pending payments.



-- Q29. Show orders that were delivered by FedEx.



-- Q30. Show active products that have stock quantity less than 50.



-- =====================================================
-- PART 7: EMPLOYEE SELF JOIN
-- =====================================================

-- Q31. Show each employee with their manager name.



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