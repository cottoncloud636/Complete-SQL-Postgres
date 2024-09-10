/*
subquery : a query within a query

Noted: 1) subquery can only return 1 col
*/



/************************ Problem 1 *******************************/
/*
return the amount from payment table only when the amount is bigger than average amount
*/
select 
	* 
from payment
where amount > (select avg(amount) from payment);

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  
/************************ Problem 2 *******************************/
/*
return the payment table only for customer_id has a matched first_name "ADAM" 	
*/
select
* 
from payment
where customer_id = (select customer_id from customer
					where first_name='ADAM');
					
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  
/************************ Problem 3 *******************************/
/*
return the payment table only for customer_id has matched name starts with letter A
*/
select
* 
from payment
where customer_id in (select customer_id from customer
					where first_name like 'A%')					

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

/************************ Problem 4 *******************************/
/*
Select all the films where length is longer than average of all films.
*/
  
Table -- film, sample:
  
| film_id | title              | description                                                                   | release_year | language_id | original_language_id | rental_duration | rental_rate | length |
|---------|--------------------|-------------------------------------------------------------------------------|--------------|-------------|----------------------|-----------------|-------------|--------|
| 1       | ACADEMY DINOSAUR    | A Epic Drama of a Feminist And a Mad Scientist who...                         | 2006         | 1           | [null]               | 6               | 0.99        | 86     |
| 2       | ACE GOLDFINGER      | A Astounding Epistle of a Database Administrator And a Secret Agent...        | 2006         | 1           | [null]               | 3               | 4.99        | 48     |
| 3       | ADAPTATION HOLES    | A Astounding Reflection of a Lumberjack And a Car Who...                      | 2006         | 1           | [null]               | 7               | 2.99        | 50     |
| 4       | AFFAIR PREJUDICE    | A Fanciful Documentary of a Frisbee And a Lumberjack...                       | 2006         | 1           | [null]               | 5               | 2.99        | 117    |
| 5       | AFRICAN EGG         | A Fast-Paced Documentary of a Pastry Chef And a...                            | 2006         | 1           | [null]               | 6               | 2.99        | 130    |
| 6       | AGENT TRUMAN        | A Intrepid Panorama of a Robot And a Boy who...                               | 2006         | 1           | [null]               | 3               | 2.99        | 169    |
| 7       | AIRPLANE SIERRA     | A Touching Saga of a Hunter And a Butler who...                               | 2006         | 1           | [null]               | 6               | 4.99        | 62     |
*/
  
select * from film;

select film_id, title from film
where length > (select avg(length) from film)

-- output report, sample:
  
| film_id | title           |
|---------|-----------------|
| 4       | AFFAIR PREJUDICE |
| 5       | AFRICAN EGG      |
| 6       | AGENT TRUMAN     |
| 11      | ALAMO VIDEOTAPE  |
| 12      | ALASKA PHANTOM   |
| 13      | ALI FOREVER      |
| 16      | ALLEY EVOLUTION  |

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

