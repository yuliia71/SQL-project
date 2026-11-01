--Analyzing the yearly performance of products by comparing their sales to both the average sales performance of the product and the previous year's sales

WITH CTE_table AS
(SELECT
EXTRACT(YEAR FROM s.order_date) AS order_year,
p.product_name,
SUM(s.sales_amount) as current_sales
FROM project.fact_sales AS s
LEFT JOIN
project.products AS p
ON s.product_key = p.product_key
WHERE EXTRACT(YEAR FROM order_date) IS NOT NULL
GROUP BY EXTRACT(YEAR FROM order_date), p.product_name
)

SELECT 
order_year,
product_name,
current_sales,
AVG(current_sales) OVER (PARTITION BY product_name)::INTEGER AS avg_sales,
current_sales - AVG(current_sales) OVER (PARTITION BY product_name)::INTEGER AS diff_avg,
CASE WHEN current_sales - AVG(current_sales) OVER (PARTITION BY product_name)::INTEGER > 0 THEN 'Above Average'
	 WHEN current_sales - AVG(current_sales) OVER (PARTITION BY product_name)::INTEGER < 0 THEN 'Below Average'
	 ELSE 'Average'
END AS avg_change,
LAG(current_sales) OVER (PARTITION BY product_name ORDER BY order_year ASC) AS previous_year_sales,
current_sales - LAG(current_sales) OVER (PARTITION BY product_name ORDER BY order_year ASC) AS diff_previous_year,
CASE WHEN current_sales - LAG(current_sales) OVER (PARTITION BY product_name ORDER BY order_year ASC) > 0 THEN 'Inscreasing'
	 WHEN current_sales - LAG(current_sales) OVER (PARTITION BY product_name ORDER BY order_year ASC) < 0 THEN 'Decreasing'
	 ELSE 'No Change'
END AS previous_year_change
FROM CTE_table
