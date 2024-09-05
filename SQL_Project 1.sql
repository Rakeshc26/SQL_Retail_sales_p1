-- 1.Write a SQL query to retrieve all columns for sales made on '2022-11-05'

select * from retail_sales
where sale_date = "2022-11-05";

-- 2.Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 3 in the month of Nov-2022

select * from retail_sales
where category = 'clothing'
and quantiy >= 4 
and sale_date between '2022-11-01' and '2022-11-30';

-- 3.Write a SQL query to calculate the total sales (total_sale) for each category.

select category, sum(total_sale) as total_sale from retail_sales
group by 1;

-- 4.Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category

select round(avg(age),2) from retail_sales
where category = 'beauty';

-- 5.Write a SQL query to find all transactions where the total_sale is greater than 1000.

select * from retail_sales
where total_sale > 1000;

-- 6.Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category

select category, gender, count(*) as no_of_transcations
from retail_sales
group by 1, 2
order by 1;

-- 7.Write a SQL query to calculate the average sale for each month. Find out best selling month in each year

select year, month, avg_sales from (select year(sale_date) as Year, 
month(sale_date) as month,
avg(total_sale) as avg_sales,
rank() over(partition by year(sale_date) order by avg(total_sale) desc ) as rn
 from retail_sales
 group by 1,2) as t1
 where rn = 1;
 
 -- 8.Write a SQL query to find the top 5 customers based on the highest total sales
 
 select customer_id, sum(total_sale) as customer_total_sales 
 from retail_sales
 group by 1
 order by customer_total_sales desc
 limit 5;
 
 -- 9.Write a SQL query to find the number of unique customers who purchased items from each category.
 
 select category, count(distinct customer_id) as uniqe_coustomer_count
 from retail_sales
 group by 1;
 
 -- 10.Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)
 
 select shift, count(*) as no_of_orders from (
 select *,
 case 
 when sale_time <= '12:00:00' then 'Morning'
 when sale_time <= '17:00:00' then 'Afternoon'
 else 'Evening'
 end as Shift
 from retail_sales) as t1
 group by 1;
 
