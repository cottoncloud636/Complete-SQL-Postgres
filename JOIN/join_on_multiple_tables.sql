-- join on mutiple tables : join more than 2 tables. Sometimes info can only be obtained by referencing multiple tables.


/***************************** Problem 1 ************************************/
/*
Write a query, display every single ticket including passenger name, the column of the scheduled departure.

Table -- tickets, sample:

| ticket_no        | book_ref | passenger_id | passenger_name   | contact_data                                 |
|------------------|----------|--------------|------------------|----------------------------------------------|
| 0005432000987    | 06B046   | 8149 604011  | VALERIY TIKHONOV | {"phone": "+70127117011"}                   |
| 0005432000988    | 06B046   | 8499 420203  | EVGENIYA ALEKSEEVA | {"phone": "+70378089255"}                  |
| 0005432000989    | E170C3   | 1011 752484  | ARTUR GERASIMOV   | {"phone": "+70760429203"}                  |
| 0005432000990    | E170C3   | 4849 400049  | ALINA VOLKOVA     | {"email": "volkova.alina@postgrespro.ru", "phone": "+70582584031"} |
| 0005432000991    | F313DD   | 6615 976589  | MAKSIM ZHUKOV     | {"email": "m-zhukov061972@postgrespro.ru", "phone": "+70149562185"} |
| 0005432000992    | F313DD   | 2021 652719  | NIKOLAY EGOROV    | {"phone": "+70791452932"}                   |

Table -- flights, sample:

| flight_id | flight_no | scheduled_departure      | scheduled_arrival        | departure_airport | arrival_airport | status     | aircraft_code |
|-----------|-----------|--------------------------|--------------------------|-------------------|-----------------|------------|---------------|
| 1185      | PG0134    | 2017-09-09 23:50:00-07   | 2017-09-10 04:55:00-07   | DME               | BTK             | Scheduled  | 319           |
| 3979      | PG0052    | 2017-08-25 04:50:00-07   | 2017-08-25 07:35:00-07   | VKO               | HMA             | Scheduled  | CR2           |
| 4739      | PG0561    | 2017-09-05 02:30:00-07   | 2017-09-05 04:15:00-07   | VKO               | AER             | Scheduled  | 763           |
| 5502      | PG0529    | 2017-09-11 23:50:00-07   | 2017-09-12 01:20:00-07   | SVO               | UFA             | Scheduled  | 763           |
| 6938      | PG0461    | 2017-09-04 02:25:00-07   | 2017-09-04 03:20:00-07   | SVO               | ULV             | Scheduled  | SU9           |
| 7784      | PG0667    | 2017-09-10 05:00:00-07   | 2017-09-10 07:30:00-07   | SVO               | KRO             | Scheduled  | CR2           |
| 9478      | PG0360    | 2017-08-27 23:00:00-07   | 2017-08-28 01:35:00-07   | LED               | REN             | Scheduled  | CR2           |
| 11085     | PG0569    | 2017-08-24 05:05:00-07   | 2017-08-24 06:10:00-07   | SVX               | SCW             | Scheduled  | 733           |

Table -- boarding_passes, sample:

| ticket_no        | flight_id | boarding_no | seat_no |
|------------------|-----------|-------------|---------|
| 0005435212351    | 30625     | 1           | 2D      |
| 0005435212386    | 30625     | 2           | 3G      |
| 0005435212381    | 30625     | 3           | 4H      |
| 0005432211370    | 30625     | 4           | 5D      |
| 0005435212357    | 30625     | 5           | 11A     |
| 0005435212360    | 30625     | 6           | 11E     |
| 0005435212393    | 30625     | 7           | 11H     |
| 0005435212374    | 30625     | 8           | 12E     |

*/

select * from tickets; -- has ticket_no(pk), passenger_name

select * from flights; -- has flight_id(pk), scheduled_departure

select * from boarding_passes; -- has ticket_no(pk) and flight_id(pk)

-- thought process: tickets table uses ticket_no(pk) --> find flight_id(pk) in boarding_passes --> bp connects
--     with flights table by using flight_id(pk) --> return scheduled_departure from flights table

select passenger_name, scheduled_departure
from tickets t 
inner join boarding_passes bp
on t.ticket_no = bp.ticket_no
inner join flights f
on f.flight_id = bp.flight_id

-- output report, sample:
  