/******************************************* Problem 5 ********************************************/
/*
Select all the films that are available in inventory in store 2 more than 3 times.

Table -- film, sample:
  
| film_id | title              | description                                                                   | release_year | language_id | original_language_id | rental_duration | rental_rate | length |
|---------|--------------------|-------------------------------------------------------------------------------|--------------|-------------|----------------------|-----------------|-------------|--------|
| 1       | ACADEMY DINOSAUR    | A Epic Drama of a Feminist And a Mad Scientist who...                         | 2006         | 1           | [null]               | 6               | 0.99        | 86     |
| 2       | ACE GOLDFINGER      | A Astounding Epistle of a Database Administrator And a Secret Agent...        | 2006         | 1           | [null]               | 3               | 4.99        | 48     |
| 3       | ADAPTATION HOLES    | A Astounding Reflection of a Lumberjack And a Car Who...                      | 2006         | 1           | [null]               | 7               | 2.99        | 50     |
| 4       | AFFAIR PREJUDICE    | A Fanciful Documentary of a Frisbee And a Lumberjack...                       | 2006         | 1           | [null]               | 5               | 2.99        | 117    |
| 5       | AFRICAN EGG         | A Fast-Paced Documentary of a Pastry Chef And a...                            | 2006         | 1           | [null]               | 6               | 2.99        | 130    |
| 6       | AGENT TRUMAN        | A Intrepid Panorama of a Robot And a Boy who...                               | 2006         | 1           | [null]               | 3               | 2.99        | 169    |
| 7       | AIRPLANE SIERRA     | A Touching Saga of a Hunter And a Butler who...                               | 2006         | 1           | [null]               | 6               | 4.99        | 62     |

Table -- invenroty, sample:

| inventory_id | film_id | store_id | last_update              |
|--------------|---------|----------|--------------------------|
| 1            | 1       | 1        | 2020-02-15 11:09:17+01   |
| 2            | 1       | 1        | 2020-02-15 11:09:17+01   |
| 3            | 1       | 1        | 2020-02-15 11:09:17+01   |
| 4            | 1       | 1        | 2020-02-15 11:09:17+01   |
| 5            | 1       | 2        | 2020-02-15 11:09:17+01   |
| 6            | 1       | 2        | 2020-02-15 11:09:17+01   |

*/
select * from film; -- has film_id

select * from inventory; -- has inventory_id (PK), film_id, store_id

select film_id, title from film
where film_id in 
  (select film_id from inventory
	 where store_id=2 
   group by film_id 
   having count(*)>3
  )

-- output report, sample:

| film_id | title            |
|---------|------------------|
| 1       | ACADEMY DINOSAUR  |
| 3       | ADAPTATION HOLES  |
| 8       | AIRPORT POLLOCK   |
| 12      | ALASKA PHANTOM    |
| 13      | ALI FOREVER       |
| 15      | ALIEN CENTER      |

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

/******************************************* Problem 6.1 ********************************************/
/*
Return all customers' first_name, last_name that have made a payment on '2020-01-25'

Step 1: work on the subquery first (the payment)

Step 2: then connect with the main query (the customer)

Table -- customer, sample:

| customer_id | store_id | first_name | last_name | email                                | address_id | activebool |
|-------------|----------|------------|-----------|--------------------------------------|------------|------------|
| 1           | 1        | MARY       | SMITH     | MARY.SMITH@sakilacustomer.org        | 5          | true       |
| 2           | 1        | PATRICIA   | JOHNSON   | PATRICIA.JOHNSON@sakilacustomer.org  | 6          | true       |
| 3           | 1        | LINDA      | WILLIAMS  | LINDA.WILLIAMS@sakilacustomer.org    | 7          | true       |
| 4           | 2        | BARBARA    | JONES     | BARBARA.JONES@sakilacustomer.org     | 8          | true       |
| 5           | 1        | ELIZABETH  | BROWN     | ELIZABETH.BROWN@sakilacustomer.org   | 9          | true       |
  
Table -- payment, sample:

| payment_id | customer_id | staff_id | rental_id | amount | payment_date                        |
|------------|-------------|----------|-----------|--------|--------------------------------------|
| 16050      | 269         | 2        | 7         | 1.99   | 2020-01-24 22:40:19.996577+01        |
| 16051      | 269         | 1        | 98        | 0.99   | 2020-01-25 16:16:50.996577+01        |
| 16052      | 269         | 2        | 678       | 6.99   | 2020-01-28 22:44:14.996577+01        |
| 16053      | 269         | 2        | 703       | 0.99   | 2020-01-29 01:58:02.996577+01        |
| 16054      | 269         | 1        | 750       | 4.99   | 2020-01-29 09:10:06.996577+01        |
| 16055      | 269         | 2        | 1099      | 2.99   | 2020-01-31 13:23:14.996577+01        |
*/
select * from customer; -- has customer_id(PK), first_name, last_name

