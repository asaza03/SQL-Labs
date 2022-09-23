use sakila;

-- Get all pairs of actors that worked together
select * from film_actor; -- actor_id, film_id fa
select * from actor; -- actor_id, first_name, last_name a

select fa1.film_id, concat(a1.first_name, " ", a1.last_name) as actor_1, concat(a2.first_name, " ", a2.last_name) as actor_2,
	   fa1.actor_id, fa2.actor_id
	from film_actor fa1
    join film_actor fa2 on fa1.film_id = fa2.film_id
    join actor a1 on a1.actor_id = fa1.actor_id
    join actor a2 on a2.actor_id = fa2.actor_id
    and fa1.actor_id > fa2.actor_id
    order by a1.actor_id;


-- Get all pairs of customers that have rented the same film more than 3 times
select * from inventory; -- inventory_id, film_id b
select * from rental; -- inventory_id, customer_id, rental_id l
select * from film; -- film_id, title a

select l1.customer_id as customer_1, l2.customer_id as customer_2, count(distinct l1.inventory_id) as films_rented
from inventory b
join film a on a.film_id = b.film_id
join rental l1 on l1.inventory_id = b.inventory_id
join rental l2 on l2.inventory_id = l1.inventory_id 
	and l1.customer_id < l2.customer_id
group by l1.customer_id, l2.customer_id
having films_rented > 3;


-- Get all possible pairs of actors and films

select * from (
	select distinct first_name, last_name
    from sakila.actor)sub1
    cross join (
    select title from sakila.film)sub2;