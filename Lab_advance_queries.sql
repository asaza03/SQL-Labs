-- List each pair of actors that have worked together. 
-- Comment: This query is almost the same as the one in Lab-self-cross-join, but in this case I use a create or replace view 

create or replace view actor_combination as
select fa1.actor_id as actor_id1, fa2.actor_id as actor_id2, fa1.film_id
from film_actor fa1
join film_actor fa2 on fa1.actor_id < fa2.actor_id
and fa1.film_id = fa2.film_id;

select actor_id1, concat(l1.first_name, "  ", l1.last_name) as actor_1,
		actor_id2, concat(l2.first_name, "  ", l2.last_name) as actor_2 
        from actor_combination
        join actor l1 on actor_id1 = l1.actor_id
        join actor l2 on actor_id2 = l2.actor_id
        group by actor_id1, actor_id2;
        


-- For each film, list actor that has acted in more films.

select actor_id, count(film_id) number_films
from film_actor 
group by actor_id;

with cte1 as (
	select actor_id, count(film_id) number_films
	from film_actor 
	group by actor_id
),
cte2 as (
	select f.film_id, f.actor_id, d.number_films,
    rank() over(partition by f.film_id order by d.number_films desc) as ranking from film_actor f
    join cte1 d on d.actor_id = f.actor_id
)
select film_id, actor_id, ranking from cte2
where ranking = 1;


