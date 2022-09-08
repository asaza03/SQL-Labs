use sakila;

-- Instructions
-- Add the new films to the database.
-- Update information on rental_duration, rental_rate, and replacement_cost.
-- Hint: You might have to use the following commands to set bulk import option to ON:
-- show variables like 'local_infile';
-- set global local_infile = 1;

drop table if exists films_2020;
CREATE TABLE `films_2020` (
  `film_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `description` text,
  `release_year` year(4) DEFAULT NULL,
  `language_id` tinyint(3) unsigned NOT NULL,
  `original_language_id` tinyint(3) unsigned DEFAULT NULL,
  `rental_duration` int(6),
  `rental_rate` decimal(4,2),
  `length` smallint(5) unsigned DEFAULT NULL,
  `replacement_cost` decimal(5,2) DEFAULT NULL,
  `rating` enum('G','PG','PG-13','R','NC-17') DEFAULT NULL,
  PRIMARY KEY (`film_id`),
  CONSTRAINT FOREIGN KEY (`original_language_id`) REFERENCES `language` (`language_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1003 DEFAULT CHARSET=utf8;

select * from films_2020;

-- load data local infile '/Users/adelasanchez/Desktop/Bootcamp/Week-6/lab-sql-6/files_for_lab/films_2020.csv' 
-- into table films_2020
-- FIELDS TERMINATED BY ','
-- LINES TERMINATED BY '\n'
-- ignore 1 rows; -- Error code 2068.Load Data Local Infile file request rejected due to restrictions on access.

-- I couldn't find a solution for this error, so I used data import Wizard

select * from films_2020;

-- Update information on rental_duration, rental_rate, and replacement_cost
set sql_safe_updates = 0; -- Turn OFF "Safe Update Mode" temporary

update films_2020 
set rental_duration = 3,
rental_rate = 2.99,
replacement_cost = 8.99;

set sql_safe_updates = 1; -- Turn ON Safe Update Mode again. 

select * from films_2020;
