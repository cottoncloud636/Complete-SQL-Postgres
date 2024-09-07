-- get current date: select CURRENT_DATE
-- get current timestamp: select CURRENT_TIMESTAMP
-- get interval: select CURRENT_TIMESTAMP - SOME_DATE


/******** Problem 1 ********/
/*
Create a list for the support team of all rental durations of customer_id 35.

Table -- rental
Columns -- rental_id	  rental_date	            inventory_id	customer_id	     return_date	          staff_id	last_update
                2	      2005-05-24 23:54:33+02	1525	        459	            2005-05-28 20:40:33+02	1	        2020-02-16 03:30:53+01


*/

select
	customer_id,
	return_date - rental_date as rental_duration
from rental
where customer_id=35;


/******** Problem 2 ********/
/*
Find out for the support team which customer has the longest average rental duration?
-- avg can't be used in group by
*/
select 
	customer_id,
	avg(return_date - rental_date) as duration
from rental
group by customer_id
order by duration desc
