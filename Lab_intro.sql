use sakila;

-- Get all the data from tables actor, film and customer
select * from actor; -- actor table
select * from film; -- film table
select * from customer; -- customer table

-- Get film titles
select title from film;  -- selecting column title from the table film

-- Get unique list of film languages under the alias language
select * from language;
select distinct name as language from language;

-- How many stores does the company have?
select * from store;
select count(store_id) from store;

-- How many employees staff does the company have?
select * from staff;
select count(staff_id) from staff;

-- A list of employee first names only?
select * from staff;
select first_name from staff;