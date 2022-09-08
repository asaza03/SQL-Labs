use sakila;

-- How many distinct (different) actors' last names are there?
select * from actor;
select count(distinct last_name) from actor; -- There are 121 distinct actor's last name
select distinct last_name from actor; -- With this formula we get distinct last name

-- In how many different languages where the films originally produced? (Use the column language_id from the film table)
select * from film;
select count(distinct language_id) from film; -- The films were originally produced in one language
select distinct language_id from film; -- sanity check

-- How many movies were released with "PG-13" rating?
select count(film_id) from film where rating = "PG-13"; -- 223 movies released with PG-13 rating

-- Get 10 the longest movies from 2006.
select * from film;
select * from film where release_year = "2006" order by length desc LIMIT 10; 
-- The 10 longest films from 2006: 
-- GANGS PRIDE > SWEET BROTHERHOOD > MUSCLE BRIGHT > SOLDIERS EVOLUTION > POND SEATTLE >
-- CHICAGO NORTH > CONTROL ANTHEM > WORST BANGER > HOME PITY > DARN FORRESTER

-- How many days has been the company operating (check DATEDIFF() function)?
select * from rental;
select datediff(max(rental_date),min(rental_date)) as No_of_Days from sakila.rental; -- 266 days. 

-- Not sure about the results in this question. I took the min and max rental date as it were the first and last operation of the company. 
-- I couldn't find information in order tables that would make sense for this question. 


-- Show rental info with additional columns month and weekday. Get 20.

select *, extract(month from rental_date) as rental_month, extract(day from rental_date) as rental_weekday from rental limit 20;

-- Add an additional column day_type with values 'weekend' and 'workday' depending on the rental day of the week.

select *,
case
when dayofweek(rental_date) between 1 and 5
then "workday"
else "weekend"
end as day_type from rental;


-- How many rentals were in the last month of activity?
select * from rental;
select distinct rental_date from rental; -- It looks like al the rentals had been done in May 2005

select count(*) from rental where date_format (rental_date, "%M") = 'May'; -- 1156 rentals during the last month of activity