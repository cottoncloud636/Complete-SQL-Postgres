/*
Write a SQL query to find all reviews for product_id = 101 where the review text contains the word "great" (case insensitive), and order the results by the length of the review text (from shortest to longest).
Return the review_id, review_text, and the length of the review_text (use alias review_length).

Table -- customer_reviews
*/
select
  review_id,
  review_text,
  length (review_text) as review_length
from customer_reviews
where product_id=101 
      and review_text like '%great%'
order by length(review_text)

  

/*
In the email system there was a problem with names where either the first name or the last name is more than 10 characters long.
Find these customers and output the list of these first and last names in all lower case.

Table -- customer
Columns -- customer_id, store_id, first_name, last_name, email, address_id, activebool, create_date, last_update, active
*/

select 
	lower(first_name),
	lower(last_name),
	lower(email)
from customer
where length(first_name) > 10
	or length(last_name) > 10
