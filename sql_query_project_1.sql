SELECT  *
  FROM retailsales;

-- Data Cleaning

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

-- Data Exploration

-- How Many sales we have?

select count (*) as total_sales from retailsales;

-- How Many unique coustomers we have?

select count (Distinct customer_id) as total_Customers from retailsales;

-- How Many category we have?

select Distinct category from retailsales;

-- Data Analysis & Business Key Problems & answers

-- Q1 write a SQL Query to retrieve all columns for sales made on 2022-11-05

select * from retailsales
where sale_date = '2022-11-05';
 

-- Q2 Write a SQL Query to retrieve all transactions where the category is clothing and the quantity sold is more than 4  in the month of nov-2022

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


-- Q3 Write a Sql Query to calculate the total sales (total_sale) for each category.

select category, 
	sum(total_sale) as net_sale,
	COUNT(*) as total_orders
from RetailSales
group by category;

-- Q4 Write a Sql Query to find the average age of customer who purchased items from the 'beauty' category.

SELECT category, 
       AVG(age) AS average_age
FROM RetailSales
WHERE category = 'beauty'
GROUP BY category;


-- Q5 Write	a Sql Query to find all transactions where the total_sales is grater than 1000

select *
from retailsales
where total_sale > 1000;


--Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.

select  category,
	gender,
	count (*) as total_transactions 
from retailsales
group by category, gender;


-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year

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

--order by YEAR, average_sale desc;

-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 

select top 5
	customer_id,
	sum (total_sale) as total_sales
from RetailSales
group by customer_id
order by total_sales desc;


-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.

select category,
	count (distinct customer_id) as unique_customers
from RetailSales
group by category;

-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17.

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