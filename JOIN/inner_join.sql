/* inner join : think of it as "intersection" of two sets by specifying the select (if not specifying any fields, then all cols from both tables will be combined, even the same fields, they will appear twice in new table)
   - 1. Find a reference column which both tables have in common
   - 2. Join the two tables. And all the columns from both tables will be combined to a new table.
      (unless specifies what specific columns I want to show in the "select" stage. If I don't specify and selects all, even the reference column will appear twice)
	  
   Noted: 1) if a record appears in one table but not the other, this record will not be appearred in new table
	      2) if in reference column, there are duplicate record, these duplicate record will be copied to
		     new table as they are, they will not be combined to a single record.

	Basic syntax: 
	      SELECT * FROM TableA    -- doesn't matter use table A or B here
		  INNER JOIN TableB
		  ON TableA.employee = TableB.employee  -- join by the common reference column




/***************************** Problem 1 **********************************/

select * from payment   -- since I select all columns from payment and inner join all columns from customer, hence all cols from both tables will be returned, even the same fields:customer_id, they will appear twice in new table)
inner join customer
on customer.customer_id = payment.customer_id

-- output report, sample:  Noted that customer_id appear twice in the new table

| payment_id | customer_id | staff_id | rental_id | amount | payment_date              | customer_id | store_id | first_name | last_name | email                                |
|------------|-------------|----------|-----------|--------|---------------------------|-------------|----------|------------|-----------|--------------------------------------|
| 16050      | 269         | 2        | 7         | 1.99   | 2020-01-24 22:40:19+01    | 269         | 1        | CASSANDRA  | WALTERS   | CASSANDRA.WALTERS@sakilacustomer.org |
| 16051      | 269         | 1        | 98        | 0.99   | 2020-01-25 16:16:50+01    | 269         | 1        | CASSANDRA  | WALTERS   | CASSANDRA.WALTERS@sakilacustomer.org |
| 16052      | 269         | 2        | 678       | 6.99   | 2020-01-28 22:44:14+01    | 269         | 1        | CASSANDRA  | WALTERS   | CASSANDRA.WALTERS@sakilacustomer.org |
| 16053      | 269         | 2        | 703       | 0.99   | 2020-01-29 01:58:02+01    | 269         | 1        | CASSANDRA  | WALTERS   | CASSANDRA.WALTERS@sakilacustomer.org |
| 16054      | 269         | 1        | 750       | 4.99   | 2020-01-29 09:10:06+01    | 269         | 1        | CASSANDRA  | WALTERS   | CASSANDRA.WALTERS@sakilacustomer.org |
| 16055      | 269         | 2        | 1099      | 2.99   | 2020-01-31 13:23:14+01    | 269         | 1        | CASSANDRA  | WALTERS   | CASSANDRA.WALTERS@sakilacustomer.org |
| 16056      | 270         | 1        | 193       | 1.99   | 2020-01-26 06:10:14+01    | 270         | 1        | LEAH       | CURTIS    | LEAH.CURTIS@sakilacustomer.org       |
| 16057      | 270         | 1        | 1040      | 4.99   | 2020-01-31 05:03:42+01    | 270         | 1        | LEAH       | CURTIS    | LEAH.CURTIS@sakilacustomer.org       |





/**************************** Problem 2 ********************************/
/*
select all fields from payment table, select first_name and last_name from customer table
combine them and display them onto one report

Table -- payments, sample:

| payment_id | customer_id | staff_id | rental_id | amount | payment_date               |
|------------|-------------|----------|-----------|--------|----------------------------|
| 16050      | 269         | 2        | 7         | 1.99   | 2020-01-24 22:40:19+01     |
| 16051      | 269         | 1        | 98        | 0.99   | 2020-01-25 16:16:50+01     |
| 16052      | 269         | 2        | 678       | 6.99   | 2020-01-28 22:44:14+01     |
| 16053      | 269         | 2        | 703       | 0.99   | 2020-01-29 01:58:02+01     |

Table -- customers, sample:

| customer_id | store_id | first_name | last_name | email                           | address_id | activebool | create_date | last_update               | active |
|-------------|----------|------------|-----------|---------------------------------|------------|------------|-------------|----------------------------|--------|
| 1           | 1        | MARY       | SMITH     | MARY.SMITH@sakilacustomer.org   | 5          | true       | 2020-02-14  | 2020-02-15 10:57:20+01     | 1      |
| 2           | 1        | PATRICIA   | JOHNSON   | PATRICIA.JOHNSON@sakilacustomer.org | 6          | true       | 2020-02-14  | 2020-02-15 10:57:20+01     | 1      |
| 3           | 1        | LINDA      | WILLIAMS  | LINDA.WILLIAMS@sakilacustomer.org | 7          | true       | 2020-02-14  | 2020-02-15 10:57:20+01     | 1      |
| 4           | 2        | BARBARA    | JONES     | BARBARA.JONES@sakilacustomer.org | 8          | true       | 2020-02-14  | 2020-02-15 10:57:20+01     | 1      |
*/

