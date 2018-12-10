

----------------- Question 1  ----------------------

/* Rewrite the following query to present the same data in a horizontal format
   using the SQL PIVOT command. Your report should have the format listed below.
   
TerritoryID	2007-5-1	2007-5-2	2007-5-3	2007-5-4	2007-5-5
	1			22			1			2			1			1
	2			14			0			0			0			0
	3			15			0			0			0			0
	4			26			3			3			2			1
	5			19			0			0			0			0 
*/

SELECT TerritoryID, CAST(OrderDate AS DATE) [Order Date], COUNT(SalesOrderID) AS [Order Count]
FROM Sales.SalesOrderHeader
WHERE OrderDate BETWEEN '5-1-2007' AND '5-5-2007'
GROUP BY TerritoryID, OrderDate
ORDER BY TerritoryID, OrderDate;

-- Solution --

-- CHANGING CURRENT DB --
use AdventureWorks2012;

-- Query  --

SELECT TerritoryID, [2007-5-1], [2007-5-2], [2007-5-3], [2007-5-4], [2007-5-5]
FROM 
( SELECT TerritoryID, CAST(OrderDate AS DATE) [OrderDate], SalesOrderID
FROM Sales.SalesOrderHeader) AS SOURCETABLE
PIVOT 
(
 COUNT(SalesOrderID)
 FOR OrderDate IN ([2007-5-1], [2007-5-2], [2007-5-3], [2007-5-4], [2007-5-5])
) AS PIVOTTABLE;


------------------ Question 2 ----------------------

/* Write a query to retrieve the top two salespersons of each territory.
   Use the sum of TotalDue in SalesOrderHeader to determine the total sale amounts.
   The top 2 salespersons have the two highest total sale amounts. Your solution
   should retrieve a tie if there is any. The report should have the following format.

TerritoryID		Top2Salespersons
	1			David Campbell, Pamela Ansman-Wolfe
	2			Jillian Carson, Michael Blythe
	3			Jillian Carson, Michael Blythe
	4			Linda Mitchell, Shu Ito
	5			Tsvi Reiter, Michael Blythe   
*/

-- solution --
WITH Report1 AS
   (select sh.TerritoryID, P.FirstName,p.LastName, SUM(sh.TotalDue) ttl,
    rank() over (partition by sh.TerritoryID order by SUM(sh.TotalDue) desc) as Top2Salespersons
	from Sales.SalesOrderHeader sh
	join Person.Person P
	on sh.SalesPersonID = P.BusinessEntityID
    group by sh.TerritoryID, P.FirstName,p.LastName)

SELECT DISTINCT t2.TerritoryID, 
STUFF((SELECT  ', '+concat(t1.FirstName,' ',t1.LastName)
       FROM Report1 t1
       WHERE t1.TerritoryID = t2.TerritoryID and Top2Salespersons <=2
       FOR XML PATH('')) , 1, 2, '') AS Top2Salespersons
from Report1 t2
order by TerritoryID;


------------------------- Question 3  ----------------------

/* Use the function below, Sales.Customer and Person.Person to create a report.
   Include the CustomerID, LastName, FirstName, SalesOrderID, OrderDate and TotalDue
   columns in the report. Don't modify the function.
   Sort he report by CustomerID in descending. */

-- Get a customer's orders
create function dbo.ufGetCustomerOrders
(@custid int)
returns table
as return
select CustomerID, SalesOrderID, OrderDate, TotalDue
from AdventureWorks2012.Sales.SalesOrderHeader
where CustomerID=@custid;

-- Query 3 --

-- Changing DB --
use s_shravanthi_test;

-- query --
WITH PERSONCUST AS
(
SELECT c.CustomerID,
	  p.LastName,
	  p.FirstName
FROM AdventureWorks2012.Person.Person p 
join  AdventureWorks2012.Sales.Customer c
on p.BusinessEntityID = c.PersonID
)
select c.CustomerID,c.LastName,c.FirstName,fc.SalesOrderID,CAST(fc.OrderDate AS date) As [Order Date],fc.TotalDue
from PERSONCUST c
CROSS APPLY 
dbo.ufGetCustomerOrders(c.CustomerID) fc
ORDER BY fc.CustomerID DESC;



/* Given five tables as defined below for Questions 4 and 5 */

-- CREATING DB --
create database s_shravanthi_quiz2;

-- CHANGING CURRENT DB --
use s_shravanthi_quiz2;

CREATE TABLE Department
 (DepartmentID INT PRIMARY KEY,
  Name VARCHAR(50));

CREATE TABLE Employee
(EmployeeID INT PRIMARY KEY,
 LastName VARCHAR(50),
 FirsName VARCHAR(50),
 Salary DECIMAL(10,2),
 DepartmentID INT REFERENCES Department(DepartmentID),
 TerminateDate DATE);

CREATE TABLE Project
(ProjectID INT PRIMARY KEY,
 Name VARCHAR(50));

CREATE TABLE Assignment
(EmployeeID INT REFERENCES Employee(EmployeeID),
 ProjectID INT REFERENCES Project(ProjectID),
 StartDate DATE,
 EndDate DATE
 PRIMARY KEY (EmployeeID, ProjectID, StartDate));

CREATE TABLE SalaryAudit
(LogID INT IDENTITY,
 EmployeeID INT,
 OldSalary DECIMAL(10,2),
 NewSalary DECIMAL(10,2),
 ChangedBy VARCHAR(50) DEFAULT original_login(),
 ChangeTime DATETIME DEFAULT GETDATE());


------------------------- Question 4 ----------------------

/* There is a business rule that an employee can not work on more than
   five projects at the same time and a department can not have more
   than 10 employees working on the same project at the same time.
   Write a SINGLE table-level constraint to implement the rule. */

-- CREATING REQUIRED FUNCTIONS --
create function CheckProCount(@EmployeeID int)
RETURNS int
AS
BEGIN
	DECLARE @c int = 0;
	select @c = COUNT(ProjectID)
		from Assignment
		where EmployeeID = @EmployeeID
	Return @c;
END

create function CheckDECount(@EmployeeID int)
RETURNS int
AS
BEGIN
	DECLARE @c int = 0;
	declare @d varchar(30);
	SET @d=(select e.DepartmentID from Employee e where e.EmployeeID=@EmployeeID)
	select @c = COUNT(a.ProjectID)
		From Assignment a
		join Employee e
		on e.EmployeeID = a.EmployeeID
		where a.EmployeeID = @EmployeeID
		AND
		e.DepartmentID = @d;
	RETURN @c;
END

-- TABLE LEVEL CONSTRAINTS WITH THE 2 FUNCTIONS CREATED ABOVE --


ALTER TABLE Assignment ADD CONSTRAINT AssignmentRule CHECK (dbo.CheckProCount(EmployeeID) <= 5 and dbo.checkDEcount(EmployeeID) <10);

select * from Assignment;

------------------------- Question 5  ----------------------

/* There is a business rule if a salary adjustment is greater than 10000,
   the adjustment must be logged in the SalaryAudit table.
   Please write a trigger to implement the rule. Assume only one update
   takes place at a time. */

-- Creation of Trigger implementing business logic --

create trigger SalaryAdjustment
on SalaryAudit
after insert
AS
BEGIN
   if((select (i.newsalary-i.oldsalary) from inserted i)>10000)
   BEGIN
     insert into SalaryAudit
     values((select i.EmployeeID from inserted i),
     (select i.Oldsalary from inserted i),(select i.NewSalary from inserted i),(select i.ChangedBy from inserted i),(select i.ChangeTime from inserted i))
   END
  else
   BEGIN
     ROLLBACK
   END
END







