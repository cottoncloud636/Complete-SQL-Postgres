-- right outer join : is essentially the same as left outer join (by reverving the order of table). Hence, most of the time, use left outer join is enough.
-- basic syntax:
            /*

                SELECT * FROM TableA
                RIGHT OUTER JOIN TableB
                ON TableA.employee = TableB.employee
   
    this is equivalent to:

                SELECT * FROM TableB
                LEFT OUTER JOIN TableA
                ON TableA.employee = TableB.employee
                  
-- How to identify which is left or right table? Ans: The table mentioned before the JOIN keyword is the left table. The table mentioned after the JOIN keyword is the right table.

Based on left or right keyword, knowing which table is the main table, then:
- if left join, then include everything for left table, put null in "items in right table but not in left table"
- if right join, then include everything for right table, put null "items in left table but not in right table"
*/


/***************************** Problem 1.1 ********************************/
/*
The company wants to run a phone call campaing on all customers in Texas (=district).
What are the customers (first_name, last_name, phone number and their district) from Texas?

Table -- address, sample:

| address_id | address                | address2 | district | city_id | postal_code | phone      | last_update           |
|------------|------------------------|----------|----------|---------|-------------|------------|-----------------------|
| 1          | 47 MySakila Drive       | [null]   | Alberta  | 300     | 140335568   | 140335568  | 2020-02-15 10:45:30+01|
| 2          | 28 MySQL Boulevard      | [null]   | QLD      | 576     | 6172235589  | 6172235589 | 2020-02-15 10:45:30+01|
| 3          | 23 Workhaven Lane       | [null]   | Alberta  | 300     | 140335568   | 1403355689 | 2020-02-15 10:45:30+01|
| 4          | 1411 Lillydale Drive    | [null]   | QLD      | 576     | 6172235589  | 6172235589 | 2020-02-15 10:45:30+01|
| 5          | 1913 Hanoi Way          | [null]   | Nagasaki | 463     | 35200       | 2830384290 | 2020-02-15 10:45:30+01|
| 6          | 1121 Loja Avenue        | [null]   | California|449     | 17886       | 8386352849 | 2020-02-15 10:45:30+01|
| 7          | 692 Joliet Street       | [null]   | Attika   | 38      | 83579       | 4484771940 | 2020-02-15 10:45:30+01|
| 8          | 1566 InegI Manor        | [null]   | Mandalay | 349     | 53561       | 705814003527|2020-02-15 10:45:30+01|

Table -- customer, sample:

| customer_id | store_id | first_name | last_name  | email                           | address_id | activebool | create_date | last_update            | active |
|-------------|----------|------------|------------|---------------------------------|------------|------------|-------------|------------------------|--------|
| 1           | 1        | MARY       | SMITH      | MARY.SMITH@sakilacustomer.org   | 5          | true       | 2020-02-14  | 2020-02-15 10:57:20+01 | 1      |
| 2           | 1        | PATRICIA   | JOHNSON    | PATRICIA.JOHNSON@sakilacustomer.org| 6       | true       | 2020-02-14  | 2020-02-15 10:57:20+01 | 1      |
| 3           | 1        | LINDA      | WILLIAMS   | LINDA.WILLIAMS@sakilacustomer.org | 7        | true       | 2020-02-14  | 2020-02-15 10:57:20+01 | 1      |
| 4           | 2        | BARBARA    | JONES      | BARBARA.JONES@sakilacustomer.org| 8         | true       | 2020-02-14  | 2020-02-15 10:57:20+01 | 1      |
| 5           | 2        | ELIZABETH  | BROWN      | ELIZABETH.BROWN@sakilacustomer.org| 9        | true       | 2020-02-14  | 2020-02-15 10:57:20+01 | 1      |
| 6           | 2        | JENNIFER   | DAVIS      | JENNIFER.DAVIS@sakilacustomer.org| 10       | true       | 2020-02-14  | 2020-02-15 10:57:20+01 | 1      |

*/

select 
	c.customer_id,
	first_name,
	last_name,
	phone,
	district
from customer c
left join address a
on c.address_id = a.address_id
where district = 'Texas'

-- output report: 

| customer_id | first_name | last_name | phone         | district |
|-------------|------------|-----------|---------------|----------|
| 6           | JENNIFER   | DAVIS     | 860452626434  | Texas    |
| 118         | KIM        | CRUZ      | 909029256431  | Texas    |
| 305         | RICHARD    | MCCRARY   | 262088367001  | Texas    |
| 400         | BRYAN      | HARDISON  | 775235029633  | Texas    |
| 561         | IAN        | STILL     | 239357986667  | Texas    |


*/

/***************************** Problem 1.2 ********************************/
/* Are there any (old) addresses that are not related to any customer?
*/
select * from address a
left join customer c
on c.address_id = a.address_id
where c.customer_id is null

-- output report: 
| address_id | address             | address2 | district | city_id | postal_code | phone        | last_update           |
|------------|---------------------|----------|----------|---------|-------------|--------------|-----------------------|
| 2          | 28 MySQL Boulevard  | [null]   | QLD      | 576     | [null]      | 6172235589   | 2020-02-15 10:45:30+01 |
| 4          | 1411 Lillydale Drive | [null]   | QLD      | 576     | [null]      | 6172235589   | 2020-02-15 10:45:30+01 |
| 1          | 47 MySakila Drive    | [null]   | Alberta  | 300     | [null]      | 14033335568  | 2020-02-15 10:45:30+01 |
| 3          | 23 Workhaven Lane    | [null]   | Alberta  | 300     | [null]      | 14033335568  | 2020-02-15 10:45:30+01 |