select 
	pmt.*, --use alias to refer to payment table
	first_name, -- doesn't need to reference which table, because both first and last name only appears in customer table, so the program knows which table it is 
	last_name
from payment pmt -- doesn't matter use customer or payment table here
inner join customer 
on pmt.customer_id = customer.customer_id

-- output report, sample:

| payment_id | customer_id | staff_id | rental_id | amount | payment_date                  | first_name | last_name |
|------------|-------------|----------|-----------|--------|-------------------------------|------------|-----------|
| 16050      | 269         | 2        | 7         | 1.99   | 2020-01-24 22:40:19.996577+01  | CASSANDRA  | WALTERS   |
| 16051      | 269         | 1        | 98        | 0.99   | 2020-01-25 16:16:50.996577+01  | CASSANDRA  | WALTERS   |
| 16052      | 269         | 2        | 678       | 6.99   | 2020-01-28 22:44:14.996577+01  | CASSANDRA  | WALTERS   |
| 16053      | 269         | 2        | 703       | 0.99   | 2020-01-29 01:58:02.996577+01  | CASSANDRA  | WALTERS   |
| 16054      | 269         | 1        | 750       | 4.99   | 2020-01-29 09:10:06.996577+01  | CASSANDRA  | WALTERS   |
| 16055      | 269         | 2        | 1099      | 2.99   | 2020-01-31 13:23:14.996577+01  | CASSANDRA  | WALTERS   |





/********************************** Problem 3 *******************************************/
  /*
	The airline company wants to understand in which category they sell most tickets.
	How many people choose seats in the category
	- Business - Economy or - Comfort?
	Work on the seats, flights and the boarding_passes tables.

-- Logics: 1) Starts from boarding_pass. Two reasons: 1. I want to count the # of passengers, the boarding_pass table provides this info by # of tickets sold. 2. This table shares common fields with other two tables.

Table -- seats, sample:                                  

| aircraft_code | seat_no | fare_conditions |          
|---------------|---------|-----------------|
| 319           | 2A      | Business        |
| 319           | 2C      | Business        |
| 319           | 2D      | Business        |
| 319           | 2F      | Business        |

Table -- flights, sample:      

| flight_id | flight_no | scheduled_departure     | scheduled_arrival       | departure_airport | arrival_airport | status    | aircraft_code |
|-----------|-----------|-------------------------|-------------------------|-------------------|-----------------|-----------|---------------|
| 1185      | PG0134    | 2017-09-09 23:50:00-07  | 2017-09-10 04:55:00-07  | DME               | BTK             | Scheduled | 319           |
| 3979      | PG0052    | 2017-08-25 04:50:00-07  | 2017-08-25 07:35:00-07  | VKO               | HMA             | Scheduled | CR2           |
| 4739      | PG0561    | 2017-09-05 02:30:00-07  | 2017-09-05 04:15:00-07  | VKO               | AER             | Scheduled | 763           |
| 5502      | PG0529    | 2017-09-11 23:50:00-07  | 2017-09-12 01:20:00-07  | SVO               | UFA             | Scheduled | 763           |

Table -- boarding_passes, sample:  

| ticket_no      | flight_id | boarding_no | seat_no |
|----------------|-----------|-------------|---------|
| 0005435212351  | 30625     | 1           | 2D      |
| 0005435212386  | 30625     | 2           | 3G      |
| 0005435212381  | 30625     | 3           | 4H      |
| 0005432211370  | 30625     | 4           | 5D      |
*/

/*denote: - I want to display fare_condition from seats from boarding_passes table, and count all rows from it
		later on I can group them.
		- then starts from boarding_passes, I will inner join three tables using their common field.
*/
select 
	seats.fare_conditions as "Fare Conditions",
	count(*) as count
	
from boarding_passes 
inner join -- first connect flights and board_passes, combine them to a new "flights" table, using flights
          -- table instead of boarding_pass is because I need to use this new flights to table to further join
		  -- with seats table
	/*boarding_passes on boarding_passes.flight_id = flights.flight_id*/ -- error: 
	flights on boarding_passes.flight_id = flights.flight_id 
inner join -- use "and" to make it more readable, but can replace by using two inner joins instead
    seats on flights.aircraft_code = seats.aircraft_code
	and boarding_passes.seat_no = seats.seat_no
	
group by seats.fare_conditions
order by count desc


-- output report:
| Fare Conditions | count  |
|-----------------|--------|
| Economy         | 510310 |
| Business        | 59479  |
| Comfort         | 9897   |












