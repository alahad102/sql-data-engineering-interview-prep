# Module 01: Execution Order and Query Precision

## Goal

The goal of this module is to build strong SQL basics and write clean, precise, interview-ready queries.

This module focuses on simple SQL queries using:

- SELECT
- FROM
- WHERE
- DISTINCT
- ORDER BY
- LIMIT
- Aliases
- Basic debugging
- Logical SQL execution order

Even though the queries are simple, the main focus is accuracy, clean formatting, correct column selection, and understanding how SQL executes a query.

---

## Why This Module Matters

Before learning joins, aggregation, subqueries, CTEs, window functions, and data engineering SQL, I need to be comfortable writing basic queries correctly.

In interviews and real data engineering work, small mistakes can cause wrong results, such as:

- Using the wrong column name
- Forgetting a WHERE condition
- Using SELECT * unnecessarily
- Misunderstanding DISTINCT
- Writing ORDER BY and LIMIT in the wrong order
- Forgetting aliases for calculated columns
- Filtering using values that do not exist in the database

This module helps me build precision before moving to harder SQL topics.

---

## Logical SQL Execution Order

SQL is written in this order:

```sql
SELECT
FROM
WHERE
ORDER BY
LIMIT
```

But SQL logically executes in this order:

```text
1. FROM
2. WHERE
3. SELECT
4. ORDER BY
5. LIMIT
```

Example:

```sql
SELECT 
    order_id,
    customer_id,
    order_date,
    order_status
FROM orders
WHERE order_status = 'Completed'
ORDER BY order_date DESC
LIMIT 5;
```

Execution thinking:

```text
1. FROM orders
2. WHERE order_status = 'Completed'
3. SELECT selected columns
4. ORDER BY order_date DESC
5. LIMIT 5
```

---

## Topics Practiced

### 1. SELECT and FROM

I practiced selecting all columns and specific columns from tables.

Example:

```sql
SELECT 
    customer_id,
    first_name,
    last_name,
    city,
    state
FROM customers;
```

Important habit:

```text
Avoid SELECT * unless inspecting a table or when the question clearly asks for all columns.
```

---

### 2. WHERE Filtering

I practiced filtering rows using conditions.

Example:

```sql
SELECT 
    customer_id,
    first_name,
    last_name,
    customer_status
FROM customers
WHERE customer_status = 'Active';
```

Important habit:

```text
Use the actual column names and actual values from the database.
```

For example, in my database:

```text
customers table uses customer_status
orders table uses order_status values such as Completed, Pending, Cancelled, Returned
```

So I should not assume column names or values without checking the schema/data.

---

### 3. DISTINCT

I practiced finding unique values.

Example:

```sql
SELECT DISTINCT order_status
FROM orders;
```

Important lesson:

```text
DISTINCT applies to the full selected row, not only the first column.
```

Correct:

```sql
SELECT DISTINCT order_status
FROM orders;
```

This returns unique order statuses.

But this:

```sql
SELECT DISTINCT order_status, customer_id
FROM orders;
```

returns unique combinations of `order_status` and `customer_id`, not only unique statuses.

---

### 4. ORDER BY and LIMIT

I practiced sorting results and limiting output.

Example:

```sql
SELECT 
    order_id,
    customer_id,
    order_date,
    order_status
FROM orders
ORDER BY order_date DESC
LIMIT 5;
```

Important order:

```sql
ORDER BY
LIMIT
```

Not:

```sql
LIMIT
ORDER BY
```

---

### 5. Aliases

I practiced using aliases for calculated columns.

Example:

```sql
SELECT 
    customer_id,
    CONCAT(first_name, ' ', last_name) AS full_name
FROM customers;
```

Important habit:

```text
Always give aliases to calculated columns.
```

Good:

```sql
CONCAT(first_name, ' ', last_name) AS full_name
```

Avoid unclear output column names like:

```sql
CONCAT(first_name, ' ', last_name)
```

---

### 6. MySQL String Concatenation

In MySQL, string concatenation should be done using `CONCAT()`.

Correct:

```sql
SELECT 
    CONCAT(first_name, ' ', last_name) AS full_name
FROM customers;
```

Incorrect for MySQL:

```sql
SELECT first_name + ' ' + last_name AS full_name
FROM customers;
```

---

### 7. Debugging Wrong Queries

I practiced fixing common SQL mistakes.

Example wrong query:

```sql
SELECT customer_id, first_name, last_name
WHERE state = 'Texas'
FROM customers;
```

Correct query:

```sql
SELECT 
    customer_id,
    first_name,
    last_name
FROM customers
WHERE state = 'Texas';
```

Reason:

```text
FROM must come before WHERE.
```

---

## Key Mistakes I Learned From

### Mistake 1: Using SELECT * too much

`SELECT *` is okay for quick inspection:

```sql
SELECT *
FROM customers;
```

But for practice and interviews, it is better to select only needed columns:

```sql
SELECT 
    customer_id,
    first_name,
    last_name,
    city,
    state
FROM customers;
```

---

### Mistake 2: Forgetting a WHERE condition

If the question says:

```text
employees whose salary is greater than 70000
```

Then the query must include:

```sql
WHERE salary > 70000
```

Correct:

```sql
SELECT 
    employee_id,
    first_name,
    salary
FROM employees
WHERE salary > 70000
ORDER BY salary DESC
LIMIT 5;
```

---

### Mistake 3: Misunderstanding DISTINCT

This is correct for unique statuses:

```sql
SELECT DISTINCT order_status
FROM orders;
```

This is not the same thing:

```sql
SELECT DISTINCT order_status, customer_id
FROM orders;
```

The second query gives unique combinations.

---

### Mistake 4: Not aliasing calculated columns

Less clean:

```sql
SELECT 
    CONCAT(first_name, ' ', last_name)
FROM customers;
```

Better:

```sql
SELECT 
    CONCAT(first_name, ' ', last_name) AS full_name
FROM customers;
```

---

### Mistake 5: Assuming column names

I learned that I should check the actual database schema.

For example, stock quantity is not stored inside the `products` table in my database. It is stored in the `inventory` table.

So for Module 1, I should avoid questions requiring joins unless the needed column is in the same table.

---

## Clean SQL Style Used in This Module

I practiced writing queries like this:

```sql
SELECT 
    customer_id,
    first_name,
    last_name,
    city,
    state
FROM customers
WHERE state = 'Texas'
ORDER BY signup_date DESC
LIMIT 5;
```

Formatting rules:

```text
1. Put major SQL clauses on separate lines.
2. Put selected columns on separate lines for readability.
3. Use uppercase SQL keywords.
4. Use single quotes for string values.
5. Use clear aliases.
6. Avoid SELECT * unless needed.
```

---

## Final Module 1 Skills

After completing this module, I can:

- Write basic SELECT queries
- Filter rows using WHERE
- Sort results using ORDER BY
- Limit results using LIMIT
- Find unique values using DISTINCT
- Use aliases for calculated columns
- Use CONCAT() for full names in MySQL
- Understand basic SQL logical execution order
- Debug common beginner SQL mistakes
- Write cleaner, more professional SQL

---

## Status

Module 01 completed.

Next module:

```text
Module 02: Filtering and NULL Handling
```

Topics for next module:

- AND / OR
- IN / NOT IN
- BETWEEN
- LIKE
- IS NULL
- IS NOT NULL
- NULL behavior
- Filtering edge cases