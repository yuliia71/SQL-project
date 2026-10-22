-- Identifying boundaries. Understanding the scope of data and the timespan

SELECT 
MIN(order_date) AS first_order_date,
MAX(order_date) AS last_order_date,
EXTRACT(YEAR FROM AGE(MAX(order_date), MIN(order_date))) AS order_range_years
FROM project.fact_sales

SELECT 
MIN(birthdate) AS oldest_customer_birthdate,
EXTRACT(YEAR FROM AGE(MIN(birthdate))) AS oldest_customer_age,
MAX(birthdate) AS youngest_customer_birthdate,
EXTRACT(YEAR FROM AGE(MAX(birthdate))) AS youngest_customer_age
FROM project.dim_customers


