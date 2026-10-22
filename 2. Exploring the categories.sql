-- Identifying unique categories that might be useful in the later analysis

SELECT 
country,
COUNT(*) AS customer_count
FROM project.dim_customers
GROUP BY country

SELECT gender, marital_status, 
COUNT(*) AS customer_count
FROM project.dim_customers
GROUP BY gender, marital_status
ORDER BY customer_count DESC;

SELECT DISTINCT 
category, 
subcategory
FROM project.dim_products
ORDER BY category, subcategory


