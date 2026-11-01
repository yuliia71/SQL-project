/*This report consolidates key product performance metrics and attributes. 
It segments items by revenue, aggregates order, sales, customer, and lifespan totals. 
Additionally, it calculates key KPIs including recency, average order revenue, and monthly revenue.*/

WITH base_query AS (
SELECT
s.order_number,
s.order_date,
s.customer_key,
s.sales_amount,
s.quantity,
p.product_key,
p.product_name,
p.category,
p.subcategory,
p.cost
FROM project.fact_sales AS s
LEFT JOIN project.products AS p
ON s.product_key = p.product_key
WHERE order_date IS NOT NULL
),

product_aggregation AS (
SELECT
product_key,
product_name,
category,
subcategory,
cost,
EXTRACT(YEAR FROM AGE(MAX(order_date), MIN(order_date))) * 12 +
 EXTRACT(MONTH FROM AGE(MAX(order_date), MIN(order_date))) AS lifespan,
MAX(order_date) AS last_sale_date,
COUNT(DISTINCT order_number) AS total_orders,
COUNT(DISTINCT customer_key) AS total_customers,
SUM(sales_amount) AS total_sales,
SUM(quantity) AS total_quantity,
ROUND(AVG(sales_amount::NUMERIC / NULLIF(quantity, 0)),2) AS avg_selling_price
FROM base_query
GROUP BY
product_key,
product_name,
category,
subcategory,
cost
)

SELECT 
product_key,
product_name,
category,
subcategory,
cost,
last_sale_date,
EXTRACT(YEAR FROM AGE(NOW(),last_sale_date)) * 12 +
 EXTRACT(MONTH FROM AGE(NOW(), last_sale_date)) AS recency,
CASE WHEN total_sales > 50000 THEN 'High-Performer'
	 WHEN total_sales >= 10000 THEN 'Mid-Range'
	 ELSE 'Low-Performer'
END AS product_segment,
lifespan,
total_orders,
total_sales,
total_quantity,
total_customers,
avg_selling_price,
CASE WHEN total_orders = 0 THEN 0
	 ELSE ROUND(total_sales::NUMERIC / total_orders,2)
END AS avg_order_revenue,
CASE WHEN lifespan = 0 THEN total_sales
	 ELSE ROUND(total_sales / lifespan, 2)
END AS avg_monthly_revenue
FROM product_aggregation