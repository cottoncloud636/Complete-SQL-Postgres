-- TO_CHAR: Used to get custom formats timestamp/date/numbers
-- basic syntax: TO_CHAR (date/time/interval, format), check postgreSQL for defined format

/******** Problem 1 ********/
/*
Sum payments and group in the following formats:
total_amount   day
62.86          Fri,24/01/2020
*/
select 
	sum(amount) as total_amount,
	to_char(payment_date, 'Dy,DD/MM/YYYY') as pay_date
from payment
group by pay_date;


/******** Problem 2 ********/
/*
Sum payments and group in the following formats:
total_amount   day
62.86          May,2020
*/
select 
	sum(amount) as total_amount,
	to_char(payment_date, 'Mon,YYYY') as pay_date
from payment
group by pay_date;


/******** Problem 3 ********/
/*
Sum payments and group in the following formats:
total_amount   day
62.86          Thu,02:44
*/
select 
	sum(amount) as total_amount,
	to_char(payment_date, 'Dy,HH:MI') as pay_date
from payment
group by pay_date
