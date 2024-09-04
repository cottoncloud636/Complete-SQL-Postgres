/*
- calculate the total quantity sold and the total sale_amount for each category.
- return columns for the category, the sum of quantity as total_quantity, and the sum of sale_amount as total_sales_amount. 
- Order the results by total_sales_amount in descending order.
*/
select 
    category,
    sum (quantity) as total_quantity,
    sum (sale_amount) as total_sales_amount
    from sales_data
group by category
order by total_sales_amount desc;



/*
- Find out which of the two employees (staff_id) is responsible for more # of payments?
- Which of the two is responsible for a higher overall payment amount?
- Do not take $0 into account
*/
select 
	staff_id,
	sum (amount),
	count(*) -- count the # of payments(equivalent to count the staff_id that is returned
	         -- since staff_id is not unique, hence this count gives us the # of payment
			     -- that each staff has made)
from payment
group by staff_id -- in payment table, staff_id is not unique, while payment_id is



/****** group by multiple fields *******/

/*
- Create a query showing the total sales amount (AS total_sales_amount) and total number of items sold  (AS total_items_sold), grouped by category and sale_date. 
- Order the results by category in ascending order and then by sale_date in ascending order.
*/
select 
  category,
  sale_date,
  sum (amount) as total_sales_amount,
count (*) as total_items_sold
from sales
group by category, sale_date
order by category, sale_date


/*
Return a table where employee had the highest sales amount in a single day
(not counting payments with amount = 0
*/
select
  staff_id,
  sum (amount),
  Date(payment_date),
count (*) -- count the # of payments
from payment
where amount != 0
group by staff_id, Date(payment_date)
order by sum(amount) desc
