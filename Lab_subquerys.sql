use sakila;

-- How many copies of the film Hunchback Impossible exist in the inventory system?
select count(*) as Hunchback_Impossible_copies from inventory
join sakila.film
using (film_id)
where title = "Hunchback Impossible";


-- List all films whose length is longer than the average of all the films.

select title, length from sakila.film
where length > (
	select avg(length) from film)
order by length;

select avg(length) from film; -- sanity check, avg(length) is 115.27

-- Use subqueries to display all actors who appear in the film Alone Trip.
select * from actor; 

select a.actor_id, concat(l.first_name, "  ",  l.last_name) as actor_name
from film_actor a
join actor l on a.actor_id = l.actor_id
where film_id = (
	select film_id as at from film
    where title = "Alone Trip");

-- Sales have been lagging among young families, and you wish to target all family movies for a promotion. 
-- Identify all movies categorized as family films.
select * from category; -- category_id, name
select * from film_category; -- film_id, category_id

select title from sakila.film
where film_id in (
	select film_id from film_category
    join category using (category_id)
    where name = "Family");


-- Get name and email from customers from Canada using subqueries. 

select concat (first_name, "  ", last_name) as customer_name, email from sakila.customer
where address_id in (
	select address_id from address
    where city_id in(
		select city_id from city
        where country_id = (
			select country_id from country
            where country = "Canada")
)
);

-- Do the same with joins.  Note that to create a join, you will have to identify the correct tables 
-- with their primary keys and foreign keys, that will help you get the relevant information.
select * from sakila.customer; -- address_id
select * from sakila.address; -- address_id, city_id
select * from sakila.city; -- city_id, country_id
select * from sakila.country; -- country_id, country


select concat (first_name, "  ", last_name) as customer_name, email 
from sakila.customer
join sakila.address using (address_id)
join sakila.city using (city_id)
join sakila.country using (country_id)
where country = "Canada";


-- Which are films starred by the most prolific actor? Most prolific actor is defined as the actor that has acted in the most number of films. 
-- First you will have to find the most prolific actor and then use that actor_id to find the different films that he/she starred.

select title from sakila.film
where film_id in (
	select film_id from film_actor
    where actor_id = (
		select actor_id from film_actor
        group by actor_id
        order by count(*) desc
        limit 1)
);


-- Films rented by most profitable customer. You can use the customer table and payment table to find the most profitable customer ie the customer that has made the largest sum of payments

select customer_id as most_profitable_customer, sum(amount) as total_payment
from sakila.customer
join sakila.payment using (customer_id)
group by customer_id
order by total_payment desc limit 1;


-- Get the client_id and the total_amount_spent of those clients who spent more than the average of the total_amount spent by each client.

select customer_id, sum(amount) as total_amount_spent
from payment
group by customer_id
having total_amount_spent > (
	select sum(amount)/ count(distinct customer_id)
    from payment
    )
order by total_amount_spent desc;
