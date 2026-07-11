SELECT COUNT(*)
FROM Retailsales.retail_sales;

SELECT *
FROM Retailsales.retail_sales;

-- Data cleaning
-- checking null value
SELECT *
FROM Retailsales.retail_sales
WHERE
   sale_date IS NULL
   OR sale_time IS NULL
   OR customer_id IS NULL
   OR gender IS NULL
   OR age IS NULL
   OR category IS NULL
   OR quantity IS NULL
   OR price_per_unit IS NULL
   OR cogs IS NULL
   OR total_sale IS NULL;

-- Delete null values
DELETE
FROM Retailsales.retail_sales
WHERE
   sale_date IS NULL
   OR sale_time IS NULL
   OR customer_id IS NULL
   OR gender IS NULL
   OR age IS NULL
   OR category IS NULL
   OR quantity IS NULL
   OR price_per_unit IS NULL
   OR cogs IS NULL
   OR total_sale IS NULL;

-- Data exploration
-- how many sales we have?
SELECT
    COUNT(*) AS total_sales_num
FROM Retailsales.retail_sales;

-- how many unique customers we have?
SELECT
    COUNT(DISTINCT customer_id) AS unique_customer
FROM Retailsales.retail_sales;

-- how many unique category we have?
SELECT DISTINCT
    category
FROM Retailsales.retail_sales;

-- Data analysis & business key problems & answers
-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05'
SELECT *
FROM Retailsales.retail_sales
WHERE sale_date = '2022-11-05';

-- Q.2 What is the maximum quantity sold in each category, and in which months did it occur?
SELECT
    rs.category,
    rs.quantity AS max_quantity,
    DATE_FORMAT(rs.sale_date, '%Y-%m') AS sale_month
FROM Retailsales.retail_sales AS rs
    JOIN (
    -- maximum quantity sold of each category
    SELECT category,
        MAX(quantity) AS max_quantity
    FROM Retailsales.retail_sales
    GROUP BY category) AS m
ON rs.category = m.category
AND rs.quantity = m.max_quantity
ORDER BY rs.category, sale_month DESC;

-- Q.3 Write a SQL query to retrieve all transactions where the category is 'Clothing'
--      and the quantity sold is more than 4 in the month of Nov-2022
SELECT *
FROM Retailsales.retail_sales
WHERE category = 'Clothing'
  AND quantity >= 4
  AND DATE_FORMAT(sale_date, '%Y-%m') = '2022-11';

-- Q.4 Write a SQL query to calculate the total sales (total_sale),total orders, total quantity for each category.
SELECT
   category,
   SUM(total_sale) AS total_sales,
   COUNT(*)        AS total_orders,
   SUM(quantity)   AS total_quantity
FROM Retailsales.retail_sales
GROUP BY category;

-- Q.5 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
SELECT
    category,
    ROUND(AVG(age), 2) AS avg_age
FROM Retailsales.retail_sales
WHERE category = 'Beauty';

-- Q.6 Write a SQL query to find all transactions where the total_sale is greater than 1000.
SELECT *
FROM Retailsales.retail_sales
WHERE total_sale > 1000;

-- Q.7 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
SELECT
   category,
   gender,
   COUNT(*) AS total_transactions
FROM Retailsales.retail_sales
GROUP BY category, gender
ORDER BY category;

-- Q.8 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
SELECT
    year,
    month,
    avg_sale,
    sale_rank
FROM (
    SELECT
        EXTRACT(YEAR FROM sale_date)                                                                    AS year,
        EXTRACT(MONTH FROM sale_date)                                                                   AS month,
        ROUND(AVG(total_sale), 2)                                                                       AS avg_sale,
        RANK() OVER (PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY ROUND(AVG(total_sale), 2) DESC) AS sale_rank
    FROM Retailsales.retail_sales
    GROUP BY year, month) AS t1
WHERE sale_rank = 1;

-- Q.9 **Write a SQL query to find the top 5 customers based on the highest total sales **
SELECT
    customer_id,
    SUM(total_sale) AS total_sales
FROM Retailsales.retail_sales
GROUP BY customer_id
ORDER BY total_sales DESC
LIMIT 5;

-- Q.10 Write a SQL query to find the number of unique customers who purchased items from each category.
SELECT
    category,
    COUNT(DISTINCT customer_id) AS unique_customer
FROM Retailsales.retail_sales
GROUP BY category;

-- Q.11 Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)
WITH hourly_sale AS (
    SELECT
    *,
    CASE
        WHEN extract(HOUR FROM sale_time) < 12 THEN 'Morning'
        WHEN extract(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END AS shift
    FROM Retailsales.retail_sales)
SELECT
    shift,
    COUNT(*) AS total_orders
FROM hourly_sale
GROUP BY shift;

-- Q.12 For each category, find the maximum quantity sold, and if that maximum occurred multiple times,
-- return the latest (most recent) occurrence.
WITH latest_transaction AS (
    SELECT
        category,
        quantity,
        sale_date,
        ROW_NUMBER () OVER (PARTITION BY category ORDER BY quantity DESC, sale_date DESC ) AS latest_trans
    FROM Retailsales.retail_sales )
SELECT
    category,
    quantity AS max_quantity,
    DATE_FORMAT(sale_date, '%Y-%m') AS sale_month
FROM latest_transaction
WHERE latest_trans = 1;

-- Without CTE
SELECT
    category,
    quantity AS max_quantity,
    DATE_FORMAT(sale_date, '%Y-%m') AS sale_month
FROM (
    SELECT
        category,
        quantity,
        sale_date,
        ROW_NUMBER() OVER (PARTITION BY category ORDER BY quantity DESC, sale_date DESC ) AS latest_trans
    FROM Retailsales.retail_sales) AS latest_transaction
WHERE latest_trans = 1;

-- Q.13 Which month had the highest total quantity sold for each category?
WITH monthly_sales AS (
     SELECT
         category,
         DATE_FORMAT(sale_date, '%Y-%m') AS sale_month,
         SUM(quantity) AS total_quantity
     FROM Retailsales.retail_sales
     GROUP BY category, sale_month
     ORDER BY category, sale_month DESC),
     ranked_sales AS (
       SELECT *,
           ROW_NUMBER () OVER (PARTITION BY category ORDER BY total_quantity DESC) AS rn
       FROM monthly_sales
       )
SELECT
    category,
    sale_month,
    total_quantity
FROM ranked_sales
WHERE rn = 1;

-- Q.14 Find total number of male and female customers in each category.
SELECT
    category,
    SUM(gender = 'Male')   AS male_customers,
    SUM(gender = 'Female') AS female_customers
FROM Retailsales.retail_sales
GROUP BY category;

-- Q.15 Calculate total sales, total COGS, and gross profit for each category.
SELECT
   category,
   SUM(total_sale)  AS total_sales,
   ROUND(SUM(cogs), 2) AS total_cogs,
   ROUND(SUM(total_sale - cogs ), 2) AS gross_profit
FROM Retailsales.retail_sales
GROUP BY category;

-- Q16. Find the category with the highest gross profit margin.
SELECT
    category,
    ROUND(SUM(total_sale-cogs), 2) AS gross_profit,
    CONCAT(ROUND(SUM(total_sale - cogs) / SUM(total_sale) * 100 , 2),'%') AS profit_margin
FROM Retailsales.retail_sales
GROUP BY category;
--  END OF PROJECT
