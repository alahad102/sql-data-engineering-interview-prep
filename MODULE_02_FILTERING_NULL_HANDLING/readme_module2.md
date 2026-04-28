# Module 02: Filtering and NULL Handling

## Goal

The goal of this module is to understand SQL filtering deeply and write accurate `WHERE` conditions for real interview and data engineering problems.

This module focuses on:

- Basic comparison filters
- `AND` / `OR`
- Parentheses in filtering logic
- `IN` / `NOT IN`
- `BETWEEN`
- `LIKE`
- `IS NULL`
- `IS NOT NULL`
- Debugging wrong filter logic
- Multi-condition business filtering

The main focus was not just syntax. The main focus was understanding how filtering logic works and avoiding mistakes that can return wrong business results.

---

## Why This Module Matters

Filtering is one of the most common tasks in SQL.

In real data engineering work, incorrect filters can cause serious problems, such as:

- Including wrong records in reports
- Excluding valid records from pipelines
- Missing bad or incomplete staging data
- Returning incorrect interview answers
- Misclassifying business records
- Failing ETL validation checks

This module helped me practice how to convert a business question into correct SQL filter conditions.

---

## Topics Practiced

### 1. Basic Comparison Filters

I practiced using comparison operators:

```sql
=
<>
!=
>
>=
<
<=
```

Example:

```sql
SELECT 
    product_id,
    product_name,
    unit_price,
    product_status
FROM products
WHERE unit_price > 100;
```

Important idea:

```text
Comparison filters are used to select rows that satisfy a specific condition.
```

---

### 2. Multiple Conditions with AND

I practiced using `AND` when all conditions must be true.

Example:

```sql
SELECT 
    employee_id,
    CONCAT(first_name, ' ', last_name) AS full_employee_name,
    job_title,
    salary,
    hire_date
FROM employees
WHERE hire_date >= '2022-01-01'
  AND salary > 90000;
```

Important idea:

```text
AND means every condition must be true for the row to be returned.
```

---

### 3. OR Logic

I practiced using `OR` when at least one condition can be true.

Example:

```sql
SELECT 
    order_id,
    order_status
FROM orders
WHERE order_status = 'Completed'
   OR order_status = 'Returned';
```

Important idea:

```text
OR means a row is returned if at least one condition is true.
```

---

### 4. Parentheses with AND / OR

I practiced using parentheses to make complex logic clear.

Example:

```sql
SELECT
    ticket_id, 
    customer_id, 
    issue_type,
    priority,
    ticket_status,
    created_date
FROM support_tickets
WHERE 
    (ticket_status = 'Open' AND priority = 'High')
    OR
    (ticket_status = 'Resolved' AND priority = 'Low');
```

Important idea:

```text
Parentheses are important when mixing AND and OR because they control the intended logic.
```

Without parentheses, SQL may still run but return the wrong rows.

---

### 5. IN

I practiced using `IN` as a cleaner alternative to multiple `OR` conditions.

Example:

```sql
SELECT 
    order_id,
    customer_id,
    order_status,
    channel
FROM orders
WHERE channel IN ('Online', 'Mobile', 'Store');
```

Important idea:

```text
IN is useful when filtering a column against multiple allowed values.
```

This:

```sql
WHERE channel IN ('Online', 'Mobile', 'Store')
```

is cleaner than:

```sql
WHERE channel = 'Online'
   OR channel = 'Mobile'
   OR channel = 'Store'
```

---

### 6. NOT IN

I practiced excluding multiple values using `NOT IN`.

Example:

```sql
SELECT 
    order_id,
    customer_id,
    order_date,
    order_status,
    channel
FROM orders
WHERE order_status NOT IN ('Cancelled', 'Returned');
```

Important idea:

```text
NOT IN is useful when excluding multiple categories or statuses.
```

---

### 7. BETWEEN

I practiced range filtering with numbers and dates.

Example:

```sql
SELECT 
    product_id,
    product_name,
    unit_price
FROM products
WHERE unit_price BETWEEN 50 AND 150;
```

Date example:

```sql
SELECT
    order_id,
    customer_id,
    order_date,
    order_status,
    channel
FROM orders
WHERE order_date BETWEEN '2025-03-01' AND '2025-06-30';
```

Important idea:

```text
BETWEEN is inclusive.
```

This:

```sql
WHERE unit_price BETWEEN 50 AND 150
```

means:

```sql
WHERE unit_price >= 50
  AND unit_price <= 150
```

---

### 8. LIKE

I practiced pattern matching using `LIKE`.

Examples:

```sql
SELECT 
    customer_id,
    first_name,
    last_name,
    email
FROM customers
WHERE email LIKE '%@email.com';
```

```sql
SELECT 
    product_id,
    product_name,
    unit_price
FROM products
WHERE product_name LIKE '%Desk%'
   OR product_name LIKE '%Chair%'
   OR product_name LIKE '%Table%';
```

Important patterns:

```text
'A%'   starts with A
'%A'   ends with A
'%A%'  contains A
'_A%'  second character is A
```

Important idea:

```text
LIKE is useful for text search, domain checks, and basic data cleaning.
```

