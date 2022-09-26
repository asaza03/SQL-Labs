use sakila;

-- Get number of monthly active customers.

create or replace view active_customers as
	select customer_id, date(rental_date) as last_active_date,
    date_format(rental_date, '%m') as last_active_month,
    date_format(rental_date, '%y') as last_active_year
    from rental;
    
select * from active_customers;

create or replace view monthly_active_customers as
	select last_active_month, last_active_year, count(distinct customer_id) as number_active_customers
    from active_customers
    group by last_active_month, last_active_year
    order by last_active_month, last_active_year;
    
select * from monthly_active_customers;
    

-- Active users in the previous month. 

create or replace view last_month_active_users as
select *, lag(number_active_customers) over(partition by last_active_year order by last_active_month) as previous_month
from monthly_active_customers;

select * from last_month_active_users;

-- Percentage change in the number of active customers.

create or replace view percentage_active_customers as
select *, round(number_active_customers/previous_month,2) as percentage
from last_month_active_users;

select * from percentage_active_customers;


-- Retained customers every month.

select * from rental;
with sub1 as (
  select year(a.rental_date) as year, 
         month(a.rental_date) as month,
         count(distinct a.customer_id) as unique_customers
 from rental a
  group by year, month) 

select year, month, unique_customers, 
	round(ifnull(unique_customers / (sum(unique_customers)
    over(order by month) - unique_customers), 1) * 100,2) as retention_rate
from sub1;