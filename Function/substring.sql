-- substring: used to extract a substring from a string. First index starts from 1.
-- basic syntax: SUBSTRING (string from start [for length] ). 
-- denote syntax: string--original string, start--starting position, length--#of chars we want to extract
 
/******** Problem 1, method 1********/
/* substract the last name from email address*/
select 
	email,
	substring (email from position('.' in email)+1 for length(last_name)) as last_name
from customer;


/******** Problem 1, method 2********/
/* substract the last name from email address */
/* case: when length of the last_name is not available */
-- idea: substract the "." position from the "@" position to get the length of last_name
select 
	email,
	substring (email from position('.' in email)+1 for position('@' in email) - position('.' in email)-1) as last_name
from customer


/******** Problem 2 ********/
/*
create an anonymized form of email, for ex: M***.S***@sakilacustomer.org
*/
select
	left(email, 1) || '***' || substring(email from position('.' in email) for 2) || '***'
	|| substring(email, position('@' in email))
from customer;


/******** Problem 3 ********/
/*
create an anonymized form of email, for ex: ***Y.S***@sakilacustomer.org
*/
select
	'***' 
	|| substring(email from position('.' in email)-1 for 3)
	|| '***' 
	|| substring(email from position('@' in email))
from customer
