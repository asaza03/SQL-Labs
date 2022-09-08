use sakila;

-- Select all the actors with the first name ‘Scarlett’
select * from actor;
select * from actor where first_name = "SCARLETT"; -- There are 2 actors with first name "Scarlet", the first in line 81, the second in line 124
select count(*) from actor where first_name = "SCARLETT"; -- sanity check, counts = 2


-- Select all the actors with the last name ‘Johansson’
select * from actor;
select * from actor where last_name = "JOHANSSON"; -- There are 3 actors with last name "Johansson", lines: 8, 64 and 146
select count(*) from actor where last_name = "JOHANSSON"; -- sanity check, counts = 3


-- How many films (movies) are available for rent?
select * from film; 
select count(distinct title) from film; -- 1000 movies are for rent


-- How many films have been rented?
select count(rental_id) from rental; -- 16044 is the result. I have doubts wether this is the number of films rented or the number of rental operations (meaning one film could be rented more than 1).


-- What is the shortest and longest rental period?
select * from film;
select min(rental_duration) from film; -- 3 days is the min rental duration
select max(rental_duration) from film; -- 7 days is the max rental duration


-- What are the shortest and longest movie duration?
-- Name the values max_duration and min_duration
select * from film;
select min(length) as min_duration from film; -- 46 minutes is the shortest length movie
select max(length) as max_duration from film; -- 185 minutes is the longest movie


-- What's the average movie duration?
select avg(length) from film; -- 115.2720 minutes is the average
select round(avg(length),2) from film; -- 115.27 minutes. It wasn't asked to round the decimals, but I wanted to practise


-- What's the average movie duration expressed in format (hours, minutes)?
select convert(floor(avg(length)), time) as avg_movie_duration from film; -- 00:01:15


-- How many movies longer than 3 hours?
select * from film;
select count(film_id) as movies_longer_than_3 from film where length > 180; -- 39 movies are longer than 3 hours (180 min)


-- Get the name and email formatted. Example: Mary SMITH - mary.smith@sakilacustomer.org.
select * from customer;
select concat(first_name, " ", last_name, " - ", email) as contact_details from customer;


-- What's the length of the longest film title?
select * from film;
select max(length(title)) from film; -- The length is 27 letters