/*
MODULE 02: FILTERING AND NULL HANDLING

Goal:
Understand filtering deeply using WHERE, AND, OR, IN, NOT IN, BETWEEN, LIKE,
IS NULL, IS NOT NULL, and parentheses.

Main focus:
- Write correct filtering logic
- Avoid common WHERE mistakes
- Understand NULL behavior
- Think like data engineering / interview SQL

Important:
- Use actual database values and columns.
- Do not guess column names.
- Avoid repeated similar queries unless the concept is different.
*/

-- =====================================================
-- PART 1: BASIC FILTERING
-- Concept: comparison operators (=, <>, >, >=, <, <=)
-- Industry idea: Most SQL work starts by selecting the correct subset of rows.
-- =====================================================

-- EASY Q1.
-- Show product_id, product_name, unit_price, and product_status
-- for products with unit_price greater than 100.

SELECT 
    product_id,
    product_name,
    unit_price,
    product_status
FROM
    products
WHERE
    unit_price > 100;


-- MEDIUM Q2.
-- Show employee_id, full employee name, job_title, salary, and hire_date
-- for employees hired on or after '2022-01-01' and salary greater than 90000.

SELECT 
    employee_id,
    concat(first_name,' ',last_name),
    job_title,
    salary,
    hire_date
FROM
    employees
WHERE hire_date >= '2022-01-01' AND salary > 90000;



-- HARD Q3.
-- Show payment_id, order_id, payment_status, amount, and payment_date
-- for payments that are not successful and amount is greater than or equal to 75.
-- Think carefully: "not successful" means payment_status is not equal to 'Successful'.

SELECT 
    payment_id,
    order_id,
    payment_status,
    amount,
    payment_date
FROM
    payments
WHERE payment_status != 'Successful' AND amount >= 75;



-- =====================================================
-- PART 2: AND / OR / PARENTHESES
-- Concept: AND and OR logic
-- Industry idea: Wrong parentheses can return wrong business records.
-- =====================================================

-- EASY Q4.
-- Show customer_id, full customer name, city, state, and customer_status
-- for active customers from Texas.

SELECT
    customer_id,
    concat(first_name,' ',last_name),
    city,
    state,
    customer_status
FROM
    customers
WHERE customer_status = 'Active';


-- MEDIUM Q5.
-- Show order_id, customer_id, order_date, order_status, and channel
-- for orders where the status is Completed and the channel is either Online or Mobile.

SELECT 
    order_id,
    customer_id,
    order_date,
    order_status,
    channel
FROM
    orders
WHERE order_status = 'Completed' AND channel IN ('online', 'mobile');


-- HARD Q6.
-- Show ticket_id, customer_id, issue_type, priority, ticket_status, and created_date
-- for tickets that are either:
-- 1. Open and High priority
-- OR
-- 2. Resolved and Low priority
-- Use parentheses to make the logic clear.

SELECT
    ticket_id, 
    customer_id, 
    issue_type,
    priority,
    ticket_status,
    created_date
FROM
    support_tickets
WHERE
    (ticket_status = 'Open' AND priority = 'High')
    OR
    (ticket_status = 'Resolved' AND priority = 'Low'); 




-- =====================================================
-- PART 3: IN / NOT IN
-- Concept: cleaner alternative to multiple OR conditions
-- Industry idea: Used often for filtering by allowed/excluded categories/statuses.
-- =====================================================

-- EASY Q7.
-- Show order_id, customer_id, order_status, and channel
-- for orders where channel is Online, Mobile, or Store.
-- Use IN.

SELECT 
    order_id,
    customer_id,
    order_status,
    channel
FROM
    orders
WHERE channel IN ('Online', 'Mobile','Store');


-- MEDIUM Q8.
-- Show order_id, customer_id, order_date, order_status, and channel
-- for orders where order_status is not Cancelled and not Returned.
-- Use NOT IN.

SELECT 
    order_id,
    customer_id,
    order_date,
    order_status,
    channel
FROM    
    orders
WHERE order_status NOT IN ('Cancelled', 'Return');


-- HARD Q9.
-- Show product_id, product_name, category_id, unit_price, and product_status
-- for active products that belong to category_id 1, 2, or 5
-- and have unit_price greater than 50.