| passenger_name        | scheduled_departure           |
|-----------------------|-------------------------------|
| ANDREY YAKOVLEV       | 2017-07-16 08:15:00-07        |
| VERONIKA TARASOVA     | 2017-07-16 08:15:00-07        |
| MIKHAIL VLASOV        | 2017-07-16 08:15:00-07        |
| VIOLETTA SIDOROVA     | 2017-07-16 08:15:00-07        |
| NINA KALININA         | 2017-07-16 08:15:00-07        |
| ELIZAVETA KOROLEVA    | 2017-07-16 08:15:00-07        |
| NATALIYA TITOVA       | 2017-07-16 08:15:00-07        |
| VLADIMIR NIKITIN      | 2017-07-16 08:15:00-07        |


/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


/***************************** Problem 2 ************************************/
/*
The company wants customize their campaigns to customers depending on the country they are from.
Write a query to get first_name, last_name, email and the country of all customers from Brazil.

-- thought process: 
   step 1. I need to display first_name, last_name, email and the country (specified to Brizil)
        Hence, find the tables that contains these fields
   step 2. connect tables:
        customer (address_id) --> address 
		    address (city_id) --> city
		    city(country_id --> country	

Table -- customer, sample:

| customer_id | store_id | first_name | last_name | email                              | address_id | activebool | create_date | last_update                | active |
|-------------|----------|------------|-----------|------------------------------------|------------|------------|-------------|-----------------------------|--------|
| 1           | 1        | MARY       | SMITH     | MARY.SMITH@sakilacustomer.org      | 5          | true       | 2020-02-14  | 2020-02-15 10:57:20+01      | 1      |
| 2           | 1        | PATRICIA   | JOHNSON   | PATRICIA.JOHNSON@sakilacustomer.org| 6          | true       | 2020-02-14  | 2020-02-15 10:57:20+01      | 1      |
| 3           | 1        | LINDA      | WILLIAMS  | LINDA.WILLIAMS@sakilacustomer.org  | 7          | true       | 2020-02-14  | 2020-02-15 10:57:20+01      | 1      |
| 4           | 2        | BARBARA    | JONES     | BARBARA.JONES@sakilacustomer.org   | 8          | true       | 2020-02-14  | 2020-02-15 10:57:20+01      | 1      |
| 5           | 1        | ELIZABETH  | BROWN     | ELIZABETH.BROWN@sakilacustomer.org | 9          | true       | 2020-02-14  | 2020-02-15 10:57:20+01      | 1      |
| 6           | 2        | JENNIFER   | DAVIS     | JENNIFER.DAVIS@sakilacustomer.org  | 10         | true       | 2020-02-14  | 2020-02-15 10:57:20+01      | 1      |

Table -- country, sample:
  
| country_id | country        | last_update                |
|------------|----------------|----------------------------|
| 1          | Afghanistan    | 2020-02-15 10:44:00+01     |
| 2          | Algeria        | 2020-02-15 10:44:00+01     |
| 3          | American Samoa | 2020-02-15 10:44:00+01     |
| 4          | Angola         | 2020-02-15 10:44:00+01     |
| 5          | Anguilla       | 2020-02-15 10:44:00+01     |
| 6          | Argentina      | 2020-02-15 10:44:00+01     |

Table -- city, sample:

| city_id | city               | country_id | last_update                |
|---------|--------------------|------------|----------------------------|
| 1       | A Corua (La Corua)  | 87         | 2020-02-15 10:45:25+01     |
| 2       | Abha               | 82         | 2020-02-15 10:45:25+01     |
| 3       | Abu Dhabi          | 101        | 2020-02-15 10:45:25+01     |
| 4       | Acua               | 60         | 2020-02-15 10:45:25+01     |
| 5       | Adana              | 97         | 2020-02-15 10:45:25+01     |
| 6       | Addis Abeba        | 31         | 2020-02-15 10:45:25+01     |

Table -- address, sample:
  
| address_id | address              | address2 | district  | city_id | postal_code | phone        | last_update                |
|------------|----------------------|----------|-----------|---------|-------------|--------------|----------------------------|
| 1          | 47 MySakila Drive     | [null]   | Alberta   | 300     | 14033335568 | 14033335568  | 2020-02-15 10:45:30+01     |
| 2          | 28 MySQL Boulevard    | [null]   | QLD       | 576     | 6172235589  | 6172235589   | 2020-02-15 10:45:30+01     |
| 3          | 23 Workhaven Lane     | [null]   | Alberta   | 300     | 14033335568 | 14033335568  | 2020-02-15 10:45:30+01     |
| 4          | 1411 Lillydale Drive  | [null]   | QLD       | 576     | 28303384290 | 28303384290  | 2020-02-15 10:45:30+01     |
| 5          | 1913 Hanoi Way        | [null]   | Nagasaki  | 463     | 28303384290 | 28303384290  | 2020-02-15 10:45:30+01     |
| 6          | 1121 Loja Avenue      | [null]   | California| 449     | 838635286649| 838635286649 | 2020-02-15 10:45:30+01     |

*/

