use sakila;

-- Get film ratings
select rating from sakila.film;

-- Get release years
select release_year from sakila.film;


-- Get all films with ARMAGEDDON in the title.
select * from sakila.film;
select * from sakila.film where title like "%ARMAGEDDON%"; -- 6 films: film_id -> 39, 507, 571, 598, 838, 844
select count(*)from sakila.film where title like "%ARMAGEDDON%"; -- sanity check: 6 films with Armageddon in the title

-- Get all films with APOLLO in the title
select * from sakila.film where title like "%APOLLO%"; -- 6 films: film_id -> 33, 759, 771, 878, 966, 974
select count(*) from sakila.film where title like "%APOLLO%"; -- sanity check: 6 films with Apollo in the title

-- Get all films which title ends with APOLLO.
select * from sakila.film where title like "%APOLLO"; -- 5 films: film_id -> 759, 771, 878, 966, 974
select count(*) from sakila.film where title like "%APOLLO"; -- sanity check: 5 films which title ends with Apollo

-- Get all films with word DATE in the title.

select * from film where title regexp 'date';

-- Get 10 films with the longest title.
select * from film;
select * from film order by length(title) desc limit 10; -- films_id: 35,763,905,224,297,287,727,964,174,880

-- Get 10 the longest films.
select * from film order by length desc limit 10; -- All films obtained with this function have a duration of 185 minutes
select max(length) from film; -- sanity check to know the max(length) of the longer film

-- How many films include Behind the Scenes content?
select * from film;
select count(*) from film where special_features regexp "Behind the Scenes"; -- 538 films include Behind the Scenes content

-- List films ordered by release year and title in alphabetical order
select * from film order by release_year, title asc;

