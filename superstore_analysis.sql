-- ================================================
-- Superstore Sales Analysis — SQL Queries
-- Author: Pardis Hosseinpouraghdam
-- GitHub: github.com/pardisHpa
-- Dataset: Superstore Sales (2015-2018)
-- Tool: SQLite Online
-- ================================================


-- ------------------------------------------------
-- Query 1: Preview the Data
-- ------------------------------------------------

SELECT * FROM traincsv LIMIT 5 ;
ALTER TABLE traincsv RENAME TO SuperStoreTbl;
SELECT * from SuperStoreTbl limit 2;
SELECT * FROM SuperStoreTbl WHERE SuperStoreTbl.city is 'Henderson';

--Q2 This query shows the size and scope of the dataset
SELECT 
    COUNT(*) AS total_orders ,
     COUNT(DISTINCT S.customer_id) AS unique_customers,
     COUNT(DISTINCT S.product_id ) AS unique_products,
     COUNT(DISTINCT S.region) AS total_region
FROM SuperStoreTbl S ;


-- Q3: Which region generates the most sales?
SELECT S.region , Round(SUM(S.sales) ) As total_sales , COUNT(*) AS total_orders,
Round(AVG(S.sales)) AS avg_order_value
from SuperStoreTbl S 
GROUP by S.region
Order BY  total_sales DESC;


-- Query 4: Which product category generates the most sales?
SELECT S.category ,  Round(Sum(S.sales)) as total_sales , 
COUNT(*) As total_orders , Round(Avg (S.sales)) as avg_order_value
from SuperStoreTbl S 
GROUP BY S.category ORDER by total_sales DESC ;


-- Query 5: Which products generate the most sales?
SELECT S.product_id , S.category , S.sub_category , S.product_name , Round(Sum(S.sales)) as
total_sales  , COUNT(*) As total_orders 
FROM SuperStoreTbl S 
GROUP BY S.product_name, S.category, S.sub_category
ORDER by total_sales DESC 
limit 10;

-- Query 6: How have sales grown year over year?
SELECT 
    SUBSTR(S.order_date, 7, 4) AS order_year,
    ROUND(SUM(S.sales), 2) AS total_sales,
    COUNT(*) AS total_orders,
    ROUND(AVG(S.sales), 2) AS avg_order_value
FROM SuperStoreTbl S
GROUP BY order_year
ORDER BY order_year ASC;


-- Query 7: Which customer segment generates the most sales?
SELECT 
    S.segment,
    ROUND(SUM(S.sales), 2) AS total_sales,
    COUNT(*) AS total_orders,
    ROUND(AVG(S.sales), 2) AS avg_order_value,
    COUNT(DISTINCT S.customer_id) AS unique_customers
FROM SuperStoreTbl S
GROUP BY S.segment
ORDER BY total_sales DESC;


-- Query 8: Who are our most valuable customers?
SELECT 
    S.customer_name,
    S.segment,
    S.region,
    ROUND(SUM(S.sales), 2) AS total_sales,
    COUNT(*) AS total_orders
FROM SuperStoreTbl S
GROUP BY S.customer_id, S.customer_name, S.segment, S.region
ORDER BY total_sales DESC
LIMIT 10;


-- Query 9: Which shipping method do customers prefer?
SELECT 
    S.ship_mode,
    ROUND(SUM(S.sales), 2) AS total_sales,
    COUNT(*) AS total_orders,
    ROUND(AVG(S.sales), 2) AS avg_order_value,
    COUNT(DISTINCT S.customer_id) AS unique_customers
FROM SuperStoreTbl S
GROUP BY S.ship_mode
ORDER BY total_sales DESC;


-- Query 10: Which months generate the most sales?
SELECT 
    SUBSTR(S.order_date, 4, 2) AS order_month,
    ROUND(SUM(S.sales), 2) AS total_sales,
    COUNT(*) AS total_orders,
    ROUND(AVG(S.sales), 2) AS avg_order_value
FROM SuperStoreTbl S
GROUP BY order_month
ORDER BY total_sales DESC;