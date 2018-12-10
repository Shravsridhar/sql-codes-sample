--- Problem 1 ---
USE s_shravanthi_test;

-- created return data in form of table --
CREATE FUNCTION dbo.TotalSales
(@year SmallINT, @month SmallINT)
RETURNS TABLE
AS
RETURN
(
	SELECT Distinct(t.Name) AS [NAME], SUM(h.TotalDue) AS [TotalSales]
	from AdventureWorks2012.Sales.SalesOrderHeader h
	join AdventureWorks2012.Sales.SalesTerritory t
	on t.TerritoryID = h.TerritoryID
	where DATEPART(year, h.OrderDate) = @year
	AND DATEPART(MONTH, h.OrderDate) = @month
	GROUP BY t.Name
	
) ;
GO
-- returns the totaldue for each territory -- 
SELECT * from dbo.TotalSales(2007,04) ;

-- to verify -- 
SELECT  DISTINCT t.Name, SUM(h.TotalDue) AS [Total]
	from AdventureWorks2012.Sales.SalesOrderHeader h
	join AdventureWorks2012.Sales.SalesTerritory t
	on t.TerritoryID = h.TerritoryID
	where DATEPART(year, h.OrderDate) = 2007
	AND DATEPART(MONTH, h.OrderDate) = 04
	GROUP BY t.Name	;

--- Problem 2 ---

-- creation of required table --
CREATE TABLE DateRange
(
DateID INT IDENTITY,
DateValue DATE,
DayOfWeek SMALLINT,
Week SMALLINT,
Month SMALLINT,
Quarter SMALLINT,
Year SMALLINT
);

-- Procedure creation --
CREATE PROCEDURE dbo.pop_daterange
(
		@StartDate datetime,
		@Count INT
)
AS
BEGIN 
	DECLARE @sd datetime, @c INT;
	SET @sd = @StartDate;
	SET @c =@Count ;
	DECLARE @Counter INT = 0;
	WHILE(@Counter< @c)
	BEGIN
		INSERT INTO DateRange VALUES(
			dateadd(day,@Counter,@sd),
   			DATEPART(WEEKDAY, dateadd(day,@Counter,@sd)),
			DATEPART(WEEK, dateadd(day,@Counter,@sd)),
			DATEPART(MONTH, dateadd(day,@Counter,@sd)),
			DATEPART(QUARTER, dateadd(day,@Counter,@sd)),
			DATEPART(YEAR, dateadd(day,@Counter,@sd)));
		SET @Counter += 1;
		END
		RETURN ;
END

-- executing the procedure --
EXEC dbo.pop_daterange @StartDate ='2006-04-02',@Count ='20'

-- to drop the procedure if required --
DROP PROC dbo.pop_daterange

-- to view the inserted data --
select * from DateRange ;


-- to delete the data if required --
delete from DateRange;

--- Probelm 3 ---

-- creation of required tables --
CREATE TABLE Customer
(CustomerID VARCHAR(20) PRIMARY KEY,
CustomerLName VARCHAR(30),
CustomerFName VARCHAR(30),
CustomerStatus VARCHAR(10));

CREATE TABLE SaleOrder
(OrderID INT IDENTITY PRIMARY KEY,
CustomerID VARCHAR(20) REFERENCES Customer(CustomerID),
OrderDate DATE,
OrderAmountBeforeTax INT);

CREATE TABLE SaleOrderDetail
(OrderID INT REFERENCES SaleOrder(OrderID),
ProductID INT,
Quantity INT,
UnitPrice INT,
PRIMARY KEY (OrderID, ProductID));

-- insert some values into tables created --
INSERT INTO Customer VALUES(1,'Xoe','Jin','ONLINE');
INSERT INTO SaleOrder VALUES(1,'2006-04-02',450);
INSERT INTO SaleOrderDetail VALUES(5,1,5,100);

-- trigger creation --
CREATE TRIGGER trig_wo_view
ON SaleOrderDetail
AFTER INSERT
AS
BEGIN
UPDATE SaleOrder 
set saleorder.OrderAmountBeforeTax=(select SUM(inserted.quantity*inserted.unitprice)
                                    from SaleOrderDetail
                                    join inserted
                                    on SaleOrderDetail.OrderID=inserted.OrderID
				    group by SaleOrderDetail.OrderID)
from inserted 
where SaleOrder.OrderID=inserted.orderID
END

go

-- to insert value into tables after trigger creation --
INSERT INTO Customer VALUES(2,'Lee','in','OFFLINE');
INSERT INTO SaleOrder VALUES(2,'2006-04-02',550);
INSERT INTO SaleOrderDetail VALUES(6,2,5,100);

-- to view updated table --
select * from SaleOrder;

-- to drop trigger --
drop trigger trig_wo_view 

--- Problem 4 ---
use AdventureWorks2012;

select DISTINCT
h.CustomerID,
p.FirstName,
p.LastName,
COUNT(SalesOrderID) AS [TotalOrders],
(SELECT COUNT(DISTINCT ProductID)
FROM Sales.SalesOrderDetail s
JOIN Sales.SalesOrderHeader h
ON s.SalesOrderID =h.SalesOrderID
WHERE c.CustomerID = h.CustomerID 
) AS [TotalProducts]
from 
Sales.SalesOrderHeader h
JOIN Sales.Customer c
ON h.CustomerID = c.CustomerID
JOIN Person.Person p
ON c.PersonID = p.BusinessEntityID
GROUP BY h.CustomerID, p.FirstName, p.LastName,c.CustomerID
ORDER BY CustomerID;

