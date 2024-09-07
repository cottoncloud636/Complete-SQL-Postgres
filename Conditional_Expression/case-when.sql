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


	
	
/******** Problem 3 ********/
/*
Find out how many flights have departed in the following seasons:
• Winter: December, January, Februar
• Spring: March, April, May
• Summer: June, July, August
• Fall: September, October, November

Table -- flights, sample:
	
| flight_id | flight_no | scheduled_departure | scheduled_arrival | departure_airport | arrival_airport | status     | aircraft_code | actual_departure | actual_arrival |
|-----------|-----------|---------------------|-------------------|-------------------|-----------------|------------|---------------|------------------|----------------|
| 1185      | PG0134    | 9/9/2017 23:50      | 9/10/2017 4:55    | DME               | BTK             | Scheduled  | 319           | NULL             | NULL           |
| 3979      | PG0052    | 8/25/2017 4:50      | 8/25/2017 7:35    | VKO               | HMA             | Scheduled  | CR2           | NULL             | NULL           |
| 4739      | PG0561    | 9/5/2017 2:30       | 9/5/2017 4:15     | VKO               | AER             | Scheduled  | 763           | NULL             | NULL           |
| 5502      | PG0529    | 9/11/2017 23:50     | 9/12/2017 1:20    | SVO               | UFA             | Scheduled  | 763           | NULL             | NULL           |

*/
select 
	count(*),
	case
		when extract(month from actual_departure) in (12,1,2) then 'Winter'
		when extract(month from actual_departure) in (3,4,5) then 'Spring'
		when extract(month from actual_departure) in (6,7,8) then 'Summer'
		else 'Fall'
	end as season_flights
from flights
group by season_flights

-- output report:
| number_departures | season_flights |
|-------------------|----------------|
| 16348             | "Fall"         |
| 16773             | "Summer"       |



