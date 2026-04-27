-- ============================================================
-- SQL Data Engineering Interview Practice Database
-- Database: data_engineer_practice
-- Designed for: MySQL 8+
-- ============================================================

DROP DATABASE IF EXISTS data_engineer_practice;
CREATE DATABASE data_engineer_practice;
USE data_engineer_practice;

-- ============================================================
-- 1. CORE BUSINESS TABLES
-- ============================================================

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100),
    phone VARCHAR(30),
    city VARCHAR(50),
    state VARCHAR(50),
    country VARCHAR(50),
    signup_date DATE,
    customer_status VARCHAR(20)
);

CREATE TABLE categories (
    category_id INT PRIMARY KEY,
    category_name VARCHAR(100)
);

CREATE TABLE suppliers (
    supplier_id INT PRIMARY KEY,
    supplier_name VARCHAR(100),
    country VARCHAR(50)
);

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category_id INT,
    supplier_id INT,
    unit_price DECIMAL(10,2),
    product_status VARCHAR(20),
    created_date DATE,
    FOREIGN KEY (category_id) REFERENCES categories(category_id),
    FOREIGN KEY (supplier_id) REFERENCES suppliers(supplier_id)
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    order_status VARCHAR(30),
    channel VARCHAR(30),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE order_items (
    order_item_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    unit_price DECIMAL(10,2),
    discount_amount DECIMAL(10,2),
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

CREATE TABLE payments (
    payment_id INT PRIMARY KEY,
    order_id INT,
    payment_date DATE,
    payment_method VARCHAR(30),
    payment_status VARCHAR(30),
    amount DECIMAL(10,2),
    FOREIGN KEY (order_id) REFERENCES orders(order_id)
);

CREATE TABLE shipments (
    shipment_id INT PRIMARY KEY,
    order_id INT,
    shipment_date DATE,
    delivery_date DATE,
    carrier VARCHAR(50),
    shipment_status VARCHAR(30),
    shipping_cost DECIMAL(10,2),
    FOREIGN KEY (order_id) REFERENCES orders(order_id)
);

CREATE TABLE inventory (
    inventory_id INT PRIMARY KEY,
    product_id INT,
    warehouse_location VARCHAR(50),
    stock_quantity INT,
    last_updated DATE,
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- ============================================================
-- 2. EMPLOYEE / DEPARTMENT TABLES
-- Useful for self joins, salary questions, manager hierarchy
-- ============================================================

CREATE TABLE departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(100)
);

CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    department_id INT,
    manager_id INT,
    salary DECIMAL(10,2),
    hire_date DATE,
    job_title VARCHAR(100),
    FOREIGN KEY (department_id) REFERENCES departments(department_id),
    FOREIGN KEY (manager_id) REFERENCES employees(employee_id)
);

-- ============================================================
-- 3. ANALYTICS TABLES
-- Useful for event analytics, funnels, date questions
-- ============================================================

