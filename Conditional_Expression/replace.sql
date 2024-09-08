-- replace

/******** Problem 1 ********/
/*
Convert passenger_id to bigint, and display it

Table -- tickets, sample:

| ticket_no         | book_ref | passenger_id (character varying(20)) | passenger_name (text)      | contact_data (jsonb)                                                          |
|-------------------|----------|--------------------------------------|----------------------------|-------------------------------------------------------------------------------|
| 0005432000987     | 06B046   | 8149 604011                         | VALERIY TIKHONOV            | {"phone": "+70127117011"}                                                     |
| 0005432000988     | 06B046   | 8499 420203                         | EVGENIYA ALEKSEEVA          | {"phone": "+70378089255"}                                                     |
| 0005432000989     | E170C3   | 1011 752484                         | ARTUR GERASIMOV             | {"phone": "+70760429203"}                                                     |
| 0005432000990     | E170C3   | 4849 400049                         | ALINA VOLKOVA               | {"email": "volkova.alina_03101973@postgrespro.ru", "phone": "+70582584035"}   |

*/
select
cast(replace(passenger_id, ' ', '') as bigint) as passenger_id
from tickets

--output report, sample:
  
| passenger_id (bigint) |
|-----------------------|
| 8149604011            |
| 8499420203            |
| 1011752484            |
| 4849400049            |
| 6615976589            |
| 2021652719            |
| 817363231             |
| 2883989356            |
