use sakila;

-- Write a query to display for each store its store ID, city, and country.
select * from store; -- store_id, address_id -- a
select * from city; -- city_id, city, country_id -- l
select * from country; -- country_id, country -- c
select * from address; -- address_id, city_id -- d

select a.store_id, l.city, c.country
from sakila.store a 
join sakila.address as d on a.address_id = d.address_id
join sakila.city as l
on l.city_id = d.city_id
join sakila.country as c
on c.country_id = l.country_id;

-- Write a query to display how much business, in dollars, each store brought in.
select * from payment; -- payment_id, customer_id, staff_id, amount l
select * from staff; -- store_id, staff_id a

select a.store_id, sum(l.amount) as "generated_business"
from sakila.staff a
join sakila.payment l on a.staff_id = l.staff_id
group by store_id;


-- What is the average running time of films by category?
select * from category; -- category_id, name b
select * from film; -- film_id, length l

select round(avg(l.length),0) as "average_running_time", b.name 
from sakila.film l
join sakila.category b on l.film_id = b.category_id
group by name; 


-- Which film categories are longest?
select round(avg(l.length),0) as "average_running_time", b.name,
rank () over(order by avg(length)) as "ranking"
from sakila.film l
join sakila.category b on l.film_id = b.category_id
group by name; 


-- Display the most frequently rented movies in descending order.
select * from film; -- film_id, title a
select * from rental; -- rental_id, inventory_id d
select * from inventory; -- inventory_id, film_id l 

select a.title, count(rental_id) as "times_rented", 
rank () over(order by count(rental_id)) as "ranking"
from film a
join inventory l on a.film_id = l.film_id
join rental d on l.inventory_id = d.inventory_id
group by title;


-- List the top five genres in gross revenue in descending order.
select * from category; -- category_id, name a
select * from film_category; -- film_id, category_id c
select * from payment; -- amount, rental_id l
select * from rental; -- rental_id, inventory_id d
select * from inventory; -- inventory_id, film_id s

select a.name as "category_name", sum(l.amount) as "gross_revenue" 
from category a
join film_category c on a.category_id = c.category_id
join inventory s on c.film_id = s.film_id
join rental d on s.inventory_id = d.inventory_id
join payment l on d.rental_id = l.rental_id
group by name
order by sum(amount) desc limit 5;


-- Is "Academy Dinosaur" available for rent from Store 1?
select * from store; -- store_id a
select * from inventory; -- inventory_id, film_id, store_id l 
select * from film; -- film_id, title p

select * from film where title = "Academy Dinosaur"; -- film_id 1

select p.title, a.store_id as "store", count(l.inventory_id) as "inventory"
from store a
join inventory l on a.store_id = l.store_id
join film p on l.film_id = p.film_id
where p.film_id = 1
group by a.store_id; 

-- The film Academy Dinosaur is available for rent in store 1, they have 4 copies of the film 


