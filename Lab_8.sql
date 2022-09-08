use sakila;

-- Rank films by length (filter out the rows with nulls or zeros in length column). Select only columns title, length and rank in your output.
select title, length, rank() over(order by length) as 'rank' 
from film having length >= 1;

-- Rank films by length within the rating category (filter out the rows with nulls or zeros in length column). 
-- In your output, only select the columns title, length, rating and rank.
select title, length, rating, rank() over(partition by rating order by length) as 'rank' 
from film having length >= 1;

-- How many films are there for each of the categories in the category table? 
-- Hint: Use appropriate join between the tables "category" and "film_category".
select name as 'films category' , count(*) as 'Nº of films' 
from category inner join film_category on category.category_id = film_category.category_id group by name;

-- Which actor has appeared in the most films? 
-- Hint: You can create a join between the tables "actor" and "film actor" and count the number of times an actor appears.
select first_name, last_name, count(actor.actor_id) as 'Nº of movies participated in', 
rank() over(order by count(actor.actor_id) desc) as 'rank'
from actor inner join film_actor on actor.actor_id = film_actor.actor_id group by actor.actor_id;

-- Which is the most active customer (the customer that has rented the most number of films)? 
-- Hint: Use appropriate join between the tables "customer" and "rental" and count the rental_id for each customer.
select customer.customer_id, count(rental_id) as 'number of rented movies' 
from customer inner join rental on customer.customer_id = rental.customer_id
group by customer.customer_id order by count(rental_id) desc;

-- Bonus: Which is the most rented film? (The answer is Bucket Brotherhood).
-- This query might require using more than one join statement. Give it a try. We will talk about queries with multiple join statements later in the lessons.
-- Hint: You can use join between three tables - "Film", "Inventory", and "Rental" and count the rental ids for each film.