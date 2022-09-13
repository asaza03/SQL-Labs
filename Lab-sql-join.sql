use sakila;

-- List the number of films per category
select *from film_category; -- film_id, category_id as l
select * from category; -- category_id and name as a

select count(*) as number_fimls, name from category a
join film_category l
on a.category_id = l.category_id
group by name;
 
-- Display the first and the last names, as well as the address, of each staff member
select * from staff; -- first_name, last_name and address_id
select * from address; -- address_id and address

select a.first_name, a.last_name, l.address
from sakila.staff a
join sakila.address l on a.address_id = l.address_id;

-- Display the total amount rung up by each staff member in August 2005

select * from payment; -- amount, staff_id and payment_date l
select * from staff; -- staff_id and first_name a

select a.first_name, sum(l.amount) as total_amount_aug_05 from sakila.staff a
left join sakila.payment l 
on a.staff_id = l.staff_id
where payment_date like '2005-08-%'
group by a.first_name;

-- List all films and the number of actors who are listed for each film
select*from film; -- film_id, title
select*from film_actor; -- actor_id, film_id

select a.title, count(l.actor_id) as number_of_actors from film a
join film_actor l on a.film_id = l.film_id
group by a.title;


-- Using the payment and the customer tables as well as the JOIN command, list the total amount paid by each customer. 
-- List the customers alphabetically by their last names

select * from payment; -- customer_id, amount l
select * from customer; -- customer_id, last_name a
-- using join
-- total amount paid by each costumer. 
-- List customers alphabetically by last_name

select a.last_name, sum(l.amount) as total_amount from customer a
join payment l
on a.customer_id = l.customer_id
group by a.last_name; 

