-- Calculating aggregated metrics. Identifying trends and spotting anomalies.

SELECT 
SUM(sales_amount) AS total_sales
FROM project.fact_sales

SELECT 
SUM(quantity) AS total_quantity
FROM project.fact_sales

SELECT
AVG(price) AS avg_price
FROM project.fact_sales

SELECT 
COUNT(DISTINCT order_number) AS total_orders
FROM project.fact_sales

SELECT 
COUNT(product_key) AS total_products
FROM project.products

SELECT 
COUNT( customer_key) AS total_customers
FROM project.customers

SELECT
COUNT(DISTINCT customer_key) AS total_customers_with_order
FROM project.fact_sales

-- Generating a report that shows all key metrics

SELECT 
'Total sales' AS measure_name,
SUM(sales_amount) AS measure_value
FROM project.fact_sales
UNION ALL
SELECT
'Total quantity',
SUM(quantity)
FROM project.fact_sales
UNION ALL
SELECT
'Average price',
AVG(price)
FROM project.fact_sales
UNION ALL
SELECT 
'Total number of orders',
COUNT(DISTINCT order_number)
FROM project.fact_sales
UNION ALL
SELECT 
'Total number of products',
COUNT(product_key)
FROM project.products
UNION ALL
SELECT 
'Total number of customers',
COUNT( customer_key) 
FROM project.customers
UNION ALL
SELECT
'Total number of cutomers who placed an order',
COUNT(DISTINCT customer_key)
FROM project.fact_sales


