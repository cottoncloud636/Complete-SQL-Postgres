-- Left, Right
-- used to extract certain part of the string

/******** problem 1 ********/
/*
Extract the last 5 characters of the email address first.
The email address always ends with '.org'.
How can you extract just the dot '.' from the email address?
*/
select 
  right(email,5)
from customer;

select
  left(right(email,4),1)
from customer
