-- subquery used in "select" clause
-- use a subquery directly in the SELECT clause, SQL expects it to return only one value (one row, one column), hence, it is treated as a scalar subquery. 

select *, 
	(select amount from payment) -- WRONG!!! this is not allowed, since this subquery returns multiple value.
	                             -- we use subquery directly in select clause, hence SQL expects it to return a single value, not multiple values. 
from payment;

select *, 
	(select amount from payment limit 1) -- this is allowed, Noted that, a "single" value doesn't mean it returns 1 result, it means it has only one type of 
								                       -- value, such as it can return 1000 rows, but with only value $1.99
from payment

-- output report, sample:
  
| payment_id | customer_id | staff_id | rental_id | amount | payment_date                       | amount  |
|------------|-------------|----------|-----------|--------|-------------------------------------|---------|
| 16050      | 269         | 2        | 7         | 1.99   | 2020-01-24 22:40:19.996577+01       | 1.99    |
| 16051      | 269         | 1        | 98        | 0.99   | 2020-01-25 16:16:50.996577+01       | 1.99    |
| 16052      | 269         | 2        | 678       | 6.99   | 2020-01-28 22:44:14.996577+01       | 1.99    |
| 16053      | 269         | 2        | 703       | 0.99   | 2020-01-29 01:58:02.996577+01       | 1.99    |
| 16054      | 269         | 1        | 750       | 4.99   | 2020-01-29 09:10:06.996577+01       | 1.99    |
| 16055      | 269         | 2        | 1099      | 2.99   | 2020-01-31 13:23:14.996577+01       | 1.99    |

  
/************************************** Problem 1 *******************************************/
/*
Show all payments, and the difference between each payment with the max payment amount
*/
select *,
	(select max(amount) from payment)-amount as difference
from payment

---- output report, sample:
  
| payment_id | customer_id | staff_id | rental_id | amount | payment_date                       | difference |
|------------|-------------|----------|-----------|--------|-------------------------------------|------------|
| 16050      | 269         | 2        | 7         | 1.99   | 2020-01-24 22:40:19.996577+01       | 10.00      |
| 16051      | 269         | 1        | 98        | 0.99   | 2020-01-25 16:16:50.996577+01       | 11.00      |
| 16052      | 269         | 2        | 678       | 6.99   | 2020-01-28 22:44:14.996577+01       | 5.00       |
| 16053      | 269         | 2        | 703       | 0.99   | 2020-01-29 01:58:02.996577+01       | 11.00      |
| 16054      | 269         | 1        | 750       | 4.99   | 2020-01-29 09:10:06.996577+01       | 7.00       |
| 16055      | 269         | 2        | 1099      | 2.99   | 2020-01-31 13:23:14.996577+01       | 9.00       |

