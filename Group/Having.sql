****** Problem 1 ******
/* 
Find the cities with more than two transactions where the average transaction amount exceeds $150.00. List the city and the average transaction amount (AS AverageAmount), 
sorted by the average transaction amount in descending order.

Table -- Sales
Columns -- City, Amount, TransactionID
*/
SELECT 
    City, 
    AVG(Amount) AS AverageAmount
FROM Sales
GROUP BY City -- hint text: "cities with more than two transactions", means I need to group by each city to verify if each
              -- one has more than two transactions.
HAVING COUNT(TransactionID) > 2 -- hint: always base on and follow "GROUP BY"
    AND AVG(Amount) > 150.00
ORDER BY AVG(Amount) DESC;  


****** Problem 2 ******
-- Having can only be used on Group By
/*
In 2020, April 28, 29 and 30 were days with very high revenue.
Fosuc on these days (filter accordingly).
Find out what is the average payment amount grouped by
customer and day – consider only the days/customers with
more than 1 payment (per customer and day).
Order by the average amount in a descending order.

Table -- payment
Columns -- payment_id,	customer_id,	staff_id,	rental_id	amount,	payment_date
*/

   -- Date: 2020-04-28, 2020-04-29, 2020-04-30
   -- Find: avg amount (grouped by customer, day)
      -- focus on per customers and day with > 1 payment
   -- order by avg amount dsc

/* take aways:
- "between" and "in" both refer to a range, but "between" defines a contiguous range,
  it capture all value. While "in" is used to specify a list of specific values
  
*/
   
select 
	customer_id,
	round (avg (amount), 2) as AverageAmount,
	Date (payment_date),
	count(*)
from payment
where Date(payment_date) in( '2020-04-28', '2020-04-29', '2020-04-30')
group by customer_id, Date(payment_date)
having count(*)>1
order by avg(amount) desc

