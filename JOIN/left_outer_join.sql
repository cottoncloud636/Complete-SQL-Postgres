-- LEFT OUTER JOIN : return every records in table A, include the intersection with table B, but do NOT include the records that are only in table B
-- basic syntax: 
				/* 
				SELECT * FROM TableA
				LEFT OUTER JOIN TableB  -- can be brief as LEFT JOIN
				ON TableA.employee = TableB.employee 
				*/
	
/**************************** Problem 1 *****************************/
/*
	Find out how many aircrafts have actually been used on flights mission 
	
	-- Logic: the question is asking # of aircraft from aircraft table can be found in flights table.

Table -- aircrafts_data, sample:

| aircraft_code | model                                                     | range |
|---------------|------------------------------------------------------------|-------|
| 773           | {"en": "Boeing 777-300", "ru": "Боинг 777-300"}             | 11100 |
| 763           | {"en": "Boeing 767-300", "ru": "Боинг 767-300"}             |  7900 |
| SU9           | {"en": "Sukhoi Superjet-100", "ru": "Сухой Суперджет-100"}  |  3000 |
| 320           | {"en": "Airbus A320-200", "ru": "Аэробус А320-200"}         |  5700 |

Table -- flights, sample:

| flight_id | flight_no | scheduled_departure      | scheduled_arrival        | departure_airport | arrival_airport | status    | aircraft_code |
|-----------|-----------|--------------------------|--------------------------|-------------------|-----------------|-----------|---------------|
| 1185      | PG0134    | 2017-09-09 23:50:00-07   | 2017-09-10 04:55:00-07   | DME               | BTK             | Scheduled | 319           |
| 3979      | PG0052    | 2017-08-25 04:50:00-07   | 2017-08-25 07:35:00-07   | VKO               | HMA             | Scheduled | CR2           |
| 4739      | PG0561    | 2017-09-05 02:30:00-07   | 2017-09-05 04:15:00-07   | VKO               | AER             | Scheduled | 763           |
| 5502      | PG0529    | 2017-09-11 23:50:00-07   | 2017-09-12 01:20:00-07   | SVO               | UFA             | Scheduled | 763           |

*/

select *
	from aircrafts_data
left outer join flights
on aircrafts_data.aircraft_code = flights.aircraft_code
where flights.flight_id is null

-- output report, sample:
  
| aircraft_code | model                                                                                      | range | flight_id | flight_no | scheduled_departure | scheduled_arrival | departure_airport | arrival_airport | status |
|---------------|---------------------------------------------------------------------------------------------|-------|-----------|-----------|---------------------|------------------|------------------|-----------------|--------|
| 320           | {"en": "Airbus A320-200", "ru": "Аэробус A320-200"}                                         | 5700  | NULL      | NULL      | NULL                | NULL             | NULL             | NULL            | NULL   |




	
/**************************** Problem 2 *****************************/
/*
	The flight company is trying to find out what their most popular seats are.
  Make sure all seats are included even if they have never been booked.
  
  Table -- seats, sample:

| aircraft_code | seat_no | fare_conditions |
|---------------|---------|-----------------|
| 319           | 2A      | Business        |
| 319           | 2C      | Business        |
| 319           | 2D      | Business        |
| 319           | 2F      | Business        |
| 319           | 3A      | Business        |
| 319           | 3C      | Business        |


 Table -- boarding_passes, sample:

| ticket_no      | flight_id | boarding_no | seat_no |
|----------------|-----------|-------------|---------|
| 0005435212351  | 30625     | 1           | 2D      |
| 0005435212386  | 30625     | 2           | 3G      |
| 0005435212381  | 30625     | 3           | 4H      |
| 0005432211370  | 30625     | 4           | 5D      |
| 0005435212357  | 30625     | 5           | 11A     |
| 0005435212360  | 30625     | 6           | 11E     |
*/
  
select right(s.seat_no, 1), count(*) from seats s
left join boarding_passes bp
on s.seat_no = bp.seat_no
group by right(s.seat_no, 1)
order by count(*) desc

-- output report, sample:

| right | count   |
|-------|---------|
| A     | 751,618 |
| D     | 652,188 |
| C     | 596,921 |
| F     | 467,493 |
| E     | 377,687 |
| B     | 280,289 |
| H     | 34,574  |
| G     | 34,552  |
