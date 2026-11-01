/*This report consolidates key customer metrics and behaviors by 
gathering core transaction details, segmenting customers and age groups, and tracking metrics such as
total orders, sales, quantity, products, and lifespan. 
Additionally, it calculates key KPIs including recency, average order value, and average monthly spend.*/

WITH base_query AS( 
SELECT 
s.order_number,
s.product_key,
s.order_date,
s.sales_amount,
s.quantity,
c.customer_key,
c.customer_number,
CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
EXTRACT(YEAR FROM AGE(NOW(), c.birthdate)) AS age
FROM project.fact_sales AS s
LEFT JOIN project.customers AS c
ON c.customer_key = s.customer_key
WHERE order_date IS NOT NULL),

customer_aggregation AS(
SELECT 
customer_key,
customer_number,
customer_name,
age,
COUNT(DISTINCT order_number) AS total_orders,
SUM(sales_amount) AS total_sales,
SUM(quantity) AS total_quantity,
COUNT(DISTINCT product_key) AS total_products,
MAX(order_date) AS last_order_date,
EXTRACT(YEAR FROM AGE(MAX(order_date), MIN(order_date))) * 12 +
 EXTRACT(MONTH FROM AGE(MAX(order_date), MIN(order_date))) AS lifespan
FROM base_query
GROUP BY customer_key, customer_number, customer_name, age
)

SELECT 
customer_key,
customer_number,
customer_name,
age,
CASE WHEN age < 20 THEN 'Under 20'
	 WHEN age>=20 AND age<=29 THEN '20-29'
	 WHEN age>=30 AND age<=39 THEN '30-39'
	 WHEN age>=40 AND age<=49 THEN '40-49'
	 ELSE '50 and Above'
END AS age_group,
CASE WHEN lifespan >= 12 AND total_sales > 5000 THEN 'VIP'
	 WHEN lifespan >= 12 AND total_sales <= 5000 THEN 'Regular'
	 ELSE 'New'
END AS customer_segment,
last_order_date,
EXTRACT(YEAR FROM AGE(NOW(),last_order_date)) * 12 +
 EXTRACT(MONTH FROM AGE(NOW(), last_order_date)) AS recency,
total_orders,
total_sales,
total_quantity,
total_products,
lifespan,
CASE WHEN total_orders = 0 THEN 0
	 ELSE ROUND(total_sales::NUMERIC/total_orders, 2)
END AS avg_order_value,
CASE WHEN lifespan = 0 THEN total_sales
	 ELSE ROUND(total_sales/lifespan, 2)
END AS avg_monthly_spend
FROM customer_aggregation