---

### 9. NULL Handling

I practiced filtering missing values using:

```sql
IS NULL
IS NOT NULL
```

Correct:

```sql
SELECT
    customer_id,
    first_name,
    last_name,
    email,
    phone
FROM customers
WHERE phone IS NULL;
```

Incorrect:

```sql
WHERE phone = NULL
```

Important idea:

```text
NULL means missing or unknown, so normal equality comparisons do not work with NULL.
```

To find non-missing values:

```sql
WHERE email IS NOT NULL
```

---

### 10. Data Engineering Style Filtering

I practiced filtering staging tables to identify valid and problematic records.

Example valid staging customers:

```sql
SELECT
    stg_customer_id,
    customer_id,
    full_name,
    email,
    signup_date,
    load_date
FROM stg_customers
WHERE email IS NOT NULL
  AND email LIKE '%@%'
  AND signup_date <> 'bad-date';
```

Example problematic staging orders:

```sql
SELECT
    stg_order_id,
    order_id,
    customer_id,
    order_date,
    order_status,
    channel,
    load_date
FROM stg_orders
WHERE order_status IS NULL
   OR order_date = 'bad-date'
   OR customer_id = 99;
```

Important idea:

```text
Filtering is not only for reports. It is also used for data quality checks, ETL validation, and detecting bad source records.
```

---

## Common Mistakes Learned

### Mistake 1: Missing One Condition from the Question

Example question:

```text
Find active customers from Texas.
```

This requires two filters:

```sql
WHERE customer_status = 'Active'
  AND state = 'Texas'
```

If I only write:

```sql
WHERE customer_status = 'Active'
```

then the query is incomplete.

---

### Mistake 2: Using the Wrong Stored Value

Example:

```sql
WHERE order_status NOT IN ('Cancelled', 'Return')
```

This is wrong if the database stores the value as:

```text
Returned
```

Correct:

```sql
WHERE order_status NOT IN ('Cancelled', 'Returned')
```

Important idea:

```text
Always use the exact values stored in the database.
```

---

### Mistake 3: Using String Quotes for Numeric Columns

Less ideal:

```sql
WHERE category_id IN ('1', '2', '5')
```

Better:

```sql
WHERE category_id IN (1, 2, 5)
```

Important idea:

```text
Use numeric values without quotes when the column is numeric.
```

---

### Mistake 4: Forgetting Parentheses with AND / OR

Risky:

```sql
WHERE ticket_status = 'Open'
  AND priority = 'High'
   OR priority = 'Medium'
```

Better:

```sql
WHERE ticket_status = 'Open'
  AND priority IN ('High', 'Medium')
```

or:

```sql
WHERE ticket_status = 'Open'
  AND (priority = 'High' OR priority = 'Medium')
```

Important idea:

```text
Parentheses prevent logic mistakes when combining AND and OR.
```

---

### Mistake 5: Using = NULL

Incorrect:

```sql
WHERE phone = NULL
```

Correct:

```sql
WHERE phone IS NULL
```

Important idea:

```text
NULL must be checked using IS NULL or IS NOT NULL.
```

---

### Mistake 6: Forgetting Aliases for Calculated Columns

Less clean:

```sql
SELECT CONCAT(first_name, ' ', last_name)
FROM customers;
```

Better:

```sql
SELECT CONCAT(first_name, ' ', last_name) AS full_customer_name
FROM customers;
```

Important idea:

```text
Calculated columns should have clear aliases.
```

---

## Clean Filtering Style Used in This Module

Example:

```sql
SELECT 
    order_id,
    customer_id,
    order_date,
    order_status,
    channel
FROM orders
WHERE order_status = 'Completed'
  AND channel = 'Online'
  AND order_date BETWEEN '2025-01-01' AND '2025-06-30'
ORDER BY order_date;
```

Formatting habits:

```text
1. Put SELECT columns on separate lines.
2. Put each major SQL clause on its own line.
3. Use AND / OR clearly.
4. Use parentheses when logic may be confusing.
5. Use single quotes for string values.
6. Match real database values exactly.
7. Use IS NULL / IS NOT NULL for missing values.
8. Use aliases for calculated columns.
```

---

## Final Module 2 Skills

After completing this module, I can:

- Write accurate WHERE filters
- Use comparison operators correctly
- Combine filters using AND and OR
- Use parentheses to control filter logic
- Use IN instead of repeated OR conditions
- Use NOT IN to exclude categories
- Use BETWEEN for numeric and date ranges
- Understand that BETWEEN is inclusive
- Use LIKE for text pattern matching
- Use IS NULL and IS NOT NULL correctly
- Avoid common filtering mistakes
- Identify incomplete filter logic from business questions
- Apply filtering to data engineering and staging table checks

---

## Status

Module 02 completed.

Next module:

```text
Module 03: Aggregation and GROUP BY
```

Topics for next module:

- COUNT
- SUM
- AVG
- MIN
- MAX
- GROUP BY
- HAVING
- Conditional aggregation
- GROUP BY with multiple columns
- Aggregation mistakes and interview patterns