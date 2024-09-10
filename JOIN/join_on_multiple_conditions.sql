-- join on mutiple conditions on two tables: sometimes join on single field is not enough, need to join use multiple fields

/*
Get the average ticket price for different seat_no

Table -- ticket_flights, sample:

| ticket_no      | flight_id | fare_conditions | amount    |
|----------------|-----------|-----------------|-----------|
| 0005432159776  | 30625     | Business        | 42100.00  |
| 0005435212351  | 30625     | Business        | 42100.00  |
| 0005435212386  | 30625     | Business        | 42100.00  |
| 0005435212381  | 30625     | Business        | 42100.00  |
| 0005432211370  | 30625     | Business        | 42100.00  |
| 0005435212357  | 30625     | Comfort         | 23900.00  |

Table -- boarding_passes, sample:

| ticket_no      | flight_id | boarding_no | seat_no |
|----------------|-----------|-------------|---------|
| 0005432002042  | 7945      | 18          | 30F     |
| 0005432002042  | 28956     | 11          | 6C      |
| 0005432002043  | 7945      | 10          | 17E     |
| 0005432002043  | 28956     | 13          | 7C      |
| 0005432002044  | 7989      | 18          | 27B     |
| 0005432002044  | 28993     | 27          | 18F     |
| 0005432002045  | 7989      | 6           | 10B     |
| 0005432002045  | 28993     | 3           | 2A      |
| 0005432002046  | 8123      | 3           | 9D      |
*/
select * from ticket_flights -- has price info, and ticket_no <-> flight_id, but contains duplicate ticket_no
order by ticket_no;

select * from boarding_passes -- has seat info <-> flight_id <-> ticket_no, but contains duplicate ticket_no
order by ticket_no;


-- thought process: 
-- step 1: don't jump into calculating the final result, instead, first join the tables:
select * from boarding_passes bp
left join ticket_flights t
on bp.ticket_no = t.ticket_no
 and bp.flight_id = t.flight_id

-- step 2: then observe what do I want to get from this joined table (in this case, I want average amount and differenct seat no:
select seat_no, round(avg(amount),2) as average_amount from boarding_passes bp
left join ticket_flights t
on bp.ticket_no = t.ticket_no
 and bp.flight_id = t.flight_id
group by bp.seat_no
order by average_amount desc

-- output report, sample:
  
| seat_no | average_amount |
|---------|----------------|
| 5H      | 74172.71       |
| 3H      | 73142.12       |
| 4H      | 72860.74       |
| 1H      | 72611.32       |
| 5G      | 72577.87       |
| 2H      | 72378.04       |
| 1G      | 72238.69       |
| 4G      | 70721.56       |


