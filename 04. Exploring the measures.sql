-- Calculating aggregated metrics. Identifying trends and spotting anomalies.

-- Finding the Total Sales
SELECT 
SUM(sales_amount) AS total_sales
FROM project.fact_sales

-- Finding how many items are sold
SELECT 
SUM(quantity) AS total_quantity
FROM project.fact_sales

-- Find the average selling price
SELECT
AVG(price) AS avg_price
FROM project.fact_sales

-- Finding the Total number of Orders
SELECT 
COUNT(DISTINCT order_number) AS total_orders
FROM project.fact_sales

-- Finding the total number of products
SELECT 
COUNT(product_key) AS total_products
FROM project.products

-- Finding the total number of customers
SELECT 
COUNT( customer_key) AS total_customers
FROM project.customers

-- Finding the total number of customers that has placed an order
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


