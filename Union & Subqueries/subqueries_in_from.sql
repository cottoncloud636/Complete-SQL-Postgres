-- use subquery under "from" keyword.
-- in PostgreSQL, we can only use subquery in the "from" clause if the subquery is named with an alias


/************************************** Problem 1 *******************************************/
/*
Find out the average life-spend per customer.
-- Step 1: calculate the sum of the amount, group by each customer_id

-- Step 2: calculate the avarage of this sum

Table -- payment, sample:

| payment_id | customer_id | staff_id | rental_id | amount | payment_date                        |
|------------|-------------|----------|-----------|--------|--------------------------------------|
| 16618      | 571         | 1        | 228       | 9.99   | 2020-01-26 10:22:54.996577+01        |
| 16619      | 571         | 2        | 689       | 3.99   | 2020-01-29 00:15:19.996577+01        |
| 16620      | 572         | 2        | 559       | 7.99   | 2020-01-28 08:07:28.996577+01        |
| 16621      | 573         | 2        | 827       | 2.99   | 2020-01-29 21:27:09.996577+01        |
| 16622      | 574         | 2        | 433       | 0.99   | 2020-01-27 16:09:06.996577+01        |
| 16623      | 575         | 1        | 17        | 2.99   | 2020-01-25 00:35:02.996577+01        |
| 16624      | 575         | 1        | 395       | 0.99   | 2020-01-27 11:14:15.996577+01        |
*/

select
	avg(amount)
from payment;  -- this calculates the avarage of all "rows"

-- output report:
| avg |
| 4.2006673312979002|

-- vs |.  These two might seems produce same result as they all calculates average. But the # of elements
-- used to calcuate the avarage is difference. The first query uses all rows, which include duplicate
-- customer_id. The second query uses the number results from "group by customer_id", which eliminates
-- the duplicate customer_id, hence its base used for average is smaller.

select avg(total_amount)
from
	(select customer_id, sum(amount) as total_amount from payment
	group by customer_id) as subquery    -- this calculates average based on each customer_id.
	
-- output report:
| avg |
| 112.5484307178631052 |

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  
  /************************************** Problem 2 *******************************************/
/*
What is the average total amount spent per day (average daily revenue)
*/
select * from payment;

select round(avg(total_sum_per_day),2)
from 
(select 
	date(payment_date), 
	sum(amount) as total_sum_per_day 
from payment
group by date(payment_date)
) as subquery

-- output report:
| avg |
| 1644.31 |




