--extract: used mostly on dates and timestamp
--basic syntax: EXTRACT (field from date/time/interval) 

/******** Problem 1 ********/
/*
Analyze the payments and find out what's the month with the highest total payment amount?
*/
select 
	extract(month from payment_date) as month,
	sum(amount) as total_payment_amount
from payment
group by month
order by total_payment_amount desc;


/******** Problem 2 ********/
/*
Analyze the payments and find out What's the day of week with the highest total payment amount? (0 is Sunday)
*/
select 
	extract(dow from payment_date) as day_of_week,
	sum(amount) as total_payment_amount
from payment
group by day_of_week
order by total_payment_amount desc;


/******** Problem 3 ********/
/*
Analyze the payments and find out what's the highest amount one customer has spent in a week?
*/
select 
	customer_id,
	extract(week from payment_date) as week,
	sum(amount) as total_spend
from payment
group by week, customer_id
order by total_spend desc

