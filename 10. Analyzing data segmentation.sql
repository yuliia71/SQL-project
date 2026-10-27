-- Analyzing contribution of sales by categories
WITH category_sales AS(
SELECT
p.category,
SUM(s.sales_amount) AS total_sales
FROM project.fact_sales AS s
LEFT JOIN project.products AS p
ON p.product_key = s.product_key
GROUP BY p.category)

SELECT
category,
total_sales,
SUM(total_sales) OVER() AS overall_sales,
CONCAT(ROUND(total_sales::NUMERIC/ SUM(total_sales) OVER() * 100,2), '%') AS percentage_of_total
FROM category_sales
ORDER BY total_sales DESC

-- Analyzing contribution of orders by categories
WITH category_orders AS(
SELECT
p.category,
COUNT(DISTINCT s.order_number) AS total_orders
FROM project.fact_sales AS s
LEFT JOIN project.products AS p
ON p.product_key = s.product_key
GROUP BY p.category)

SELECT
category,
total_orders,
SUM(total_orders) OVER() AS overall_orders,
CONCAT(ROUND(total_orders::NUMERIC/ SUM(total_orders) OVER() * 100,2), '%') AS percentage_of_total
FROM category_orders
ORDER BY total_orders DESC
