-- correlated subquery in select 

/***************************************** Problem 1 **********************************************/
/*
Display the max amount spent for every customer of each their payment

Table -- payment, sample:

| payment_id | customer_id | staff_id | rental_id | amount | payment_date                       |
|------------|-------------|----------|-----------|--------|-------------------------------------|
| 16050      | 269         | 2        | 7         | 1.99   | 2020-01-24 22:40:19.996577+01       |
| 16051      | 269         | 1        | 98        | 0.99   | 2020-01-25 16:16:50.996577+01       |
| 16052      | 269         | 2        | 678       | 6.99   | 2020-01-28 22:44:14.996577+01       |
| 16053      | 269         | 2        | 703       | 0.99   | 2020-01-29 01:58:02.996577+01       |
| 16054      | 269         | 1        | 750       | 4.99   | 2020-01-29 09:10:06.996577+01       |
| 16055      | 269         | 2        | 1099      | 2.99   | 2020-01-31 13:23:14.996577+01       |

*/
select
	*,
	(select max(amount) from payment p2
	 where p1.customer_id = p2.customer_id
	)
from payment p1
order by customer_id

-- output report, sample:
  
| payment_id | customer_id | staff_id | rental_id | amount | payment_date                       | max   |
|------------|-------------|----------|-----------|--------|-------------------------------------|-------|
| 16677      | 1           | 1        | 76        | 2.99   | 2020-01-25 10:59:03.996577+01       | 9.99  |
| 16678      | 1           | 1        | 573       | 0.99   | 2020-01-28 10:03:49.996577+01       | 9.99  |
| 18495      | 1           | 1        | 1185      | 5.99   | 2020-02-15 00:22:38.996577+01       | 9.99  |
| 18496      | 1           | 2        | 1422      | 0.99   | 2020-02-15 17:31:19.996577+01       | 9.99  |
| 18497      | 1           | 2        | 1476      | 9.99   | 2020-02-15 20:37:12.996577+01       | 9.99  |
| 18498      | 1           | 1        | 1725      | 4.99   | 2020-02-16 14:47:23.996577+01       | 9.99  |
| 18499      | 1           | 1        | 2308      | 4.99   | 2020-02-18 08:10:14.996577+01       | 9.99  |

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

/***************************************** Problem 2 **********************************************/
/*
Show all payments and the total amount for every customer as well as the number of payments of each customer
*/
select * from payment

select 
	payment_id,
	customer_id,
	staff_id,
	amount,
	(select sum(amount) as sum_amount
	 from payment p2 
	 where p1.customer_id = p2.customer_id
	),
	(select count(amount) as payment_count
	 from payment p2
	 where p1.customer_id = p2.customer_id
	)
from payment p1
order by customer_id, amount desc

--output report, sample:
	
| payment_id | customer_id | staff_id | amount | sum_amount | payment_count |
|------------|-------------|----------|--------|------------|---------------|
| 18497      | 1           | 2        | 9.99   | 118.68     | 32            |
| 28997      | 1           | 1        | 7.99   | 118.68     | 32            |
| 28993      | 1           | 2        | 5.99   | 118.68     | 32            |
| 28994      | 1           | 1        | 5.99   | 118.68     | 32            |
| 18495      | 1           | 1        | 5.99   | 118.68     | 32            |
| 22690      | 1           | 1        | 5.99   | 118.68     | 32            |

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

/***************************************** Problem 3 **********************************************/
/*
show only the highest replacement costs for each rating and their average

-- 1) max replacement_cost for EACH rating
   2) average replacement_cost for EACH rating

Table -- film, sample:
| film_id | title             | description                                   | release_year | language_id | rental_duration | rental_rate | length | replacement_cost | rating |
|---------|-------------------|-----------------------------------------------|--------------|-------------|-----------------|-------------|--------|------------------|--------|
| 1       | ACADEMY DINOSAUR  | A Epic Drama of a Feminist And a Mad ...       | 2006         | 1           | 6               | 0.99        | 86     | 20.99            | PG     |
| 2       | ACE GOLDFINGER    | A Astounding Epistle of a Database ...         | 2006         | 1           | 3               | 4.99        | 48     | 12.99            | G      |
| 3       | ADAPTATION HOLES  | A Astounding Reflection of a Lumberjack...     | 2006         | 1           | 7               | 2.99        | 50     | 18.99            | NC-17  |
| 4       | AFFAIR PREJUDICE  | A Fanciful Documentary of a Frisbee...         | 2006         | 1           | 5               | 2.99        | 117    | 26.99            | G      |
*/
select 
	film_id,
	title,
	replacement_cost,
	rating,
	(select avg(replacement_cost) 
	 from film f2
	 where f1.rating = f2.rating
	)
from film f1
where
	replacement_cost=
	(select max(replacement_cost) 
	 from film f3
	 where f1.rating = f3.rating
	)

--output report, sample:

| film_id | title               | replacement_cost | rating | avg                |
|---------|---------------------|------------------|--------|--------------------|
| 34      | ARABIA DOGMA         | 29.99            | NC-17  | 20.1376190476190476 |
| 52      | BALLROOM MOCKINGBIRD | 29.99            | G      | 20.1248314606741573 |
| 81      | BLINDNESS GUN        | 29.99            | PG-13  | 20.4025560538116592 |
| 85      | BONNIE HOLOCAUST     | 29.99            | G      | 20.1248314606741573 |
| 138     | CHARIOTS CONSPIRACY  | 29.99            | R      | 20.2310256410256410 |
| 157     | CLOCKWORK PARADISE   | 29.99            | PG-13  | 20.4025560538116592 |

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

/*********************************************** Problem 4.1 **********************************************/
/*
show only those payments with the highest payment for each customer's first name - including the payment_id of that payment
	
-- 1) max payment for each customer
   2) display first_name, payment_id
-- payment table : has payment_id, customer_id, amount
-- customer table : has customer_id, first_name
*/
select 
	c.first_name, 
	p1.payment_id,
	p1.amount
from payment p1
inner join customer c
on p1.customer_id = c.customer_id

where amount = 
	(select max(amount) from payment p2
	where p1.customer_id = p2.customer_id
	)
	
-- output report, sample:
	
| first_name | payment_id | amount |
|------------|------------|--------|
| MARY       | 18497      | 9.99   |
| PATRICIA   | 29014      | 10.99  |
| LINDA      | 29022      | 10.99  |
| BARBARA    | 22713      | 8.99   |
| ELIZABETH  | 22725      | 9.99   |
| JENNIFER   | 22741      | 7.99   |
| JENNIFER   | 29057      | 7.99   |
	
/*********************************************** Problem 4.2 **********************************************/
/*
show only those payments with the highest payment for each customer's first name - but do not include the payment_id of that payment
	
-- 1) max payment for each customer
   2) display first_name
-- payment table : has customer_id, amount
-- customer table : has customer_id, first_name
*/
select 
	c.first_name, 
	max(amount)
from payment p1
inner join customer c
on p1.customer_id = c.customer_id
group by first_name

--output report, sample:
	
| first_name | max  |
|------------|------|
| RANDALL    | 8.99 |
| PETER      | 9.99 |
| MARTHA     | 6.99 |
| BONNIE     | 8.99 |
| ALLEN      | 8.99 |
| PATRICIA   | 10.99|


