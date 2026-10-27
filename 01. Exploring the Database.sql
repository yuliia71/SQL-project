-- Exploring all tables in the 'project' schema
SELECT *
FROM information_schema.tables 
WHERE table_schema = 'project';

-- Exploring columns in the tables and their additional information
SELECT
table_name,
column_name,
data_type,
is_nullable
FROM information_schema.columns 
WHERE table_name = 'customers'

SELECT 
table_name,
column_name,
data_type,
is_nullable
FROM information_schema.columns 
WHERE table_name = 'products'

SELECT
table_name,
column_name,
data_type,
is_nullable
FROM information_schema.columns 
WHERE table_name = 'fact_sales'