SELECT 
    product_id, product_name, category_id, unit_price,product_status
FROM
    products
WHERE
    (product_status = 'Active')
    AND 
    (category_id IN ('1','2','5')) 
    AND 
    (unit_price > 50);



-- =====================================================
-- PART 4: BETWEEN
-- Concept: inclusive range filtering
-- Industry idea: Common for date windows, salary ranges, price ranges.
-- =====================================================


-- EASY Q10.
-- Show product_id, product_name, and unit_price
-- for products with unit_price between 50 and 150.

SELECT 
    product_id, product_name, unit_price
FROM
    products
WHERE unit_price BETWEEN 50 AND 150;



-- MEDIUM Q11.
-- Show order_id, customer_id, order_date, order_status, and channel
-- for orders placed between '2025-03-01' and '2025-06-30'.

SELECT
    order_id, customer_id, order_date, order_status, channel
FROM
    orders
WHERE 
    order_date BETWEEN '2025-03-01' AND '2025-06-30';


-- HARD Q12.
-- Show employee_id, full employee name, job_title, salary, and hire_date
-- for employees with salary between 90000 and 120000
-- who were hired before '2023-01-01'.

SELECT
    employee_id,
    CONCAT(first_name,' ',last_name),
    job_title,
    salary,
    hire_date
FROM
    employees
WHERE 
    (salary BETWEEN 90000 AND 120000)
    AND
    (hire_date < '2023-01-01');

-- =====================================================
-- PART 5: LIKE
-- Concept: pattern matching
-- Industry idea: Useful for text search, data cleaning, email/domain checks.
-- =====================================================



-- EASY Q13.
-- Show customer_id, first_name, last_name, and email
-- for customers whose email ends with '@email.com'.

SELECT 
    customer_id, first_name, last_name, email
FROM
    customers
WHERE email like '%@email.com';



-- MEDIUM Q14.
-- Show product_id, product_name, unit_price
-- for products where product_name contains the word 'Desk', 'Chair', or 'Table'.
-- Use LIKE and OR.

SELECT 
    product_id,
    product_name,
    unit_price
FROM
    products
WHERE
    product_name LIKE '%Desk%' 
    OR 
    product_name LIKE'%Chair%'
    OR
    product_name like '%Table%';


-- HARD Q15.
-- Show event_id, customer_id, event_date, event_type, page_url, and device_type
-- for web events where page_url contains '/product/' and device_type is Desktop.

SELECT
    event_id,
    customer_id,
    event_date,
    event_type,
    page_url,
    device_type
FROM
    web_events
WHERE
    page_url like '%/product/%'
    AND
    device_type = 'Desktop';


-- =====================================================
-- PART 6: NULL HANDLING
-- Concept: IS NULL and IS NOT NULL
-- Industry idea: Missing values are common in real pipelines and must be handled correctly.
-- =====================================================

-- EASY Q16.
-- Show customer_id, first_name, last_name, email, and phone
-- for customers whose phone is missing.

SELECT
    customer_id, first_name, last_name, email, phone
FROM
    customers
WHERE phone is NULL;

-- MEDIUM Q17.
-- Show ticket_id, customer_id, created_date, resolved_date, issue_type, and ticket_status
-- for support tickets that are still unresolved.
-- Hint: unresolved tickets have resolved_date IS NULL.

SELECT
    ticket_id, customer_id, created_date, resolved_date, issue_type,ticket_status
FROM
    support_tickets
WHERE
    resolved_date is NULL;

-- HARD Q18.
-- Show shipment_id, order_id, shipment_date, delivery_date, carrier, and shipment_status
-- for shipments that have not actually shipped yet.
-- Hint: check shipment_date, delivery_date, and carrier.

SELECT 
    shipment_id, order_id, shipment_date, delivery_date, carrier,shipment_status
FROM
    shipments
WHERE
    shipment_date is NULL;



-- =====================================================
-- PART 7: DEBUGGING FILTER LOGIC
-- Concept: identify and fix wrong WHERE logic
-- Industry idea: Interviews often test whether you can spot subtle SQL mistakes.
-- =====================================================

-- DEBUG Q19.
-- Fix the query.
-- Wrong:
-- SELECT customer_id, first_name, last_name
-- FROM customers
-- WHERE state = 'Texas' OR 'California';
-- Goal: customers from Texas or California.

