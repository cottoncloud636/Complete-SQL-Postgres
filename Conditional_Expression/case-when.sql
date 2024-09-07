-- case when, equivalent to multiple if/else statements
-- basic syntax: 
/* CASE
WHEN condition1 THEN result1
WHEN condition2 THEN result2
WHEN conditionN THEN resultN
ELSE result
END
*/


/******** Problem 1 ********/
/*
Using the sales_orders table, write a SQL query to select the order_id, product_id, quantity, unit_price, and a new column named total_price. 
The total_price should be calculated as follows: 
- If a customer orders more than 1 unit of any product, they get a 10% discount on the total price for those products before adding the shipping fee.
The total_price should include the shipping fee.
You must use CASE WHEN to calculate the discounted price where applicable.

Table -- sales_orders
Columns -- order_id, product_id, quantity, unit_price, shipping_fee
*/
select
  order_id,
  product_id,
  quantity,
  unit_price,
case
    when quantity>1 then (quantity*unit_price*0.9) + shipping_fee
    else quantity*unit_price + shipping_fee
end as total_price
from sales_orders


/******** Problem 2 ********/
/*
Find out how many tickets have sold in the following categories:
• Low price ticket: total_amount < 20,000
• Mid price ticket: total_amount between 20,000 and 150,000
• High price ticket: total_amount >= 150,000
How many high price tickets has the company sold?
*/
select
	case
		when total_amount<20000 then 'Low price ticket' 
		when total_amount<150000 then 'Mid price ticket'
		else 'High price ticket'
	end as price_ticket,
	
	count(*) as count_ticket -- "count" originally count EVERY row in the table, but because of "group by"
	                         -- it only display the count of "price_ticket"
	
from bookings	
group by price_ticket
order by count_ticket

