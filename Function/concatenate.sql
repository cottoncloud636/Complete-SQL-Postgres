-- concatenate: ||


/******* Problem 1 ********/
/*
Write a single SQL query to concatenate the product name, category, and price into a single string for each product, formatted as: "Product Name - Category: Price". 
Use alias AS product_summary. Ensure the price is prefixed with a dollar sign ($), e.g. $1.99. Order the results by the product name in ascending order.

Table -- products
Columns: product_id, name, category, and price
*/
select 
    name ||' - '|| category ||': $'|| price as product_summary
from products
order by name


/******** Problem 2 ********/
/*
Create an anonymized version of email address. Such as John.Smith@sakilacustomer.org be replaced by J***@sakilacustomer.org
Use three ***
*/
select 
	left(email, 1) || '***' || right(email, 19) as anonymous_email
from customer
