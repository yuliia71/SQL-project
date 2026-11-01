--Tracking performance over time cumulatively

--Calculating the total sales per month, running total of sales and moving average of price over time  
SELECT 
order_month,
total_sales,
SUM(total_sales) OVER (PARTITION BY DATE_TRUNC('year', order_month) ORDER BY order_month ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS running_total_sales,
avg_price,
ROUND(AVG(avg_price) OVER (PARTITION BY DATE_TRUNC('year', order_month) ORDER BY order_month ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW),2) AS running_average_price
FROM(
SELECT
DATE_TRUNC('month', order_date)::date AS order_month,
SUM(sales_amount) AS total_sales,
AVG(price) AS avg_price
FROM project.fact_sales
WHERE order_date IS NOT NULL
GROUP BY DATE_TRUNC('month', order_date)
ORDER BY DATE_TRUNC('month', order_date))t

