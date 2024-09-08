--use sum on the case-when

/******** Problem 1 ********/
/*
Count number of each rating.
Output report should be in this format: use each rating as field name, each rating count as record

Table -- film, sample:

| film_id | title              | description                                                                                     | release_year | language_id | original_language_id | rental_duration | rental_rate | length | replacement_cost | rating | last_update               | special_features                      | fulltext                                                        |
|---------|--------------------|-------------------------------------------------------------------------------------------------|--------------|-------------|----------------------|-----------------|-------------|--------|------------------|--------|---------------------------|---------------------------------------|-----------------------------------------------------------------|
| 1       | ACADEMY DINOSAUR    | A Epic Drama of a Feminist And a Mad Scientist who must Battle a Teacher in The Canadian Rockies | 2006         | 1           | NULL                 | 6               | 0.99        | 86     | 20.99            | PG     | 2020-09-10 18:46:03.905795 | {'Deleted Scenes','Behind the Scenes'} | 'academi':1 'dinosaur':2 'drama':5 'feminist':8 'mad':11 ...    |
| 2       | ACE GOLDFINGER      | A Astounding Epistle of a Database Administrator And a Explorer who must Find a Car in Ancient China | 2006         | 1           | NULL                 | 3               | 4.99        | 48     | 12.99            | G      | 2020-09-10 18:46:03.905795 | {'Trailers','Deleted Scenes'}         | 'ace':1 'administr':4 'ancient':7 'car':17 ...                 |
| 3       | ADAPTATION HOLES    | A Astounding Reflection of a Lumberjack And a Car who must Sink a Lumberjack in a Baloon Factory | 2006         | 1           | NULL                 | 7               | 2.99        | 50     | 18.99            | NC-17  | 2020-09-10 18:46:03.905795 | {'Trailers','Deleted Scenes'}         | 'adapt':1 'astound':4 'baloon':9 'car':11 ...                  |
| 4       | AFFAIR PREJUDICE    | A Fanciful Documentary of a Frisbee And a Lumberjack who must Chase a Monkey in A Shark Tank     | 2006         | 1           | NULL                 | 5               | 2.99        | 117    | 26.99            | G      | 2020-09-10 18:46:03.905795 | {'Commentaries','Behind the Scenes'}   | 'affair':1 'chase':16 'documentari':4 'frisbie':8 'monkey':16 ...|
*/
-- note: when use alias AS xxx, if no quote around xxx, then it defaults to lowercase and doesn't allow
-- space in between the name when output report. If want to customize the alias further, add "xxx" quote
-- around xxx, to add space, or captalized the letter.
select 
	sum(case when rating='G' then 1 else 0 end) as "G", -- if rating==G, then add 1 to the sum, else don't increment(add 0). And rename this sum to field name 'G'
	sum(case when rating='PG' then 1 else 0 end) as "PG",
	sum(case when rating='R' then 1 else 0 end) as "R",
	sum(case when rating='NC-17' then 1 else 0 end) as "NC-17",
	sum(case when rating='PG-13' then 1 else 0 end) as "PG-13"
from film

-- output report:
| G   | PG  | R   | NC-17 | PG-13 |
|-----|-----|-----|-------|-------|
| 178 | 194 | 195 | 210   | 223   |


/******** Problem 2 ********/
/* 
Write a single SQL query to calculate the total income and total expenses from the transactions table.
Additionally, calculate the net income (total income - total expenses) as a separate column in the result.
Use aliases for the total income, total expenses, and net income as TotalIncome, TotalExpenses, and NetIncome, respectively.

| id | amount | transaction_date | category |
|----|--------|------------------|----------|
| 1  | 1000   | 2024-01-10       | Income   |
| 2  | 200    | 2024-02-15       | Expense  |
| 3  | 1500   | 2024-02-20       | Income   |
| 4  | 300    | 2024-03-05       | Expense  |
| 5  | 450    | 2024-03-12       | Expense  |
| 6  | 1800   | 2024-03-15       | Income   |
*/
select
    sum(case when category='Income' then amount else 0 end) as "TotalIncome",
    sum(case when category='Expense' then amount else 0 end) as "TotalExpenses",
    /*TotalIncome - TotalExpense as "NetIncome"*/ -- this is wrong. Can NOT use TotalIncome and TotalExpense before they are fully calculated, because they are under "select" sectiion.
    sum(case when category='Income' then amount else -amount end) as "NetIncome"
from transactions

-- output report:
| TotalIncome | TotalExpenses | NetIncome |
|-------------|---------------|-----------|
| 4300        | 950           | 3350      |