select * from customer; -- has customer_id(pk), store_id, address_id, first_name, last_name, email 

select * from country; -- has country_id(pk), country

select * from city; -- has city_id(pk), country_id

select * from address; -- has address_id(pk), city_id

select first_name, last_name, email, country.country
from customer c
inner join address addr
on c.address_id = addr.address_id
inner join city
on addr.city_id = city.city_id
inner join country
on city.country_id = country.country_id
where country.country = 'Brazil'

-- output report, sample:

| first_name | last_name | email                                  | country |
|------------|-----------|----------------------------------------|---------|
| CLAYTON    | BARBEE    | CLAYTON.BARBEE@sakilacustomer.org       | Brazil  |
| JOSEPH     | JOY       | JOSEPH.JOY@sakilacustomer.org          | Brazil  |
| TAMARA     | NGUYEN    | TAMARA.NGUYEN@sakilacustomer.org        | Brazil  |
| NATALIE    | MEYER     | NATALIE.MEYER@sakilacustomer.org        | Brazil  |
| JANE       | BENNETT   | JANE.BENNETT@sakilacustomer.org         | Brazil  |
| ANTONIO    | MEEK      | ANTONIO.MEEK@sakilacustomer.org         | Brazil  |

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


/******************************************* Problem 3 ************************************************/
/*
Which passenger (passenger_name) has spent most amount in their bookings (total_amount)?

Step 1: What info do I need to display? Ans: passenger_name, booking amount

Step 2: Which tables contain these info? Ans: tickets, bookings

Step 3: How to connect these two tables? Ans: tickets (book_ref) --> bookings(book_ref)

Table -- tickets, sample:

| ticket_no      | book_ref | passenger_id | passenger_name      | contact_data                                          |
|----------------|----------|--------------|---------------------|-------------------------------------------------------|
| 0005432000987  | 06B046   | 8149 604011  | VALERIY TIKHONOV     | {"phone": "+70127117011"}                              |
| 0005432000988  | 06B046   | 8499 420203  | EVGENIYA ALEKSEEVA   | {"phone": "+70378089255"}                              |
| 0005432000989  | E170C3   | 1011 752484  | ARTUR GERASIMOV      | {"phone": "+70760429203"}                              |
| 0005432000990  | E170C3   | 4849 400049  | ALINA VOLKOVA        | {"email": "volkova.alina_03101973@postgrespro.ru",     |
|                |          |              |                     |  "phone": "+70582584031"}                              |

Table -- bookings, sample:

| book_ref | book_date              | total_amount |
|----------|------------------------|--------------|
| 00000F   | 2017-07-04 17:12:00-07 | 265700.00    |
| 000012   | 2017-07-13 23:02:00-07 | 37900.00     |
| 000068   | 2017-08-15 04:27:00-07 | 18100.00     |
| 000181   | 2017-08-10 03:28:00-07 | 131800.00    |
*/
  
select * from tickets; -- has ticket_no(PK), book_ref, passenger_id, passenger_name, 

select * from bookings; -- has book_ref, total_amount

select t.passenger_name, sum(b.total_amount)
from tickets t
inner join bookings b
on t.book_ref = b.book_ref
group by passenger_name
order by sum(b.total_amount) desc

-- output report, sample:
  
| passenger_name     | sum          |
|--------------------|--------------|
| ALEKSANDR IVANOV   | 80964000.00  |
| ALEKSANDR KUZNECOV | 70425600.00  |
| SERGEY IVANOV      | 55244200.00  |
| SERGEY KUZNECOV    | 51056500.00  |
| VLADIMIR IVANOV    | 48491000.00  |
| ALEKSANDR POPOV    | 45141600.00  |


