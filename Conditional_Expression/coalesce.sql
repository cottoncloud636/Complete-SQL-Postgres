-- coalesce: Returns first value of a list of values which is not null
-- basic syntax: two format: 
   -- COALESCE (actual_arrival, scheduled_arrival), denote: search the value in actual_arrival column, if hit null, then use the first non-null value from schedule_arrival column
   -- COALESCE (actual_arrival, '1970-01-01 0:00'), denote: search the value in actual_arrival column, if hit null, then use this fix value: '1970-01-01 0:00', 
                                                    -- be aware, the data type of this fix value needs to the same as actual_arrival data type                 


/********* Problem 1 ********/
/*
Write a SQL query to retrieve all transactions, displaying the transaction ID, account ID, transaction type, amount, and description.
For any transactions that do not have a description, display 'Not Provided' in place of the NULL value. Ensure your query is ordered by the transaction ID. 
Make sure to not forget to use the alias description.

Table -- transactions:

| transaction_id | account_id | transaction_type | amount | description         |
|----------------|------------|------------------|--------|---------------------|
| 1              | 1001       | Deposit           | 500    | Salary              |
| 2              | 1002       | Withdrawal        | 200    | ATM Withdrawal      |
| 3              | 1003       | Deposit           | 1500   | null                |
| 4              | 1001       | Deposit           | 450    | Freelance Payment   |
| 5              | 1002       | Withdrawal        | 100    | null                |
*/
select
  *,
  coalesce(description, 'Not Provided') as description
from transactions
order by transaction_id

-- output report:
| transaction_id | account_id | transaction_type | amount | description         |
|----------------|------------|------------------|--------|---------------------|
| 1              | 1001       | Deposit           | 500    | Salary              |
| 2              | 1002       | Withdrawal        | 200    | ATM Withdrawal      |
| 3              | 1003       | Deposit           | 1500   | Not Provided        |
| 4              | 1001       | Deposit           | 450    | Freelance Payment   |
| 5              | 1002       | Withdrawal        | 100    | Not Provided        |
