-- position: search a char's position in a field

/*
Given only email address and last name of the customers, extract the first_name from
the email address and concatenate it with last_name. Return format is: "last_name, first_name"
*/
select 
	-- denote: search email address from very left, until hit '.' and stop
	 last_name || ', '|| left(email, position('.' in email)-1)
from customer
