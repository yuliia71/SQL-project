# 📊 SQL Sales Data Analytics

Exploratory and advanced sales analytics in **PostgreSQL**: from exploring a star-schema database to reusable customer and product reports.



## 1. Project Introduction

This project answers common business questions with pure SQL: who our customers are, which products and categories drive revenue, how sales change over time, and how to segment customers and products.

## 2. Project Overview and Features

**Data model** (schema `project`): `fact_sales`, `customers`, `products`.

| Files | Topic |
|---|---|
| 1–3 | Database, category and date-boundary exploration |
| 4–5 | Magnitude analysis (measures by category) |
| 6 | Ranking: top/bottom N products, subcategories, customers |
| 7–8 | Change over time, running totals and averages |
| 9 | Year-over-year and vs-average product performance |
| 10–11 | Part-to-whole analysis and segmentation |
| 12 | Customers report (VIP / Regular / New, age groups, recency, AOV, monthly spend) |
| 13 | Products report (High / Mid / Low performer, recency, avg. price, monthly revenue) |

## 3. Tech Stack, APIs, and Other Resources

- PostgreSQL, SQL (joins, CTEs, window functions, `CASE`, date functions)
- Any SQL client: pgAdmin, DBeaver, or `psql`
- No external APIs

## 4. Getting Started: Setup and Running Instructions
 
```bash
git clone https://github.com/yuliia71/SQL-project.git
psql -d sales_analytics -c "CREATE SCHEMA project;"
```
 
1. Load `fact_sales`, `customers`, `products` into the `project` schema.
2. Run the scripts in numerical order, e.g. `psql -d sales_analytics -f "1. Exploring the Database.sql"`.

