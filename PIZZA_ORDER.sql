use pizza_order;

-- KPIS 
-- 1) Total Revenue generated
Select sum(quantity* price)
from order_details AS o
Join Pizzas AS p 
ON o.pizza_id = p.pizza_id;

-- 2) Average Order Value
-- total order value/order count


Select 
round(sum(quantity* price)/count(distinct order_id),2) as  Avg_Order_Values
from order_details AS o
Join pizzas AS p 
ON o.pizza_id = p.pizza_id;

-- 3) Total pizza Sold 
Select sum(quantity) as Total_Pizzas_Sold
from order_details;

-- 4) Total Orders 
Select 
count(distinct order_id) as Total_Orders
From order_details; 


-- 4) Average Pizza per Order 
-- pizza sold/number of pizzas  

Select 
sum(quantity)/count(distinct order_id)as Average_Pizzas_Per_Order
From order_details; 

-- Questions to Answer 
-- 1) Daily trends for total orders 

Select 
dayofweek(date) as Day_of_Week,
count(distinct order_id) as total_orders 
from orders 
group by Day_of_Week
order by total_orders desc;

-- 2) Hourly Trend for Total Orders 

Select 
DATE_FORMAT(CONCAT(date, ' ', time), '%H')as Hour ,
count(distinct order_id) as total_orders
from orders 
group by hour
order by Hour;

-- 3) Percentage of Sales by Pizza Category 
select category , sum(quantity *price) as revenue ,
round(sum(quantity* price) * 100/(
Select sum(quantity*price)
from pizzas As P2 
join order_details as od2 on od2.pizza_id = p2.pizza_id),2)
as percentage_sales 

from pizzas as p 
join pizza_types as pt on p.pizza_type_id = pt.pizza_type_id
join order_details as od on od.pizza_id = p.pizza_id
Group by category
Order by percentage_sales desc;

-- 4) Percentage of Sales by Pizza Size 
select size , sum(quantity *price) as revenue ,
round(sum(quantity* price) * 100/(
Select sum(quantity*price)
from pizzas As P2 
join order_details as od2 on od2.pizza_id = p2.pizza_id),2)
as percentage_sales 

from pizzas as p 
join pizza_types as pt on p.pizza_type_id = pt.pizza_type_id
join order_details as od on od.pizza_id = p.pizza_id
Group by size
Order by percentage_sales desc;

-- 5) Total pizza sold by Pizza Category 
select category, Sum(quantity) as quantity_sold
From 
pizzas As p 
join pizza_types as pt On p.pizza_type_id = pt.pizza_type_id 
join order_details as od on od.pizza_id = p.pizza_id
group by category 
order by sum(quantity) desc; 

-- 6) Top 5 best sellers by total pizza sold 

select 
name, sum(quantity) as total_pizzas_sold
From 
pizzas As p 
join pizza_types as pt On p.pizza_type_id = pt.pizza_type_id 
join order_details as od on od.pizza_id = p.pizza_id
group by name 
order by total_pizzas_sold desc
LIMIT 5;


-- 7) Bottom 5 Worst Sellers by Total Pizzas Sold 

select 
name, sum(quantity) as total_pizzas_sold
From 
pizzas As p 
join pizza_types as pt On p.pizza_type_id = pt.pizza_type_id 
join order_details as od on od.pizza_id = p.pizza_id
group by name 
order by total_pizzas_sold asc
LIMIT 5;