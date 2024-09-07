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



/******** Problem 4 ********/
/*
Create a tier list in the following way:
1. Rating is 'PG' or 'PG-13' or length is more then 210 min: 'Great rating or long (tier 1)
2. Description contains 'Drama' and length is more than 90min:  'Long drama (tier 2)'
3. Description contains 'Drama' and length is not more than 90min: 'Shcity drama (tier 3)'
4. Rental_rate less than $1: 'Very cheap (tier 4)'

If one movie can be in multiple categories it gets the higher tier assigned.

How can you filter to only those movies that appear in one of these 4 tiers?

Table -- film, sample:

| film_id | title              | description                                                                                     | release_year | language_id | original_language_id | rental_duration | rental_rate | length | replacement_cost | rating | last_update               | special_features                      | fulltext                                                        |
|---------|--------------------|-------------------------------------------------------------------------------------------------|--------------|-------------|----------------------|-----------------|-------------|--------|------------------|--------|---------------------------|---------------------------------------|-----------------------------------------------------------------|
| 1       | ACADEMY DINOSAUR    | A Epic Drama of a Feminist And a Mad Scientist who must Battle a Teacher in The Canadian Rockies | 2006         | 1           | NULL                 | 6               | 0.99        | 86     | 20.99            | PG     | 2020-09-10 18:46:03.905795 | {'Deleted Scenes','Behind the Scenes'} | 'academi':1 'dinosaur':2 'drama':5 'feminist':8 'mad':11 ...    |
| 2       | ACE GOLDFINGER      | A Astounding Epistle of a Database Administrator And a Explorer who must Find a Car in Ancient China | 2006         | 1           | NULL                 | 3               | 4.99        | 48     | 12.99            | G      | 2020-09-10 18:46:03.905795 | {'Trailers','Deleted Scenes'}         | 'ace':1 'administr':4 'ancient':7 'car':17 ...                 |
| 3       | ADAPTATION HOLES    | A Astounding Reflection of a Lumberjack And a Car who must Sink a Lumberjack in a Baloon Factory | 2006         | 1           | NULL                 | 7               | 2.99        | 50     | 18.99            | NC-17  | 2020-09-10 18:46:03.905795 | {'Trailers','Deleted Scenes'}         | 'adapt':1 'astound':4 'baloon':9 'car':11 ...                  |
| 4       | AFFAIR PREJUDICE    | A Fanciful Documentary of a Frisbee And a Lumberjack who must Chase a Monkey in A Shark Tank     | 2006         | 1           | NULL                 | 5               | 2.99        | 117    | 26.99            | G      | 2020-09-10 18:46:03.905795 | {'Commentaries','Behind the Scenes'}   | 'affair':1 'chase':16 'documentari':4 'frisbie':8 'monkey':16 ...|
*/

select 
	title,
	case
		when rating in ('PG', 'PG-13') or length>120 then 'Great rating or long (tier 1)'
		when description like '%Drama%' and length>90 then 'Long drama (tier 2)'
		when description like '%Drama%' and length<=90 then 'Shcity drama (tier 3)'
		when rental_rate<1.0 then 'Very cheap (tier 4)'
	end as tier_list
from film
/*where tier_list is not null*/ -- this is not allowed, 'where' can't use case-when alias
where 
	case
		when rating in ('PG', 'PG-13') or length>120 then 'Great rating or long (tier 1)'
		when description like '%Drama%' and length>90 then 'Long drama (tier 2)'
		when description like '%Drama%' and length<=90 then 'Shcity drama (tier 3)'
		when rental_rate<1.0 then 'Very cheap (tier 4)'
	end is not null

-- output report, sample:

| title            | tier_list                           |
|------------------|-------------------------------------|
| ACADEMY DINOSAUR | Great rating or long (tier 1)       |
| AFRICAN EGG      | Great rating or long (tier 1)       |
| AGENT TRUMAN     | Great rating or long (tier 1)       |
| AIRPLANE SIERRA  | Great rating or long (tier 1)       |
| ALABAMA DEVIL    | Great rating or long (tier 1)       |
| ALAMO VIDEOTAPE  | Great rating or long (tier 1)       |
| ALASKA PHANTOM   | Great rating or long (tier 1)       |
| DATE SPEED       | Very cheap (tier 4)                 |
| ALI FOREVER      | Great rating or long (tier 1)       |
| ALICE FANTASIA   | Long drama (tier 2)                 |
| ALIEN CENTER     | Shcity drama (tier 3)               |




















