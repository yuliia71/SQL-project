-- Ranking items based on performance or other metrics. Identifying top N and bottom N performers

-- Finding the top 5 products that generate the highest revenue
SELECT
p.product_name,
SUM(s.sales_amount) AS total_revenue,
ROW_NUMBER() OVER (ORDER BY SUM(s.sales_amount) DESC) AS rank_products
FROM project.fact_sales AS s
LEFT JOIN project.products as p
ON s.product_key = p.product_key
GROUP BY product_name
LIMIT 5

-- Finding the 5 worst-performing products in terms of sales
SELECT
p.product_name,
SUM(s.sales_amount) AS total_revenue,
ROW_NUMBER() OVER (ORDER BY SUM(s.sales_amount) ASC) AS rank_products
FROM project.fact_sales AS s
LEFT JOIN project.products as p
ON s.product_key = p.product_key
GROUP BY product_name
LIMIT 5

-- Finding the top 5 subcategories that generate the highest revenue
SELECT
p.subcategory,
SUM(s.sales_amount) AS total_revenue,
ROW_NUMBER() OVER (ORDER BY SUM(s.sales_amount) DESC) AS rank_subcategories
FROM project.fact_sales AS s
LEFT JOIN project.products as p
ON s.product_key = p.product_key
GROUP BY subcategory
LIMIT 5

-- Finding the 5 worst-performing subcategories in terms of sales
SELECT
p.subcategory,
SUM(s.sales_amount) AS total_revenue,
ROW_NUMBER() OVER (ORDER BY SUM(s.sales_amount) ASC) AS rank_subcategories
FROM project.fact_sales AS s
LEFT JOIN project.products as p
ON s.product_key = p.product_key
GROUP BY subcategory
LIMIT 5

-- Finding the top 5 customers who have generated the highest revenue
SELECT
c.customer_key,
c.first_name,
c.last_name,
SUM(s.sales_amount) AS total_revenue,
ROW_NUMBER() OVER (ORDER BY SUM(s.sales_amount) DESC) AS rank_customers
FROM project.fact_sales AS s
LEFT JOIN
project.customers AS c
ON s.customer_key = c.customer_key
GROUP BY c.customer_key, c.first_name, c.last_name
ORDER BY total_revenue DESC
LIMIT 5

