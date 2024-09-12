-- correlated subquery in where : creates a dependency between the subquery and the outer query, and the subquery is evaluated once for each row of the outer query.

/*********************************************** Problem 1 ********************************************************/
/*
Show all information about these payments that have the highest amount per customer

-- denote: customer_id can be duplicate in payment table, for one customer, he can have multiple amount,
-- pick the highest amount for him. Do the same for rest of the customer, and return all these "highest"
-- amount from each custmer that I calculated.

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
select * from payment p1
where amount = 
	(select max(amount) from payment p2 
	 where p1.customer_id=p2.customer_id
	)
order by customer_id

-- output report, sample:

| payment_id | customer_id | staff_id | rental_id | amount | payment_date                       |
|------------|-------------|----------|-----------|--------|-------------------------------------|
| 18497      | 1           | 2        | 1476      | 9.99   | 2020-02-15 20:37:12.996577+01       |
| 29014      | 2           | 2        | 9236      | 10.99  | 2020-04-30 13:16:09.996577+02       |
| 29022      | 3           | 2        | 7503      | 10.99  | 2020-04-27 19:51:38.996577+02       |
| 22713      | 4           | 2        | 12294     | 8.99   | 2020-03-18 04:43:10.996577+01       |
| 22725      | 5           | 1        | 12145     | 9.99   | 2020-03-17 23:38:30.996577+01       |
| 22741      | 6           | 1        | 14329     | 7.99   | 2020-03-21 07:51:22.996577+01       |
| 29057      | 6           | 1        | 6248      | 7.99   | 2020-04-11 14:30:20.996577+02       |
| 29066      | 7           | 1        | 5441      | 8.99   | 2020-04-09 21:20:31.996577+02       |

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


/****************************** Problem 2.1 ******************************************/
/*
Show only those movie titles, their associated film_id and replacement_cost with the lowest replacement_costs
for each rating category – also show the rating.

Table -- film, sample:

| film_id | title             | description                                  | release_year | language_id | rental_duration | rental_rate | length | replacement_cost | rating |
|---------|-------------------|----------------------------------------------|--------------|-------------|-----------------|-------------|--------|------------------|--------|
| 1       | ACADEMY DINOSAUR  | A Epic Drama of a Feminist And a Mad ...      | 2006         | 1           | 6               | 0.99        | 86     | 20.99            | PG     |
| 2       | ACE GOLDFINGER    | A Astounding Epistle of a Database ...        | 2006         | 1           | 3               | 4.99        | 48     | 12.99            | G      |
| 3       | ADAPTATION HOLES  | A Astounding Reflection of a Lumberjack...    | 2006         | 1           | 7               | 2.99        | 50     | 18.99            | NC-17  |
| 4       | AFFAIR PREJUDICE  | A Fanciful Documentary of a Frisbee...        | 2006         | 1           | 5               | 2.99        | 117    | 26.99            | G      |
| 5       | AFRICAN EGG       | A Fast-Paced Documentary of a Pastry Chef...  | 2006         | 1           | 6               | 2.99        | 130    | 22.99            | G      |
| 6       | AGENT TRUMAN      | A Intrepid Panorama of a Robot And a Boy...   | 2006         | 1           | 3               | 2.99        | 169    | 17.99            | PG     |

*/
select title, film_id, replacement_cost, rating
from film f1
where replacement_cost=
	(select min(replacement_cost) from  film f2
	 where f1.rating = f2.rating
	)

-- output report, sample:
  
| title                     | film_id | replacement_cost | rating |
|---------------------------|---------|------------------|--------|
| ANACONDA CONFESSIONS       | 23      | 9.99             | R      |
| CIDER DESIRE               | 150     | 9.99             | PG     |
| CONTROL ANTHEM             | 182     | 9.99             | G      |
| DAISY MENAGERIE            | 203     | 9.99             | G      |
| DELIVERANCE MULHOLLAND     | 221     | 9.99             | R      |
| DUDE BLINDNESS             | 260     | 9.99             | G      |
| EDGE KISSING               | 272     | 9.99             | NC-17  |

  
/****************************** Problem 2.1 ******************************************/
/*
Show only those movie titles, their associated film_id and length with the highest length in each rating category also show the rating.
*/
select title, film_id, length, rating
from film f1
where length=
	(select max(length) from  film f2
	 where f1.rating = f2.rating
	)

-- output report, sample:

| title             | film_id | length | rating |
|-------------------|---------|--------|--------|
| CHICAGO NORTH      | 141     | 185    | PG-13  |
| CONTROL ANTHEM     | 182     | 185    | G      |
| CRYSTAL BREAKING   | 198     | 184    | NC-17  |
| DARN FORRESTER     | 212     | 185    | G      |
| GANGS PRIDE        | 349     | 185    | PG-13  |
| HOME PITY          | 426     | 185    | R      |
