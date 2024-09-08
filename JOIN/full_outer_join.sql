-- FULL OUTER JOIN : combines all rows and all columns from both tables, if missing any info, then use null to fill it
-- think about two sets union, include everything from both sets including the duplicate part

/************************* Problem 1 *****************************/
/* Find out how many tickets has no boarding pass related to them 

-- Logics: to find out tickets with no bp associate to it, it must match ticket_id from tickets with ticket_id from boarding_pass
           So what I need to find? I need to find the # of tickets in tickets, then use them to match in boarding_pass table,
		   hence, in FULL OUTER JOIN clause, I use tickets table

Table -- boarding_passes, sample:

| ticket_no      | flight_id | boarding_no | seat_no |
|----------------|-----------|-------------|---------|
| 0005435212351  | 30625     | 1           | 2D      |
| 0005435212386  | 30625     | 2           | 3G      |
| 0005435212381  | 30625     | 3           | 4H      |
| 0005432211370  | 30625     | 4           | 5D      |
| 0005435212357  | 30625     | 5           | 11A     |
| 0005435212360  | 30625     | 6           | 11E     |

Table -- tickets, sample:

| ticket_no      | book_ref | passenger_id | passenger_name     | contact_data                                            |
|----------------|----------|--------------|--------------------|---------------------------------------------------------|
| 0005432000987  | 06B046   | 8149604011   | VALERIY TIKHONOV    | {"phone": "+70127117011"}                               |
| 0005432000988  | 06B046   | 8499420203   | EVGENIYA ALEKSEEVA  | {"phone": "+70378089255"}                               |
| 0005432000989  | E170C3   | 1011752484   | ARTUR GERASIMOV     | {"phone": "+70760429203"}                               |
| 0005432000990  | E170C3   | 4849400049   | ALINA VOLKOVA       | {"email": "volkova.alina_03101973@postgrespro.ru", "phone": "+7058258403"} |
| 0005432000991  | F313DD   | 6615976589   | MAKSIM ZHUKOV       | {"email": "m-zhukov061972@postgrespro.ru", "phone": "+7058258403"} |
| 0005432000992  | F313DD   | 2021652719   | NIKOLAY EGOROV      | {"phone": "+70791452932"}                               |

*/
SELECT count(*) as "Tickets with no boarding pass"
FROM boarding_passes b -- use bp as a primary table
FULL OUTER JOIN tickets t -- join with tickets table, and see # of tickets_no that can't be matched in bp table
ON b.ticket_no = t.ticket_no 
where b.ticket_no is null;

-- output report:
| Tickets with no boarding pass |
| 127988 |
