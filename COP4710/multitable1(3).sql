/* 
   Examples of multi-table queries, set operations (union, intersection),
   computed field, and aggregate functions
   for SQL Server 2005
*/

-- List the last name of the sales rep and the names of the associated customers
select Rep.LastName, Customer.CustomerName
from Rep INNER JOIN Customer
     ON Rep.RepNum = Customer.RepNum;

-- use of aliases
select r.LastName, c.CustomerName
from Rep r INNER JOIN Customer c
     ON r.RepNum = c.RepNum;

/*
   Use of INNER JOIN is not recommended
   Instead, specify the search (join) condition in the Where clause
*/
select r.LastName, c.CustomerName
from Rep r, Customer c
where r.RepNum = c.RepNum;


/*
   Find information about the sales rep who is associated with
     the customer Having customernum as 608.
*/

select rep.*
from rep, customer
where rep.repnum = customer.repnum  -- join condition
  and customer.customernum = '608';

select r.*
from rep r, customer c
where r.repnum = c.repnum
  and c.customernum = '608';

select *
from ReP
where Repnum = 
  ( select repnum
    from customer
    where customernum = '608');

select *
from ReP
where Repnum = any   -- SQL Server does not support "= any". Instead use "IN".
  ( select repnum
    from customer
    where customernum = '608'
       or customernum = '408');

select *
from ReP
where Repnum IN 
  ( select repnum
    from customer
    where customernum = '608'
       or customernum = '408');


-- Find the order number of orderlines for parts that are of the class SG
select OrderNum
from OrderLine
where PartNum =  -- this will work only if the nested query gives only one value
  ( select PartNum
    from Part
    where Class = 'SG');

select OrderNum
from OrderLine
where PartNum IN  -- this works even if the nested query gives several values
  ( select PartNum
    from Part
    where Class = 'SG');

select OrderNum
from OrderLine
where PartNum IN
  ( select PartNum
    from Part
    where Class = 'SG');

-- Same as the above query using exists condition
select OrderNum
from OrderLine OL
where exists
  ( select *
    from Part P
    where Class = 'SG'
      AND OL.PartNum = P.PartNum );


-- List the name of customers who placed order(s) for HW parts
select CustomerName
from Customer c, Orders os, OrderLine ol, Part p
where c.CustomerNum = os.CustomerNum
  and os.OrderNum = ol.OrderNum
  and ol.PartNum = p.Partnum
  and p.Class = 'HW';


select CustomerName
from Customer
where CustomerNum IN  -- nested loop
   ( select CustomerNum
     from Orders
     where OrderNum IN
	( select OrderNum
	  from OrderLine
	  where PartNum IN
	     ( select PartNum
		   from Part
		   where Class = 'HW' )));

-- demonstration of OR condition
select *
from ReP
where Repnum IN
  ( select repnum
    from customer
    where customernum = '608'
       or customernum = '408');

-- is equivalent to the set operation UNION
select *
from ReP
where Repnum IN
  ( select repnum
    from customer
    where customernum = '608')
UNION
select *
from ReP
where Repnum IN
  ( select repnum
    from customer
    where customernum = '408');

-- demonstration of the set operation Intersect
select *
from ReP
where Repnum IN
  ( select repnum
    from customer
    where customernum = '608'
      or  customernum = '408')
INTERSECT
select *
from ReP
where Repnum IN 
  ( select repnum
    from customer
    where customernum = '408');

-- demonstration of the set operation Difference
/* not implemented on SQL 2005
(select *
 from ReP
 where Repnum IN 
  ( select repnum
    from customer
    where customernum = '608'
      or  customernum = '408'))
DIFFERENCE
(select *
 from ReP
 where Repnum IN 
  ( select repnum
    from customer
    where customernum = '408'));
*/

-- computed field
select (CreditLimit - Balance)
from Customer;

select (CreditLimit - Balance) As 'Available Credit'
from Customer;

-- aggregate function (count, avg, sum, min, max, ...)
-- For each sales rep, list the rep's last name, no. of customers, and the total balance
select r.LastName As 'Rep LatName', count(*) As 'Customer Count', sum(c.Balance) As 'Total Balance'
from Rep r, Customer c
where r.RepNum = c.RepNum
group by r.LastName;


Select * from part;
-- The following query illustrates semantics of ALL
--  No row will be selected because in the equality comparison,
--   L.H.S. has only one value of warehouse
--   and R.H.S. has more than one value
select *
from part
where warehouse = ALL
   (select warehouse
    from part
    where onHand > 40)


/* 
  Correlated subquery:
     List the repnum that has a pair of customers
        who placed orders for the same part
*/

select RepNum
from Customer cA
where CustomerNum IN  -- nested loop
   ( select CustomerNum
     from Orders
     where OrderNum IN
	( select OrderNum
	  from OrderLine 
	  where PartNum IN
	     ( select PartNum
		   from OrderLine
		   where OrderNum IN
			( select OrderNum
			  from Orders
			  where CustomerNum IN
				( select CustomerNum
				  from Customer cB
				  where cB.CustomerNum != cA.CustomerNum
					and cB.RepNum = cA.RepNum)))));

