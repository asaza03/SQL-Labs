-- In this lab we will find the customers who were active in consecutive months of May and June. Follow the steps to complete the analysis.
use sakila; 

-- Create a table rentals_may to store the data from rental table with information for the month of May.
-- Insert values in the table rentals_may using the table rental, filtering values only for the month of May.

drop table if exists rentals_may;
create table rentals_may as
select * from rental where rental_date like '____-05-%';

select * from rentals_may;

-- Create a table rentals_june to store the data from rental table with information for the month of June.
-- Insert values in the table rentals_june using the table rental, filtering values only for the month of June.

drop table if exists rentals_june;
create table rentals_june as
select * from rental where rental_date like '____-06-%';

select * from rentals_june;

-- Check the number of rentals for each customer for May.

select customer_id, count(rental_id) as Nº_of_rentals from rentals_may group by customer_id;

-- Check the number of rentals for each customer for June.
select customer_id, count(rental_id) as Nº_of_rentals from rentals_june group by customer_id;

