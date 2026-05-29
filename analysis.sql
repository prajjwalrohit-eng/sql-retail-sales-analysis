-- Retail Sales Data Analysis Project
-- Author: Rohit
-- Tools Used: MySQL
-- Dataset: Kaggle Retail Store Sales Dirty Data
-- Create Database

CREATE DATABASE kaggle_db;
USE kaggle_db;

SELECT * FROM retail_store_sales_3 LIMIT 10;

-- 1. Identify duplicate transactions
SELECT `Transaction ID`, COUNT(*) AS duplicate_count
FROM retail_store_sales_3
GROUP BY `Transaction ID`
HAVING COUNT(*) > 1;

-- 2. Detect incorrect entries (zero or negative values)
SELECT *
FROM retail_store_sales_3
WHERE `Total Spent` <= 0 OR `Quantity` <= 0;

-- 3. Check missing values
SELECT *
FROM retail_store_sales_3
WHERE `Customer ID` IS NULL
   OR `Category` IS NULL;

-- 4. Total sales by category (Top 5)
SELECT `Category`,
       SUM(`Total Spent`) AS total_sales
FROM retail_store_sales_3
GROUP BY `Category`
ORDER BY total_sales DESC
LIMIT 5;

-- 5. Top 5 revenue-generating products
SELECT `Item`,
       SUM(`Total Spent`) AS revenue
FROM retail_store_sales_3
GROUP BY `Item`
ORDER BY revenue DESC
LIMIT 5;

-- 6. Categories performing above average
SELECT `Category`,
       SUM(`Total Spent`) AS total_sales
FROM retail_store_sales_3
GROUP BY `Category`
HAVING SUM(`Total Spent`) > (
    SELECT AVG(total_sales)
    FROM (
        SELECT SUM(`Total Spent`) AS total_sales
        FROM retail_store_sales_3
        GROUP BY `Category`
    ) t
);

-- 7. Monthly sales trend
SELECT MONTH(`Transaction Date`) AS month,
       SUM(`Total Spent`) AS revenue
FROM retail_store_sales_3
GROUP BY month
ORDER BY month;

-- 8. Top spending customers
SELECT `Customer ID`,
       SUM(`Total Spent`) AS spending
FROM retail_store_sales_3
GROUP BY `Customer ID`
ORDER BY spending DESC
LIMIT 5;

-- 9. Payment method analysis
SELECT `Payment Method`,
       SUM(`Total Spent`) AS total_sales
FROM retail_store_sales_3
GROUP BY `Payment Method`
ORDER BY total_sales DESC;