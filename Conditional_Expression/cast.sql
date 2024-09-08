-- cast: convert current datatype to another datatype. Noted, not every datatype can be converted to each other
--       such as a string can't be converted to int


/******** Problem 1 ********/
/*
Get a report displaying return_date and rental_date, if return date is null, replace it with "not returned"

Table -- rental, sample:

| rental_id | rental_date              | inventory_id | customer_id | return_date              | staff_id | last_update              |
|-----------|--------------------------|--------------|-------------|--------------------------|----------|--------------------------|
| 2         | 2005-05-24 23:54:33+02   | 1525         | 459         | 2005-05-28 20:40:33+02   | 1        | 2020-02-16 03:30:53+01   |
| 3         | 2005-05-25 00:03:39+02   | 1711         | 408         | 2005-06-01 23:12:39+02   | 1        | 2020-02-16 03:30:53+01   |
| 4         | 2005-05-25 00:04:41+02   | 2452         | 333         | 2005-06-03 02:43:41+02   | 2        | 2020-02-16 03:30:53+01   |
| 5         | 2005-05-25 00:05:21+02   | 2079         | 222         | 2005-06-02 05:33:21+02   | 1        | 2020-02-16 03:30:53+01   |
*/
select
	rental_date,
	coalesce(cast(return_date as varchar), 'Not returned')
from rental
order by rental_date desc

-- output report, sample:
  
| rental_date              | coalesce                     |
|--------------------------|------------------------------|
| 2020-02-14 16:16:03+01   | Not returned                 |
| 2020-02-14 16:16:03+01   | Not returned                 |
| 2020-02-14 16:16:03+01   | Not returned                 |
| 2020-02-14 16:16:03+01   | Not returned                 |
| 2005-08-23 23:50:12+02   | 2005-08-30 02:01:12+02       |
| 2005-08-23 23:43:07+02   | 2005-08-31 22:33:07+02       |
| 2005-08-23 23:42:48+02   | 2005-08-25 03:48:48+02       |
| 2005-08-23 23:26:47+02   | 2005-08-27 19:02:47+02       |
| 2005-08-23 23:25:26+02   | 2005-08-26 00:54:26+02       |

