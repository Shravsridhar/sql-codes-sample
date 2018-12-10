--- Part A ---

-- database creation 
create database s_shravanthi_test;
GO
use s_shravanthi_test;

-- table creation for representing student course registration 

-- table creation of student, professor,course,prof_course,course_student
create table dbo.student 
( studentid int constraint pk_students primary key,
  fname varchar(40) not null,
  lname varchar(40) not null,
  department varchar(50) not null,
  year int not null,
  email varchar(50) not null
)

create table dbo.professor(
profID int constraint pk_profid primary key,
profname varchar(40) not null) 

create table dbo.course(
courseno int constraint pk_cno primary key,
course_name varchar(50) not null)

create table dbo.prof_course( 
courseno int primary key,
profID int ,
foreign key(courseno) references course,
foreign key(profID) references professor
)

create table dbo.course_student(studentid int, 
courseno int,
foreign key(studentid) references student, 
foreign key(courseno) references course, 
primary key(studentid,courseno)
)

-- Values insertion into the tables created

insert into student values (1,'xiyu','lee','cse',2012,'xile@gmail.com');
insert into student values (2,'aksh','roy','ece',2015,'aroy@gmail.com');

insert into course values(5210,'Database');
insert into course values(7210,'Data Mining');
insert into course values(7361,'Deep learning');
 
insert into professor values(12,'Wupin Wang');
insert into professor values(14,'Choun Chu');
insert into professor values(15,'Bhuvan');

insert into course_student values(1,5210);
insert into course_student values(2,7361);

insert into prof_course values (5210,12);
insert into prof_course values (7210,14);

-- extra column added in student table 
alter table dbo.student 
add phoneno int ;

-- alter of data type for column profname from professor table
alter table dbo.professor 
alter column profname varchar(60);

-- alter of data type for column fname and lname from student table
alter table dbo.student
alter column fname varchar(30);

alter table dbo.student
alter column lname varchar(30);

-- updation of column profname from professor table
update dbo.professor
set profname = 'Bhuvan Gates'
where profID = 15 ;

-- display of prof name as prof first name and last name
Select  profID AS [Professor ID],
    LTRIM(RTRIM(SUBSTRING(profname, 0, CHARINDEX(' ', profname)))) As [First Name]
,   LTRIM(RTRIM(SUBSTRING(profname, CHARINDEX(' ', profname)+1, 100)))As [Last Name]
FROM dbo.professor;

-- view creation to display the courses taken by the students
GO
create VIEW Stud_Course_info
WITH ENCRYPTION, SCHEMABINDING
AS
select s.fname AS [Student First Name],s.lname AS [Student Last Name],s.email AS [EMAIL ID],c.course_name AS [COURSE NAME]
from dbo.student s
join dbo.course_student cs
on cs.studentid = s.studentid
join dbo.course c
on c.courseno=cs.courseno ;

-- Displaying details of view 
select * from Stud_Course_info;

-- drop of view and the tables created
drop view Stud_Course_info;
drop table dbo.course_student;
drop table dbo.prof_course;
drop table dbo.professor;
drop table dbo.student;
drop table dbo.course;

-- Part A step 3--
use s_shravanthi_test;

create table TargetCustomers (
TargetID int primary key,
FirstName varchar(30) not null,
LastName varchar(30) not null,
Address varchar(40) not null,
City varchar(20) not null,
State varchar(20) not null,
ZipCode int
)

create table MailingLists
(
MailingListID int primary key,
MailingList varchar(50) not null
)

create table TargetMailingLists
(
TargetID int references TargetCustomers(TargetID),
MailingListID int references MailingLists(MailingListID)
CONSTRAINT TargetMailingList PRIMARY KEY CLUSTERED(TargetID,MailingListID)
)

--- Part B ---

use Adventureworks2012;

select distinct sh1.CustomerID,
ISNULL(STUFF((SELECT distinct ', '+RTRIM(CAST(SalesPersonID as char))  
from Sales.SalesOrderHeader sh
where sh.CustomerID = sh1.CustomerID
FOR XML PATH('')),1,2,''), '') AS SalesSPersonID
FROM Sales.SalesOrderHeader sh1
ORDER BY CustomerID DESC;


--- Part C ---
-- using temporary table
use AdventureWorks2012; 

if object_id('tempdb..#temptable') is not null
drop table #TempTable

WITH Parts(AssemblyID, ComponentID, PerAssemblyQty, EndDate, ComponentLevel) AS
(
    -- Top-level compoments
	SELECT b.ProductAssemblyID, b.ComponentID, b.PerAssemblyQty,
        b.EndDate,0 AS ComponentLevel
    FROM Production.BillOfMaterials AS b
	WHERE b.ProductAssemblyID = 992
          AND b.EndDate IS NULL

    UNION ALL

	-- All other sub-compoments
    SELECT bom.ProductAssemblyID, bom.ComponentID, p.PerAssemblyQty,
        bom.EndDate, ComponentLevel + 1
    FROM Production.BillOfMaterials AS bom 
        INNER JOIN Parts AS p
        ON bom.ProductAssemblyID = p.ComponentID
		AND bom.EndDate IS NULL
)
SELECT AssemblyID,ComponentID,Name,PerAssemblyQty,ListPrice,ComponentLevel
into #TempTable
FROM Parts AS p
    INNER JOIN Production.Product AS pr
    ON p.ComponentID = pr.ProductID
ORDER BY ComponentLevel, AssemblyID, ComponentID;

GO

select AssemblyID AS [Assembly ID],ComponentID AS [Component ID],Name AS [Component Name],PerAssemblyQty AS [Quantity],ListPrice*PerAssemblyQty AS [Cost],ComponentLevel  
from #TempTable 
where ComponentLevel IN (0,1); 
