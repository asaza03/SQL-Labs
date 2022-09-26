use sakila;
-- Write the SQL queries to answer the following questions:

-- Select the first name, last name, and email address of all the customers who have rented a movie.
select * from sakila.customer;  -- customer_id, first_name, last_name, email a
select * from sakila.rental; -- rental_id, customer_id l

select distinct(a.first_name), a.last_name, a.email 
from sakila.customer a
join rental l on a.customer_id = l.customer_id;


-- What is the average payment made by each customer (display the customer id, customer name (concatenated), and the average payment made).
select * from payment; -- payment_id, customer_id, amount p 
select * from customer; -- customer_id, first_name, last_name d

select p.customer_id, concat(d.first_name, " ", d.last_name) as customer_full_name,
	avg(p.amount) as average_payment
from sakila.payment p
join customer d on p.customer_id = d.customer_id
group by customer_id;



-- Select the name and email address of all the customers who have rented the "Action" movies.

-- Write the query using multiple join statements

create or replace view action_customers as 
	select distinct(concat(d.first_name, "  ", d.last_name)) as customer_full_name 
    from customer d
    join rental l on d.customer_id = l.customer_id
    join inventory i on l.inventory_id = i.inventory_id
    join film_category f on i.film_id = f.film_id
    join category c on f.category_id = c.category_id
    where c.name = "Action";
    
select * from action_customers;
    

-- Write the query using sub queries with multiple WHERE clause and IN condition

create or replace view action_customers2 as
	select distinct(concat(first_name,"  ", last_name)) as customer_full_name
    from sakila.customer
    where customer_id in (
		select customer_id
        from rental
        where inventory_id in (
			select inventory_id
            from inventory
            where film_id in (
				select film_id
                from film_category
                where category_id in (
					select category_id
                    from category
                    where name = 'Action')
)));

select * from action_customers2;


-- Verify if the above two queries produce the same results or not

select if((count(distinct(a.customer_full_name))) = 
(count(distinct(b.customer_full_name))), "same result", "error") as result
from action_customers a, action_customers b;



-- Use the case statement to create a new column classifying existing columns as either or high value transactions based on the amount of payment. 
-- If the amount is between 0 and 2, label should be low and if the amount is between 2 and 4, the label should be medium, and if it is more than 4, then it should be high.

select *,
case
when amount between 0 and 2 then "low"
when amount between 2 and 4 then "medium"
when amount > 4 then "high"
else "null"
end as payment_classification
from payment;