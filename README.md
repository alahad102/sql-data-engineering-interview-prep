# SQL Data Engineering Interview Preparation

This repository documents my structured SQL learning and practice journey for Data Engineering and Azure Data Engineering interview preparation.

The main goal of this repository is to build strong SQL problem-solving ability through topic-wise practice, real-world style questions, and repeated revision. I am using this repository both as a learning tracker and as a portfolio to show my SQL preparation progress.

## About This Repository

This is not a random collection of SQL answers. It is organized as a complete SQL preparation path for data engineering roles.

The repository includes:

- A realistic MySQL practice database
- Topic-wise SQL practice files
- Diagnostic test solutions
- Easy, medium, and hard SQL problems
- Data engineering style SQL questions
- Mistake notes and corrected solutions
- Mixed practice after completing modules

I am practicing SQL using MySQL and VS Code. I use MySQL/SQLTools to run queries and Git/GitHub to track my learning progress.

## Learning Support

I am using ChatGPT as a learning assistant to help with:

- Generating practice questions
- Explaining SQL concepts
- Reviewing my solutions
- Identifying mistakes
- Suggesting better query approaches
- Creating topic-wise practice plans

All SQL solutions in this repository are written and tested by me as part of my learning process. When I make mistakes, I document them and update the corrected version for revision.

## Target Role

This repository is part of my preparation for roles such as:

- Data Engineer
- Azure Data Engineer
- Cloud Data Engineer
- SQL Data Engineer
- ETL Developer
- Junior Data Engineer

## Practice Database

The practice database is designed to simulate an e-commerce and data engineering environment.

It includes business tables such as:

- customers
- orders
- order_items
- products
- categories
- suppliers
- payments
- shipments
- inventory
- employees
- departments
- web_events
- support_tickets

It also includes data engineering and warehouse-style tables such as:

- stg_customers
- stg_orders
- dim_customer
- dim_product
- fact_sales
- etl_audit_log

This database allows me to practice core SQL, analytical SQL, data cleaning, ETL validation, and warehouse-style SQL problems.

## Topics I Am Planning to Master

### 1. SQL Foundation and Execution Order

- SELECT
- FROM
- WHERE
- ORDER BY
- LIMIT
- DISTINCT
- SQL logical execution order
- Query reading and debugging

### 2. Filtering and NULL Handling

- AND / OR
- IN / NOT IN
- BETWEEN
- LIKE
- IS NULL
- IS NOT NULL
- NULL behavior
- Filtering mistakes and edge cases

### 3. Aggregation and GROUP BY

- COUNT
- SUM
- AVG
- MIN
- MAX
- GROUP BY
- HAVING
- Conditional aggregation
- GROUP BY with multiple columns

### 4. Joins

- INNER JOIN
- LEFT JOIN
- RIGHT JOIN
- SELF JOIN
- CROSS JOIN
- Multiple table joins
- Anti-joins
- Semi-joins
- Join duplication issues

### 5. Subqueries and CTEs

- Subqueries in WHERE
- Subqueries in FROM
- Subqueries in SELECT
- Correlated subqueries
- EXISTS
- NOT EXISTS
- Common Table Expressions
- Multiple CTEs

### 6. CASE WHEN and Business Logic

- CASE WHEN
- Conditional classification
- Conditional aggregation
- Customer segmentation
- Order value classification
- Business rule implementation in SQL

### 7. Date and Time SQL

- DATE functions
- YEAR, MONTH, DAY
- DATE_FORMAT
- DATEDIFF
- DATE_ADD
- DATE_SUB
- Monthly revenue analysis
- Rolling time windows
- Customer inactivity analysis

### 8. Window Functions

- ROW_NUMBER
- RANK
- DENSE_RANK
- LAG
- LEAD
- NTILE
- SUM() OVER
- AVG() OVER
- PARTITION BY
- Window frame clauses
- Running totals
- Moving averages
- Top-N per group problems

### 9. Data Cleaning SQL

- TRIM
- LOWER
- UPPER
- REPLACE
- CONCAT
- COALESCE
- NULLIF
- Duplicate detection
- Invalid data detection
- Standardizing messy data

### 10. Data Quality and ETL Validation

- Row count validation
- Duplicate checks
- NULL checks
- Orphan record detection
- Source-to-target comparison
- Payment/order reconciliation
- Data load validation
- Audit log analysis

### 11. Data Engineering SQL

- Full load
- Incremental load
- Delta load
- Upsert logic
- MERGE concept
- Slowly Changing Dimension Type 1
- Slowly Changing Dimension Type 2
- Staging-to-target loading logic

### 12. Data Warehouse Modeling

- Fact tables
- Dimension tables
- Star schema
- Snowflake schema
- Surrogate keys
- Natural keys
- Grain of a fact table
- Fact and dimension queries

### 13. Performance and Optimization Basics

- Index basics
- EXPLAIN
- Avoiding SELECT *
- Filtering before joining
- Join keys
- SARGable conditions
- Basic query optimization thinking

### 14. Mixed Interview Practice

- Mixed SQL problems
- Timed practice
- Debugging wrong queries
- Real-world business questions
- Data engineering case studies
- Mock interview-style SQL questions

## Repository Structure

```text
SQL_MASTERING_REPO/
│
├── DATABASE/
│   └── database_creation.sql
│
├── TEST_CONNECTION/
│   └── test_connection.sql
│
├── DIAGNOSTIC_TEST/
│   └── diagnostic_test.sql
│
├── MODULE_01_EXECUTION_ORDER_QUERY_PRECISION/
│
├── MODULE_02_FILTERING_NULL_HANDLING/
│
├── MODULE_03_AGGREGATION_GROUP_BY/
│
├── MODULE_04_JOINS/
│
├── MODULE_05_SUBQUERIES_CTE/
│
├── MODULE_06_CASE_DATE_FUNCTIONS/
│
├── MODULE_07_WINDOW_FUNCTIONS/
│
├── MODULE_08_DATA_CLEANING_QUALITY/
│
├── MODULE_09_DATA_ENGINEERING_SQL/
│
├── MIXED_TESTS/
│
└── README.md