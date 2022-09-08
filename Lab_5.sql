use sakila;

-- Drop column picture from staff.
select * from staff; 
alter table staff
drop column picture;

-- A new person is hired to help Jon. Her name is TAMMY SANDERS, and she is a customer. 
-- Update the database accordingly.
select * from staff;
insert into staff
values (3, "Tammy", "Sanders", 5, 'tammy.sanders@sakilastaff.com', 2, 1, "Tammy",' ',"2022-08-25" );

-- Add rental for movie "Academy Dinosaur" by Charlotte Hunter from Mike Hillyer at Store 1. 
-- You can use current date for the rental_date column in the rental table. 
-- Hint: Check the columns in the table rental and see what information you would need to add there. 
-- You can query those pieces of information. For eg., you would notice that you need customer_id information as well. 
-- To get that you can use the following query:

-- select customer_id from sakila.customer
-- where first_name = 'CHARLOTTE' and last_name = 'HUNTER';

-- Use similar method to get inventory_id, film_id, and staff_id.

select * from rental order by rental_id desc; -- last rental_id 16048
select customer_id from sakila.customer where first_name = 'CHARLOTTE' and last_name = 'HUNTER'; -- customer_id 130
select film_id from sakila.film where title = 'ACADEMY DINOSAUR'; -- fil_id = 1
select inventory_id from inventory where film_id = 1; -- inventory_id = 1,2,3,4,5,6,7,8
select staff_id from staff where first_name = 'Mike' and last_name='Hillyer'; -- Mike's staff_id = 1

insert into rental values(16050, now(), 1, 130, now(),1, now());

select * from rental order by rental_id desc; -- sanity check

-- Delete non-active users, but first, create a backup table deleted_users to store customer_id, email, and the date for the users that would be deleted. 
-- Follow these steps:

-- 1.Check if there are any non-active users

select count(*) from customer where active =0; -- There are 15 non-active users

-- 2.Create a table backup table as suggested

create table deleted_users(
customer_id int unique not null,
email text default null,
date int default null,
constraint primary key(customer_id)
);

select * from deleted_users;

-- 3.Insert the non active users in the table backup table
insert into deleted_users (customer_id, email)
select customer_id, email 
from customer 
where active = 0;

-- 4.Delete the non active users from the table customer
select * from customer;
set sql_safe_updates = 0; -- Turn OFF "Safe Update Mode" temporary
delete from customer where active = 0;
set sql_safe_updates = 1; -- Turn ON Safe Update Mode again. 