--Grouping data into meaningful categories for targeted insights

--Grouping products based on their cost
WITH product_segments AS (
SELECT
product_key,
product_name,
cost,
CASE WHEN cost < 100 THEN 'Below 100'
	 WHEN cost BETWEEN 100 AND 500 THEN '100-500'
	 WHEN cost BETWEEN 500 AND 1000 THEN '500-1000'
	 ELSE 'Above 1000'
END AS cost_range
FROM project.products
)
SELECT 
cost_range,
COUNT(product_key) AS total_products
FROM product_segments
GROUP BY cost_range
ORDER BY total_products DESC;

-- Grouping customers based on customer lifespan and total spending
WITH customer_spending AS(
SELECT 
c.customer_key,
SUM(s.sales_amount) AS total_spending,
MIN(s.order_date) AS first_order,
MAX(s.order_date) AS last_order,
(EXTRACT(YEAR FROM AGE(MAX(s.order_date), MIN(s.order_date))) * 12) +
 EXTRACT(MONTH FROM AGE(MAX(s.order_date), MIN(s.order_date))) AS month_diff
FROM project.fact_sales AS s
LEFT JOIN project.customers AS c
ON c.customer_key = s.customer_key
GROUP BY c.customer_key)

SELECT
customer_segment,
COUNT(customer_key)
FROM(
SELECT
customer_key,
CASE WHEN month_diff >= 12 AND total_spending > 5000 THEN 'VIP'
	 WHEN month_diff >= 12 AND total_spending <= 5000 THEN 'Regular'
	 ELSE 'New'
END AS customer_segment
FROM customer_spending) AS t
GROUP BY customer_segment

