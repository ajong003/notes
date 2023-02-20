
-- Find the customer number and credit limit of customers with balance > 3000
Select CustomerNum, CreditLimit
From customer
Where balance > 3000

-- SQL-Server: Store the result of a Select statement into a new table
Select CustomerNum, CreditLimit
INTO ValuedCustomer
From customer
Where balance > 3000

-- XAMPP - MariaDB: Store the result of a Select statement into a new table
CREATE TABLE ValuedCustomer
Select CustomerNum, CreditLimit
From customer
Where balance > 3000

-- XAMPP - MariaDB: Add the result of a Select statement into an existing table
INSERT INTO ValuedCustomer
Select CustomerNum, CreditLimit
From customer
Where balance > 3000

-- adding a new row to a table
INSERT INTO Customer
VALUES
('950','All Season','28 Lakeview','Grove','FL','33321',8221.00,7500.00,'80');

-- delete rows that satisfy a given criteria
DELETE FROM Customer
WHERE CustomerNum = '950';

-- modify the value of an attribute of rows that satisfy a condition
update Customer
set city = 'Miami'
where customernum ='408';

-- remove a table object
drop table orderline;

-- The following delete query violates a data reference
-- If this custoemr is deleted, the order 21614 will have an invalid customer
DELETE FROM customer
WHERE zip = '33321'  and repnum = '35' 

select * from customer

select * from Orders where customernum = '282'

select * from orderline where ordernum = '21614'

-- Since no table references the following orderline, there is no violation
--  when the following delete queries are executed
DELETE FROM orderline
WHERE ordernum = '21614'

DELETE FROM orders
WHERE customernum = '282'

DELETE FROM customer
WHERE zip = '33321'  and repnum = '35'

-- Change or Alter the database structure
ALTER TABLE customer
ADD EnrollDate char(10);

ALTER TABLE customer
ADD Gender char(1)
CONSTRAINT GenderCheck
CHECK (Gender IN ('F','M'));

ALTER TABLE customer
DROP COLUMN EnrollDate;

ALTER TABLE customer
DROP CONSTRAINT GenderCheck;
ALTER TABLE customer
DROP COLUMN Gender;

ALTER TABLE customer
ALTER COLUMN zip char(9);

ALTER TABLE customer
ALTER COLUMN zip char(5);

-- Removal of Customer table is invalid since Orders table refers to Customer table
drop table customer

-- The following sequence of queries work correctly
--  as the referencing tables are removed in the correct order
drop table orderline

drop table orders

drop table customer

create table student
( pantherID char(7) not null,
  stdName varchar(30) 
);


alter table student
add major char(4);

alter table student
alter column major char(8);

drop table student;


