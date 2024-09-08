-- FULL OUTER JOIN : combines all rows and all columns from both tables, if missing any info, then use null to fill it
-- think about two sets union, include everything from both sets including the duplicate part

/************************* Problem 1 *****************************/
/* Find out how many tickets has no boarding pass related to them 

-- Logics: to find out tickets with no bp associate to it, it must match ticket_id from tickets with ticket_id from boarding_pass
           So what I need to find? I need to find the # of tickets in tickets, then use them to match in boarding_pass table,
		   hence, in FULL OUTER JOIN clause, I use tickets table
*/
SELECT count(*) as "Tickets with no boarding pass"
FROM boarding_passes b -- use bp as a primary table
FULL OUTER JOIN tickets t -- join with tickets table, and see # of tickets_no that can't be matched in bp table
ON b.ticket_no = t.ticket_no 
where b.ticket_no is null;
