# Retail Sales Analysis SQL Project

## Project Overview

**Project Title**: Retail Sales Analysis  
**Level**: Beginner  
**Database**: `Sql_project_1`

This project is designed to demonstrate SQL skills and techniques typically used by data analysts to explore, clean, and analyze retail sales data. The project involves setting up a retail sales database, performing exploratory data analysis (EDA), and answering specific business questions through SQL queries.

## Objectives

1. **Set up a retail sales database**: Create and populate a retail sales database with the provided sales data.
2. **Data Cleaning**: Identify and remove any records with missing or null values.
3. **Exploratory Data Analysis (EDA)**: Perform basic exploratory data analysis to understand the dataset.
4. **Business Analysis**: Use SQL to answer specific business questions and derive insights from the sales data.

## Project Structure

### 1. Database Setup

- **Database Creation**: The project starts by creating a database named `Sql_project_1`.


### 2. Data Exploration & Cleaning

- **Record Count**: Determine the total number of records in the dataset.
- **Customer Count**: Find out how many unique customers are in the dataset.
- **Category Count**: Identify all unique product categories in the dataset.
- **Null Value Check**: Check for any null values in the dataset and delete records with missing data.

```sql
select * from RetailSales
where age is Null 
	or
	category is null
	or
	quantiy is null
	or
	price_per_unit is null
	or
	cogs is null
	or
	total_sale is null;

Delete from retailsales
where age is Null 
	or
	category is null
	or
	quantiy is null
	or
	price_per_unit is null
	or
	cogs is null
	or
	total_sale is null;
```

### 3. Data Analysis & Findings

The following SQL queries were developed to answer specific business questions:

1. **Write a SQL query to retrieve all columns for sales made on '2022-11-05**:
```sql
select * from retailsales
where sale_date = '2022-11-05';
```

2. **Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022**:
```sql
SELECT * 
FROM RetailSales
WHERE 
    category = 'clothing'
    AND 
    sale_date >= '2022-11-01' 
    AND 
    sale_date < '2022-12-01'
    AND 
    quantiy >= 4;
```

3. **Write a SQL query to calculate the total sales (total_sale) for each category.**:
```sql
select category, 
	sum(total_sale) as net_sale,
	COUNT(*) as total_orders
from RetailSales
group by category;
```

4. **Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.**:
```sql
SELECT category, 
       AVG(age) AS average_age
FROM RetailSales
WHERE category = 'beauty'
GROUP BY category;

```

5. **Write a SQL query to find all transactions where the total_sale is greater than 1000.**:
```sql
select *
from retailsales
where total_sale > 1000;
```

6. **Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.**:
```sql
select  category,
	gender,
	count (*) as total_transactions 
from retailsales
group by category, gender;
```

7. **Write a SQL query to calculate the average sale for each month. Find out best selling month in each year**:
```sql
select YEAR, MONTH, average_sale
from	
	(
	select YEAR (sale_date) as year,
		MONTH (sale_date) as month,
		Avg (total_sale) as average_sale,
		RANK () over (partition by YEAR (sale_date) order by Avg (total_sale) Desc) as rank
	from RetailSales
	group by sale_date
	) as t1
where rank = 1;
```

8. **Write a SQL query to find the top 5 customers based on the highest total sales **:
```sql
select top 5
	customer_id,
	sum (total_sale) as total_sales
from RetailSales
group by customer_id
order by total_sales desc;
```

9. **Write a SQL query to find the number of unique customers who purchased items from each category.**:
```sql
select category,
	count (distinct customer_id) as unique_customers
from RetailSales
group by category;
```

10. **Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)**:
```sql
with hourly_sale
as
(
select *,
	case
		when DATEPART (hour, sale_time) < 12 then 'morning'
		when DATEPART (hour, sale_time) between 12 and 17 then 'afternoon'
		else 'evening'
	end as shift
from retailsales
) 
select shift,
	count (*) as total_sales
from hourly_sale
group by shift;
```

## Findings

- **Customer Demographics**: The dataset includes customers from various age groups, with sales distributed across different categories such as Clothing and Beauty.
- **High-Value Transactions**: Several transactions had a total sale amount greater than 1000, indicating premium purchases.
- **Sales Trends**: Monthly analysis shows variations in sales, helping identify peak seasons.
- **Customer Insights**: The analysis identifies the top-spending customers and the most popular product categories.

## Reports

- **Sales Summary**: A detailed report summarizing total sales, customer demographics, and category performance.
- **Trend Analysis**: Insights into sales trends across different months and shifts.
- **Customer Insights**: Reports on top customers and unique customer counts per category.

## Conclusion

This project serves as a comprehensive introduction to SQL for data analysts, covering database setup, data cleaning, exploratory data analysis, and business-driven SQL queries. The findings from this project can help drive business decisions by understanding sales patterns, customer behavior, and product performance.

## How to Use

1. **Clone the Repository**: Clone this project repository from GitHub.
2. **Set Up the Database**: Run the SQL scripts provided in the `database_setup.sql` file to create and populate the database.
3. **Run the Queries**: Use the SQL queries provided in the `analysis_queries.sql` file to perform your analysis.
4. **Explore and Modify**: Feel free to modify the queries to explore different aspects of the dataset or answer additional business questions.

## Author - Bhanu_Prakash_Murali
This project is part of my portfolio, showcasing the SQL skills essential for data analyst roles. If you have any questions, feedback, or would like to collaborate, feel free to get in touch!

### Stay Updated and Join the Community

For more content on SQL, data analysis, and other data-related topics, make sure to follow me on social media and join our community:


- **LinkedIn**: www.linkedin.com/in/bhanuprakashmurali2212


Thank you for your support, and I look forward to connecting with you!
