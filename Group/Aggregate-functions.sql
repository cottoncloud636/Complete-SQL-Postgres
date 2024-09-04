/*
write a query that retrieves the minimum, maximum, average (rounded), and sum of the replacement cost of films from a table
*/

select 
	min (replacement_cost),
	max (replacement_cost),
	round (avg (replacement_cost)),
	sum (replacement_cost)
from film
