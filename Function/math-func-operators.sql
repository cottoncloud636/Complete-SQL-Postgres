
/******** Problem 1 ********/
/*
Return the product with the highest total revenue. 
Return the product name and its total revenue (alias: total_revenue). 
Use mathematical operators to calculate the total revenue for each product (quantity_sold * price_per_unit) and aggregate functions to find the sum of revenues for each product.

Table -- sales
Column -- product_name, quantity_sold, price_per_unit
*/
select
    product_name,
    sum(quantity_sold * price_per_unit) as total_revenue
from sales
group by product_name
order by total_revenue desc
limit 1


/******** Problem 2 ********/
/*
Your manager is thinking about increasing the prices for films that are more expensive to replace.

Create a list of the films including the relation of rental rate / replacement cost as percentate where 
the rental rate is less than 4% of the replacement cost.

Percentage should be rounded to 2 decimal places. For example 3.54 (=3.54%).

Table -- film
Columns -- film_id	title	description	release_year	language_id	original_language_id	rental_duration	rental_rate	length	replacement_cost	rating	last_update	special_features	fulltext
           1                                                                           6	              0.99                20.99
*/
select 
	film_id,
	round(round(rental_rate/replacement_cost, 4)*100, 2) as percentage
	-- can also write as "round(rental_rate/replacement_cost*100, 2) as percentage"
from film
where rental_rate < (0.04 * replacement_cost)
order by percentage desc
