create database pizza_hurt;
use pizza_hurt;
select * from pizzas; --  table1
select * from pizza_types;-- table2
create table orders( order_id int not null , order_date date not null , order_time time not null );
select * from orders; -- table3
create table order_details(order_details_id int not null ,order_id int not null ,pizza_id text not null ,quantity int not null);

-- Q1 Retrieve the total number of orders placed. 
SELECT COUNT(*) AS TOTAL_NO_ORDERS  FROM order_details;  

-- Q2Calculate the total revenue generated from pizza sales.

SELECT * FROM ORDER_DETAILS;
SELECT * FROM pizzaS;
SELECT round(sum(PRICE*QUANTITY),2) as total_revenue FROM order_details JOIN pizzas 
 on order_details.pizza_id=pizzas.pizza_id;

-- Q3Identify the highest-priced pizza.
select * from pizza_types;
select * from pizzas;

select * from pizza_types join pizzas on pizza_types.pizza_type_id = pizzas.pizza_type_id 
 order by price desc limit 1;

-- Q4Identify the most common pizza size ordered.

select size ,count(order_details_id) as orderss from pizzas join order_details
 on pizzas.pizza_id =order_details.pizza_id group by size order by orderss desc ;
 
 
-- Q5List the top 5 most ordered pizza types along with their quantities.
select * from order_details;
select * from pizza_types;
select * from pizzas;
select name ,sum(quantity) as total_quantity from order_details join pizzas
 on order_details.pizza_id =pizzas.pizza_id join pizza_types 
 on pizza_types.pizza_type_id=pizzas.pizza_type_id group by name 
 order by total_quantity desc limit 5;

-- Q6Join the necessary tables to find the total quantity of each pizza category ordered.

select * from pizza_types;
select * from order_details;
select * from pizzas;

select category ,sum(quantity) as total_quantity from order_details join pizzas 
on order_details.pizza_id=pizzas.pizza_id join pizza_types 
on pizzas.pizza_type_id=pizza_types.pizza_type_id group by category ;

-- Q7 Determine the distribution of orders by hour of the day.

select * from orders;
select hour(order_time) ,count(order_id ) from orders group by hour(order_time);

-- Q8 Join relevant tables to find the category-wise distribution of pizzas.

select * from pizza_types;
select category , count(name) from pizza_types group by category;

-- Q9 Group the orders by date and calculate the average number of pizzas ordered per day.
select * from orders;
select * from order_details;

select round(avg(order_per_day),0)from (select order_date ,sum(quantity) as order_per_day
  from orders join order_details on order_details.order_id=orders.order_id
  group by order_date) as ordersss;
  
-- Q10 Determine the top 3 most ordered pizza types based on revenue.
select * from pizza_types;
select * from order_details;
select * from pizzas;

select name ,sum(quantity*price) as revenue  from  pizza_types join  pizzas 
on pizzas.pizza_type_id=pizza_types.pizza_type_id join order_details
 on order_details.pizza_id=pizzas.pizza_id group by name order by revenue desc limit 5;
 
-- Q11 Calculate the percentage contribution of each pizza type to total revenue.

select category,round((sum(quantity*price)/817860.05*100),2) as revenue  
from order_details join pizzas on order_details.pizza_id =pizzas.pizza_id join
 pizza_types on pizza_types.pizza_type_id = pizzas.pizza_type_id group by category ;

-- Q12 Analyze the cumulative revenue generated over time.
select * from orders;
select * from order_details;
select * from pizzas;

select order_date ,sum(revenue) over (order by order_date)
from (select order_date , sum(quantity*price)  as revenue from orders
 join order_details on orders.order_id = order_details.order_id join
 pizzas on pizzas.pizza_id = order_details.pizza_id group by order_date) as tab1;
 
-- Q13 Determine the top 3 most ordered pizza types based on revenue for each pizza category. 

select name,category,revenue ,rank( )over(partition by category order by revenue desc) 
from (select name,category,sum(quantity*price)as revenue  from order_details join pizzas 
on order_details.pizza_id =pizzas.pizza_id join
 pizza_types on pizza_types.pizza_type_id = pizzas.pizza_type_id group by category,name) as a ;
 
 