SELECT customer_id, first_name, last_name
FROM customers
WHERE 
    state = 'Texas' 
    OR 
    state = 'California';



-- DEBUG Q20.
-- Fix the query.
-- Wrong:
-- SELECT order_id, order_status
-- FROM orders
-- WHERE order_status = 'Completed' OR 'Returned';
-- Goal: orders that are Completed or Returned.

SELECT order_id, order_status
FROM orders
WHERE 
    order_status = 'Completed' 
    OR 
    order_status = 'Returned';



-- DEBUG Q21.
-- Fix the query.
-- Wrong:
-- SELECT customer_id, first_name, phone
-- FROM customers
-- WHERE phone = NULL;
-- Goal: customers with missing phone numbers.

SELECT customer_id, first_name, phone
FROM customers
WHERE phone IS NULL;



-- DEBUG Q22.
-- Fix the query.
-- Wrong:
-- SELECT employee_id, first_name, salary
-- FROM employees
-- WHERE salary > 80000 AND < 120000;
-- Goal: employees with salary greater than 80000 and less than 120000.

SELECT 
    employee_id, first_name, salary
FROM 
    employees
WHERE 
    salary > 80000
    AND 
    salary < 120000;



-- =====================================================
-- PART 8: MINI INTERVIEW-STYLE FILTERING
-- Concept: combine multiple filtering concepts
-- Industry idea: Real interview questions usually combine conditions.
-- =====================================================

-- INTERVIEW Q23.
-- Find active customers from Texas or New York who have a non-null email.
-- Show customer_id, full customer name, state, email, and customer_status.

SELECT 
    customer_id,
    concat(first_name,' ',last_name) as full_customer_name,
    state,
    email,
    customer_status
FROM
    customers
WHERE
    customer_status = 'Active'
    AND
    state in ('Texas','New York')
    AND
    email is NOT NULL;



-- INTERVIEW Q24.
-- Find completed online orders placed in the first half of 2025.
-- Show order_id, customer_id, order_date, order_status, and channel.

SELECT 
    order_id,
    customer_id,
    order_date,
    order_status,
    channel
FROM
    orders
WHERE 
    order_status = 'Completed'
    AND
    order_date BETWEEN '2025-01-01' AND '2025-06-30';


-- INTERVIEW Q25.
-- Find risky payments:
-- payment_status is Failed, Pending, or Refunded,
-- OR amount is greater than 500.
-- Show payment_id, order_id, payment_status, amount, and payment_date.
-- Use parentheses so the logic is clear.

SELECT
    payment_id, order_id, payment_status, amount, payment_date
FROM
    payments
WHERE
    payment_status IN ('Failed', 'Pending', 'Refunded')
    OR
    amount > 500;



-- INTERVIEW Q26.
-- Find support tickets that should be prioritized:
-- ticket_status is Open
-- AND priority is High or Medium.
-- Show ticket_id, customer_id, issue_type, priority, ticket_status, and created_date.


SELECT
    ticket_id, customer_id,issue_type,priority,ticket_status,created_date
FROM
    support_tickets
WHERE
    ticket_status = 'Open'
    AND
    priority IN ('High','Medium');



-- INTERVIEW Q27.
-- Find valid staging customer records from stg_customers:
-- email is not null,
-- email contains '@',
-- signup_date is not 'bad-date'.
-- Show stg_customer_id, customer_id, full_name, email, signup_date, and load_date.

SELECT
    stg_customer_id, customer_id, full_name, email,signup_date,load_date
FROM
    stg_customers
WHERE
    email is NOT NULL
    AND
    email like "%@%"
    AND
    signup_date != 'bad-date';



-- INTERVIEW Q28.
-- Find problematic staging orders from stg_orders:
-- order_status is null
-- OR order_date is 'bad-date'
-- OR customer_id is 99.
-- Show stg_order_id, order_id, customer_id, order_date, order_status, channel, and load_date.

SELECT
    stg_order_id, order_id, customer_id, order_date, order_status, channel, load_date
FROM
    stg_orders
WHERE
    order_status is NULL
    OR
    order_date = 'bad-date'
    OR
    customer_id = 99;