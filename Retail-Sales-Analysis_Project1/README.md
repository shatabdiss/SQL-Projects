# 🛍️ Retail Sales Analysis Using MySQL

## 📌 Project Overview
This projects analzes a retai sales dataset using MySQL. The objective is to perform data cleaning, data exploration and business analysis by writting SQL queries that answer common business questions.

The projet transforms raw transactional data into meaningful business insights using aggregate functions, joins, common table expressions(CTEs), subqueries, window functions, and date/time functions.

## 🛠️ Tools Used
- MySQL
- DataGrip
- SQL

## 📂 Dataset
This dataset contains retail transation records with the following attributes:
- transaction_id
- sale_date
- sale_time
- customer_id
- age
- category
- quantity
- price_per_unit
- cogs
- total_sale

## 🔄 Project Workflow
### 1. Data Cleaning
- Checked for missing(NULL) values
- Removed incomplete records before analysis

### 2. Data Exploration
Performed exploratory analysis by calculating:
- Total number of sales
- Number of unique customers
- Available product categories

## 📊 Business Questions Solved
1. Retrieve all sales made on a specific date.
2. Find the maximum quantity sold in each category and the month when it occurred.
3. Retrieve Clothing transactions with quantity greater than or equal to 4 during November 2022.
4. Calculate total sales, total orders, and total quantity sold for each category.
5. Calculate the average customer age for each product purchases.
6. Find all transactions with sales greater than 1000.
7. Count transactions by gender within each product category.
8. Determine the best-selling month of each year based on average sales.
9. Identify the top five customers based on total sales.
10. Count unique customers for each product category.
11. Classify transactions into Morning, Afternoon, and Evening shifts and calculate the number of 12. orders for each shift.
12. Return the latest occurrence when the maximum quantity was sold within each category.
13. Determine the month with the highest total quantity sold for each category.
14. Count male and female customers within each product category.
15. Calculate total sales, total COGS, and gross profit for each category.
16. Calculate the gross profit margin for each product category.

## 💡 SQL Concepts Demonstrated
- Data Cleaning
- Filtering (WHERE)
- Sorting (ORDER BY)
- Aggregation (SUM, COUNT, AVG, MAX)
- GROUP BY
- DISTINCT
- Date Functions (DATE_FORMAT, EXTRACT)
- Conditional Logic (CASE)
- Conditional Aggregation
- Joins
- Subqueries
- Common Table Expressions (CTEs)
- Window Functions (ROW_NUMBER, RANK)
- Profitability Analysis

## 📈 Key Findings
Based on the analysis of the dataset, the following business insights were identified:
- Profitability Analysis: Clothing generated the highest gross profit, while Beauty achieved the highest gross profit margin (79.71%), making it the most profitable category relative to sales.
- Peak Sales Periods: The highest quantity sold occurred in October 2022 for Beauty, November 2022 for Clothing, and December 2023 for Electronics, revealing different peak sales months across product categories.
- Customer Shopping Behavior: The Evening shift recorded the highest number of transactions (1,062), indicating that customers preferred shopping later in the day.
- Sales Trends: July 2022 and February 2023 were the best-performing months in their respective years based on average sales, highlighting periods of stronger sales performance.
- Customer Demographics: Male and female customer participation was relatively balanced across all product categories, with only minor differences between genders.

## ✅ Conclusion
This project demonstrates cleanig, exploration and analysis of data to answer practical business questions. By applying aggregate functions, joins, subqueries, CTEs, and window functions, the analysis uncovered some business insights such as sales performance, customer behavior, profitability, and purchasing trends. Overall, the project helps to find some meaningful business insights from the transformation of raw transactional data using SQL that support data-driven decision-making.

## 🚀 How to Run the Project
1. Clone this repository.
2. Create a MySQL database.
3. Import the dataset into the retail_sales table.
4. Execute the SQL script (retail_sales.sql) using MySQL or DataGrip.
5. Review the query results.

## 🎯 Learning Outcomes
Through this project, I gained practical experience in:
- Writing clean and optimized SQL queries.
- Performing data cleaning before analysis.
- Solving business problems using SQL.
- Using aggregate and date functions for reporting.
- Applying joins, subqueries, and Common Table Expressions (CTEs).
- Using window functions to rank and analyze data.
- Performing sales, customer, and profitability analysis.

## 👤 Author
Shatabdi Sarker

Bachelor of Science in Computer Science & Engineering

Interested in Data Analytics, Data Science, Machine Learning, and Business Intelligence.