CREATE TABLE web_events (
    event_id INT PRIMARY KEY,
    customer_id INT,
    event_date DATETIME,
    event_type VARCHAR(50),
    page_url VARCHAR(200),
    device_type VARCHAR(30),
    session_id VARCHAR(50),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE support_tickets (
    ticket_id INT PRIMARY KEY,
    customer_id INT,
    created_date DATE,
    resolved_date DATE,
    issue_type VARCHAR(100),
    priority VARCHAR(20),
    ticket_status VARCHAR(30),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- ============================================================
-- 4. STAGING TABLES
-- These intentionally do NOT have constraints.
-- Useful for data cleaning, deduplication, validation, ETL practice.
-- ============================================================

CREATE TABLE stg_customers (
    stg_customer_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    full_name VARCHAR(100),
    email VARCHAR(100),
    phone VARCHAR(30),
    city VARCHAR(50),
    state VARCHAR(50),
    country VARCHAR(50),
    signup_date VARCHAR(30),
    load_date DATE
);

CREATE TABLE stg_orders (
    stg_order_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    customer_id INT,
    order_date VARCHAR(30),
    order_status VARCHAR(30),
    channel VARCHAR(30),
    load_date DATE
);

-- ============================================================
-- 5. WAREHOUSE-STYLE TABLES
-- Useful for fact/dimension, SCD Type 2, ETL interview practice
-- ============================================================

CREATE TABLE dim_customer (
    customer_sk INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    full_name VARCHAR(100),
    email VARCHAR(100),
    city VARCHAR(50),
    state VARCHAR(50),
    country VARCHAR(50),
    effective_start_date DATE,
    effective_end_date DATE,
    is_current CHAR(1)
);

CREATE TABLE dim_product (
    product_sk INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT,
    product_name VARCHAR(100),
    category_name VARCHAR(100),
    supplier_name VARCHAR(100),
    unit_price DECIMAL(10,2),
    effective_start_date DATE,
    effective_end_date DATE,
    is_current CHAR(1)
);

CREATE TABLE fact_sales (
    sales_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    order_item_id INT,
    customer_id INT,
    product_id INT,
    order_date DATE,
    quantity INT,
    unit_price DECIMAL(10,2),
    discount_amount DECIMAL(10,2),
    gross_amount DECIMAL(10,2),
    net_amount DECIMAL(10,2)
);

CREATE TABLE etl_audit_log (
    audit_id INT AUTO_INCREMENT PRIMARY KEY,
    pipeline_name VARCHAR(100),
    source_table VARCHAR(100),
    target_table VARCHAR(100),
    load_date DATETIME,
    rows_inserted INT,
    rows_updated INT,
    rows_failed INT,
    status VARCHAR(30)
);

-- ============================================================
-- INSERT DATA
-- ============================================================

INSERT INTO customers VALUES
(1, 'John', 'Smith', 'john.smith@email.com', '111-111-1111', 'Dallas', 'Texas', 'USA', '2024-01-10', 'Active'),
(2, 'Maria', 'Garcia', 'maria.garcia@email.com', '222-222-2222', 'Austin', 'Texas', 'USA', '2024-02-15', 'Active'),
(3, 'Ahmed', 'Khan', 'ahmed.khan@email.com', '333-333-3333', 'Houston', 'Texas', 'USA', '2024-03-01', 'Active'),
(4, 'Sarah', 'Lee', 'sarah.lee@email.com', NULL, 'Chicago', 'Illinois', 'USA', '2024-03-20', 'Inactive'),
(5, 'David', 'Brown', 'david.brown@email.com', '555-555-5555', 'New York', 'New York', 'USA', '2024-04-05', 'Active'),
(6, 'Emma', 'Wilson', 'emma.wilson@email.com', '666-666-6666', 'Seattle', 'Washington', 'USA', '2024-05-12', 'Active'),
(7, 'Liam', 'Davis', NULL, '777-777-7777', 'Miami', 'Florida', 'USA', '2024-06-18', 'Active'),
(8, 'Olivia', 'Miller', 'olivia.miller@email.com', '888-888-8888', 'Denver', 'Colorado', 'USA', '2024-07-22', 'Inactive'),
(9, 'Noah', 'Taylor', 'noah.taylor@email.com', '999-999-9999', 'Phoenix', 'Arizona', 'USA', '2024-08-30', 'Active'),
(10, 'Sophia', 'Anderson', 'sophia.anderson@email.com', '101-101-1010', 'Boston', 'Massachusetts', 'USA', '2024-09-14', 'Active');

INSERT INTO categories VALUES
(1, 'Electronics'),
(2, 'Furniture'),
(3, 'Office Supplies'),
(4, 'Clothing'),
(5, 'Kitchen');

INSERT INTO suppliers VALUES
(1, 'TechSource Inc', 'USA'),
(2, 'HomePro Supply', 'USA'),
(3, 'Global Office Ltd', 'Canada'),
(4, 'StyleHub', 'USA'),
(5, 'KitchenWorld', 'Mexico');

INSERT INTO products VALUES
(101, 'Laptop', 1, 1, 950.00, 'Active', '2023-12-01'),
(102, 'Wireless Mouse', 1, 1, 25.00, 'Active', '2023-12-05'),
(103, 'Office Chair', 2, 2, 180.00, 'Active', '2024-01-10'),
(104, 'Standing Desk', 2, 2, 450.00, 'Active', '2024-01-15'),
(105, 'Notebook Pack', 3, 3, 12.00, 'Active', '2024-02-01'),
(106, 'Printer Paper', 3, 3, 8.00, 'Active', '2024-02-10'),
(107, 'T-Shirt', 4, 4, 20.00, 'Active', '2024-03-01'),
(108, 'Jacket', 4, 4, 75.00, 'Inactive', '2024-03-15'),
(109, 'Blender', 5, 5, 60.00, 'Active', '2024-04-01'),
(110, 'Coffee Maker', 5, 5, 85.00, 'Active', '2024-04-20'),
(111, 'Tablet', 1, 1, 300.00, 'Active', '2024-05-01'),
(112, 'Bookshelf', 2, 2, 130.00, 'Active', '2024-05-10');

INSERT INTO orders VALUES
(1001, 1, '2025-01-05', 'Completed', 'Online'),
(1002, 1, '2025-01-20', 'Completed', 'Mobile'),
(1003, 2, '2025-02-02', 'Completed', 'Online'),
(1004, 3, '2025-02-18', 'Cancelled', 'Store'),
(1005, 3, '2025-03-01', 'Completed', 'Online'),
(1006, 5, '2025-03-15', 'Completed', 'Mobile'),
(1007, 6, '2025-04-01', 'Completed', 'Online'),
(1008, 7, '2025-04-20', 'Pending', 'Online'),
(1009, 9, '2025-05-05', 'Completed', 'Store'),
(1010, 10, '2025-05-18', 'Completed', 'Mobile'),
(1011, 2, '2025-06-01', 'Completed', 'Online'),
(1012, 5, '2025-06-15', 'Returned', 'Online'),
(1013, 6, '2025-07-01', 'Completed', 'Store'),
(1014, 1, '2025-07-20', 'Completed', 'Online'),
(1015, 9, '2025-08-05', 'Completed', 'Mobile');

INSERT INTO order_items VALUES
(1, 1001, 101, 1, 950.00, 50.00),
(2, 1001, 102, 2, 25.00, 0.00),
(3, 1002, 103, 1, 180.00, 10.00),
(4, 1003, 105, 5, 12.00, 0.00),
(5, 1003, 106, 10, 8.00, 5.00),
(6, 1004, 111, 1, 300.00, 0.00),
(7, 1005, 104, 1, 450.00, 25.00),
(8, 1006, 109, 2, 60.00, 0.00),
(9, 1006, 110, 1, 85.00, 5.00),
(10, 1007, 101, 1, 950.00, 100.00),
(11, 1008, 107, 3, 20.00, 0.00),
(12, 1009, 112, 1, 130.00, 0.00),
(13, 1010, 111, 2, 300.00, 30.00),
(14, 1011, 102, 4, 25.00, 0.00),
(15, 1011, 105, 10, 12.00, 0.00),
(16, 1012, 108, 1, 75.00, 0.00),
(17, 1013, 110, 1, 85.00, 0.00),
(18, 1014, 104, 1, 450.00, 50.00),
(19, 1015, 109, 1, 60.00, 0.00),
(20, 1015, 106, 5, 8.00, 0.00);

INSERT INTO payments VALUES
(1, 1001, '2025-01-05', 'Credit Card', 'Successful', 950.00),
(2, 1002, '2025-01-20', 'PayPal', 'Successful', 170.00),
(3, 1003, '2025-02-02', 'Credit Card', 'Successful', 135.00),
(4, 1004, '2025-02-18', 'Credit Card', 'Failed', 300.00),
(5, 1005, '2025-03-01', 'Debit Card', 'Successful', 425.00),
(6, 1006, '2025-03-15', 'Credit Card', 'Successful', 200.00),
(7, 1007, '2025-04-01', 'Credit Card', 'Successful', 850.00),
(8, 1008, '2025-04-20', 'PayPal', 'Pending', 60.00),
(9, 1009, '2025-05-05', 'Debit Card', 'Successful', 130.00),
(10, 1010, '2025-05-18', 'Credit Card', 'Successful', 570.00),
(11, 1011, '2025-06-01', 'Credit Card', 'Successful', 220.00),
(12, 1012, '2025-06-15', 'Credit Card', 'Refunded', 75.00),
(13, 1013, '2025-07-01', 'Debit Card', 'Successful', 85.00),
(14, 1014, '2025-07-20', 'Credit Card', 'Successful', 400.00),
(15, 1015, '2025-08-05', 'PayPal', 'Successful', 100.00);

INSERT INTO shipments VALUES
(1, 1001, '2025-01-06', '2025-01-10', 'FedEx', 'Delivered', 15.00),
(2, 1002, '2025-01-21', '2025-01-25', 'UPS', 'Delivered', 10.00),
(3, 1003, '2025-02-03', '2025-02-08', 'USPS', 'Delivered', 8.00),
(4, 1005, '2025-03-02', '2025-03-10', 'FedEx', 'Delivered', 20.00),
(5, 1006, '2025-03-16', '2025-03-19', 'UPS', 'Delivered', 12.00),
(6, 1007, '2025-04-02', '2025-04-12', 'FedEx', 'Delivered', 18.00),
(7, 1008, NULL, NULL, NULL, 'Not Shipped', 0.00),
(8, 1009, '2025-05-06', '2025-05-09', 'USPS', 'Delivered', 9.00),
(9, 1010, '2025-05-19', '2025-05-30', 'FedEx', 'Delivered', 16.00),
(10, 1011, '2025-06-02', '2025-06-05', 'UPS', 'Delivered', 7.00),
(11, 1012, '2025-06-16', '2025-06-20', 'USPS', 'Returned', 8.00),
(12, 1013, '2025-07-02', '2025-07-04', 'UPS', 'Delivered', 6.00),
(13, 1014, '2025-07-21', '2025-07-29', 'FedEx', 'Delivered', 14.00),
(14, 1015, '2025-08-06', '2025-08-09', 'USPS', 'Delivered', 5.00);

INSERT INTO inventory VALUES
(1, 101, 'Dallas_WH', 25, '2025-08-01'),
(2, 102, 'Dallas_WH', 300, '2025-08-01'),
(3, 103, 'Chicago_WH', 40, '2025-08-02'),
(4, 104, 'Chicago_WH', 15, '2025-08-02'),
(5, 105, 'Dallas_WH', 500, '2025-08-03'),
(6, 106, 'Dallas_WH', 800, '2025-08-03'),
(7, 107, 'Miami_WH', 150, '2025-08-04'),
(8, 108, 'Miami_WH', 20, '2025-08-04'),
(9, 109, 'Phoenix_WH', 60, '2025-08-05'),
(10, 110, 'Phoenix_WH', 35, '2025-08-05'),
(11, 111, 'Seattle_WH', 45, '2025-08-06'),
(12, 112, 'Chicago_WH', 25, '2025-08-06');

INSERT INTO departments VALUES
(1, 'Engineering'),
(2, 'Sales'),
(3, 'HR'),
(4, 'Finance'),
(5, 'Operations');

INSERT INTO employees VALUES
(1, 'Robert', 'King', 1, NULL, 150000.00, '2020-01-10', 'Director of Engineering'),
(2, 'Linda', 'Scott', 2, NULL, 140000.00, '2020-02-15', 'Sales Director'),
(3, 'James', 'Moore', 1, 1, 110000.00, '2021-03-20', 'Data Engineer'),
(4, 'Patricia', 'Hall', 1, 1, 115000.00, '2021-06-01', 'Senior Data Engineer'),
(5, 'Michael', 'Young', 2, 2, 90000.00, '2022-01-05', 'Sales Analyst'),
(6, 'Jennifer', 'Allen', 2, 2, 95000.00, '2022-03-10', 'Account Manager'),
(7, 'William', 'Wright', 3, NULL, 85000.00, '2021-09-15', 'HR Manager'),
(8, 'Elizabeth', 'Lopez', 4, NULL, 105000.00, '2021-10-20', 'Finance Manager'),
(9, 'Daniel', 'Hill', 5, NULL, 100000.00, '2020-11-11', 'Operations Manager'),
(10, 'Susan', 'Green', 5, 9, 75000.00, '2023-02-01', 'Logistics Coordinator'),
(11, 'Joseph', 'Adams', 1, 4, 98000.00, '2023-04-10', 'BI Developer'),
(12, 'Karen', 'Baker', 1, 4, 102000.00, '2023-07-15', 'Cloud Data Engineer');

INSERT INTO web_events VALUES
(1, 1, '2025-01-01 10:00:00', 'page_view', '/home', 'Desktop', 'S001'),
(2, 1, '2025-01-01 10:05:00', 'product_view', '/product/101', 'Desktop', 'S001'),
(3, 1, '2025-01-01 10:10:00', 'add_to_cart', '/cart', 'Desktop', 'S001'),
(4, 1, '2025-01-05 09:30:00', 'purchase', '/checkout', 'Mobile', 'S002'),
(5, 2, '2025-02-01 11:00:00', 'page_view', '/home', 'Mobile', 'S003'),
(6, 2, '2025-02-02 12:00:00', 'purchase', '/checkout', 'Mobile', 'S003'),
(7, 3, '2025-02-15 14:00:00', 'page_view', '/home', 'Desktop', 'S004'),
(8, 3, '2025-03-01 15:00:00', 'purchase', '/checkout', 'Desktop', 'S005'),
(9, 5, '2025-03-10 16:00:00', 'product_view', '/product/109', 'Tablet', 'S006'),
(10, 5, '2025-03-15 16:30:00', 'purchase', '/checkout', 'Tablet', 'S006'),
(11, 6, '2025-04-01 08:00:00', 'purchase', '/checkout', 'Desktop', 'S007'),
(12, 7, '2025-04-18 17:00:00', 'add_to_cart', '/cart', 'Mobile', 'S008'),
(13, 9, '2025-05-05 13:00:00', 'purchase', '/checkout', 'Desktop', 'S009'),
(14, 10, '2025-05-18 19:00:00', 'purchase', '/checkout', 'Mobile', 'S010');

INSERT INTO support_tickets VALUES
(1, 1, '2025-01-06', '2025-01-08', 'Payment Issue', 'High', 'Resolved'),
(2, 2, '2025-02-04', '2025-02-05', 'Delivery Question', 'Medium', 'Resolved'),
(3, 3, '2025-03-02', NULL, 'Product Issue', 'High', 'Open'),
(4, 5, '2025-03-18', '2025-03-22', 'Return Request', 'Low', 'Resolved'),
(5, 6, '2025-04-05', '2025-04-15', 'Late Delivery', 'High', 'Resolved'),
(6, 7, '2025-04-22', NULL, 'Payment Pending', 'Medium', 'Open'),
(7, 10, '2025-05-20', '2025-05-21', 'Account Help', 'Low', 'Resolved');

-- ============================================================
-- STAGING DATA WITH DIRTY / DUPLICATE / INCONSISTENT RECORDS
-- ============================================================

INSERT INTO stg_customers
(customer_id, full_name, email, phone, city, state, country, signup_date, load_date)
VALUES
(1, ' John Smith ', 'JOHN.SMITH@EMAIL.COM', '111-111-1111', 'Dallas', 'Texas', 'USA', '2024-01-10', '2025-09-01'),
(2, 'Maria Garcia', 'maria.garcia@email.com', '222-222-2222', 'Austin', 'Texas', 'USA', '2024-02-15', '2025-09-01'),
(3, 'Ahmed Khan', 'ahmed.khan@email.com', '333-333-3333', 'Houston', 'Texas', 'USA', '2024-03-01', '2025-09-01'),
(3, 'Ahmed Khan', 'ahmed.khan@email.com', '333-333-3333', 'Houston', 'Texas', 'USA', '2024-03-01', '2025-09-01'),
(4, 'Sarah Lee', 'sarah.lee@email.com', NULL, 'Chicago', 'Illinois', 'USA', '2024-03-20', '2025-09-01'),
(11, 'Ethan White', 'ethan.white@email.com', '111-222-3333', 'Atlanta', 'Georgia', 'USA', '2025-09-01', '2025-09-01'),
(12, ' Mia Clark ', 'mia.clark@email.com ', '444-555-6666', 'Orlando', 'Florida', 'USA', 'bad-date', '2025-09-01'),
(13, 'Invalid Email User', 'not-an-email', '777-888-9999', 'Dallas', 'Texas', 'USA', '2025-09-02', '2025-09-01');

INSERT INTO stg_orders
(order_id, customer_id, order_date, order_status, channel, load_date)
VALUES
(1016, 1, '2025-09-01', 'Completed', 'Online', '2025-09-02'),
(1017, 2, '2025-09-01', 'Completed', 'Mobile', '2025-09-02'),
(1018, 11, '2025-09-02', 'Completed', 'Online', '2025-09-02'),
(1019, 99, '2025-09-02', 'Completed', 'Store', '2025-09-02'),
(1020, 3, 'bad-date', 'Pending', 'Online', '2025-09-02'),
(1021, 5, '2025-09-03', NULL, 'Mobile', '2025-09-02'),
(1021, 5, '2025-09-03', NULL, 'Mobile', '2025-09-02');

-- ============================================================
-- LOAD BASIC DIMENSION TABLES
-- ============================================================

INSERT INTO dim_customer
(customer_id, full_name, email, city, state, country, effective_start_date, effective_end_date, is_current)
SELECT
    customer_id,
    CONCAT(first_name, ' ', last_name) AS full_name,
    email,
    city,
    state,
    country,
    signup_date,
    '9999-12-31',
    'Y'
FROM customers;

INSERT INTO dim_product
(product_id, product_name, category_name, supplier_name, unit_price, effective_start_date, effective_end_date, is_current)
SELECT
    p.product_id,
    p.product_name,
    c.category_name,
    s.supplier_name,
    p.unit_price,
    p.created_date,
    '9999-12-31',
    'Y'
FROM products p
JOIN categories c
    ON p.category_id = c.category_id
JOIN suppliers s
    ON p.supplier_id = s.supplier_id;

-- ============================================================
-- LOAD FACT SALES TABLE
-- ============================================================

INSERT INTO fact_sales
(order_id, order_item_id, customer_id, product_id, order_date, quantity, unit_price, discount_amount, gross_amount, net_amount)
SELECT
    o.order_id,
    oi.order_item_id,
    o.customer_id,
    oi.product_id,
    o.order_date,
    oi.quantity,
    oi.unit_price,
    oi.discount_amount,
    oi.quantity * oi.unit_price AS gross_amount,
    (oi.quantity * oi.unit_price) - oi.discount_amount AS net_amount
FROM orders o
JOIN order_items oi
    ON o.order_id = oi.order_id;

-- ============================================================
-- ETL AUDIT LOG SAMPLE DATA
-- ============================================================

INSERT INTO etl_audit_log
(pipeline_name, source_table, target_table, load_date, rows_inserted, rows_updated, rows_failed, status)
VALUES
('load_dim_customer', 'customers', 'dim_customer', '2025-09-01 01:00:00', 10, 0, 0, 'Success'),
('load_dim_product', 'products', 'dim_product', '2025-09-01 01:10:00', 12, 0, 0, 'Success'),
('load_fact_sales', 'orders/order_items', 'fact_sales', '2025-09-01 01:30:00', 20, 0, 0, 'Success'),
('load_stg_customers', 'raw_customers_file', 'stg_customers', '2025-09-02 01:00:00', 8, 0, 2, 'Warning'),
('load_stg_orders', 'raw_orders_file', 'stg_orders', '2025-09-02 01:20:00', 7, 0, 3, 'Warning');

-- ============================================================
-- BASIC CHECKS
-- ============================================================

SELECT 'customers' AS table_name, COUNT(*) AS row_count FROM customers
UNION ALL
SELECT 'orders', COUNT(*) FROM orders
UNION ALL
SELECT 'order_items', COUNT(*) FROM order_items
UNION ALL
SELECT 'products', COUNT(*) FROM products
UNION ALL
SELECT 'payments', COUNT(*) FROM payments
UNION ALL
SELECT 'shipments', COUNT(*) FROM shipments
UNION ALL
SELECT 'fact_sales', COUNT(*) FROM fact_sales
UNION ALL
SELECT 'stg_customers', COUNT(*) FROM stg_customers
UNION ALL
SELECT 'stg_orders', COUNT(*) FROM stg_orders;