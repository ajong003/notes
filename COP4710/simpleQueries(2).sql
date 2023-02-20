/*
  This is a simple select query
  It has only two clauses
*/

Select CustomerNum, CreditLimit
From customer;

-- single line comment
Select CreditLimit
From customer;

Select distinct CreditLimit  -- removes duplicate rows
From customer;

Select CustomerNum, CreditLimit
From customer
Where RepNum = '65' and balance > 3000; -- Row selection condition

Select CustomerNum, CreditLimit -- error: The list is not an aggregate value
From customer
Where balance > 3000
Group by repnum;

Select RepNum, Max(CreditLimit), count(*) -- The list has aggregate values
From customer
Where balance > 3000
Group by repnum;  -- subgrouping attribute


Select RepNum, Max(CreditLimit), count(*)
From customer
Where balance > 3000
Group by repnum
Having count(*) > 1; -- subgroup selection condition

Select RepNum, Max(CreditLimit), count(*) as MemberCount
From customer
Where balance > 3000
Group by repnum
Having count(*) > 1
Order by MemberCount Asc; -- sort the select list


select creditlimit, count(*)
from customer
group by creditLimit

select count(*)
from orders;

select count(*)
from orderline;

select count(*)
from Orders, Orderline; -- cross join (relational algebra product) of tables

select *
from Orders, Orderline;

