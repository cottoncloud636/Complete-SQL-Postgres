/*
Union: to combine all the rows .

3 key points of union: 
	1) union matched two tables by the order of the col appears, it doesn't care about the col name,
 		hence, even cols with different names, union still works, it will use the first table's col being called.
	2) Order of cols, number of cols and datatype of cols from two tables must match
	3) If both Table A, B has a same record, this record will only appear once in outout report, 
	   unless using "UNION ALL".
*/

/********************************* problem 1 *********************************/
/*
Select all first name from both actor and customer, include duplicate values. Change the second col name in
output report as "first_table_name"
*/
select first_name, 'actor' as first_table_name from actor
union all
select first_name, 'customer' as has_no_effect from customer
order by first_name

--output report, sample:

| first_name | first_table_name |
|------------|------------------|
| AARON      | customer         |
| ADAM       | customer         |
| ADAM       | actor            |
| ADAM       | actor            |
| ADRIAN     | customer         |
| AGNES      | customer         |