select * from payment; -- has payment_id (PK), customer_id, payment_date

select first_name, last_name
from customer
where customer_id IN   -- since the subquery returns a list, hence use "in"
	(select customer_id
	 from payment
	 where date(payment_date)='2020-01-25'
	 )

-- output report, sample:
  
| first_name | last_name |
|------------|-----------|
| MARY       | SMITH     |
| JENNIFER   | DAVIS     |
| MARIA      | MILLER    |
| CAROL      | GARCIA    |
| RUTH       | MARTINEZ  |
| SARAH      | LEWIS     |


/******************************************* Problem 6.2 ********************************************/
/*
Return all customers' first_name and email that have spent > $30

Step 1: work on the subquery first (the payment)

Step 2: then connect with the main query (the customer)
*/
select * from customer; -- has customer_id(PK), first_name, last_name

select * from payment; -- has payment_id (PK), customer_id, payment_date

select first_name, email
from customer
where customer_id IN 
	(select customer_id
	 from payment
   group by customer_id
	 having sum(amount)>30
	 )

-- output report, sample:
  
| first_name | email                              |
|------------|------------------------------------|
| MARY       | MARY.SMITH@sakilacustomer.org      |
| PATRICIA   | PATRICIA.JOHNSON@sakilacustomer.org|
| LINDA      | LINDA.WILLIAMS@sakilacustomer.org  |
| BARBARA    | BARBARA.JONES@sakilacustomer.org   |
| ELIZABETH  | ELIZABETH.BROWN@sakilacustomer.org |

  
/******************************************* Problem 6.3 ********************************************/
/*
Return all customers' first_name and last_name that are from California who have spent > $100 in total

Step 1: work on the subquery first (the payment)

Step 2: then connect with the main query (the customer)

Table -- address, sample:
  
| address_id | address                    | address2 | district   | city_id | postal_code | phone         | last_update              |
|------------|----------------------------|----------|------------|---------|-------------|---------------|--------------------------|
| 53         | 725 Isesaki Place           |          | Mekka      | 237     | 74428       | 876295323994  | 2020-02-15 10:45:30+01    |
| 54         | 115 Hidalgo Parkway         |          | Khartum    | 379     | 80168       | 307703950263  | 2020-02-15 10:45:30+01    |
| 55         | 1135 Izumisano Parkway      |          | California | 171     | 48150       | 171822533480  | 2020-02-15 10:45:30+01    |
| 56         | 939 Probolinggo Loop        |          | Galicia    | 1       | 4166        | 680428310138  | 2020-02-15 10:45:30+01    |
| 57         | 17 Kabul Boulevard          |          | Chiba      | 355     | 38594       | 697760867968  | 2020-02-15 10:45:30+01    |
| 58         | 1964 Allappuzha (Alleppey) Street |      | Yamaguchi | 227     | 48980       | 920811325222  | 2020-02-15 10:45:30+01    |

*/
  
select * from customer; -- has customer_id(PK), first_name, last_name, address_id

select * from payment; -- has payment_id (PK), customer_id, payment_date

select * from address; -- has address_id(PK), disctict, city_id

select first_name, last_name
from customer
where customer_id IN 
	(select customer_id
	 from payment
	 group by customer_id
	 having sum(amount)>100
	 )
and customer_id in 
	(select customer_id
	 from customer
	 inner join address
	 on customer.address_id = address.address_id
	 where district='California'
	 )

-- output report:

| first_name | last_name  |
|------------|------------|
| PATRICIA   | JOHNSON    |
| BETTY      | WHITE      |
| ALICE      | STEWART    |
| ROSA       | REYNOLDS   |
| KRISTIN    | JOHNSTON   |
| CASSANDRA  | WALTERS    |
| RENE       | MCALISTER  |







