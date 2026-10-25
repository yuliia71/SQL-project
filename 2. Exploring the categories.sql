-- Identifying unique categories that might be useful in the later analysis

-- Retrieving a list of unique countries from which customers originate
SELECT 
country,
COUNT(*) AS customer_count
FROM project.customers
GROUP BY country

-- Analyzing customer demographics by gender and marital status
SELECT gender, marital_status, 
COUNT(*) AS customer_count
FROM project.customers
GROUP BY gender, marital_status
ORDER BY customer_count DESC;

-- Retrieving a list of unique categories, subcategories, and products
SELECT DISTINCT 
category, 
subcategory
FROM project.products
ORDER BY category, subcategory
