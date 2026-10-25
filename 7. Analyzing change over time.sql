-- Tracking trends, growth, and changes in key metrics over time

-- Analyzing sales performance over time
SELECT 
EXTRACT(YEAR FROM (order_date)) AS order_year,
EXTRACT(MONTH FROM (order_date)) AS order_month,
SUM(sales_amount) AS total_sales,
SUM(quantity) AS total_quantity,
COUNT(DISTINCT customer_key) AS total_customers
FROM project.fact_sales
WHERE order_date IS NOT NULL
GROUP BY EXTRACT(MONTH FROM (order_date)), EXTRACT(YEAR FROM (order_date))
ORDER BY order_year, order_month ASC
