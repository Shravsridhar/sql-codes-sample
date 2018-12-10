-- creation of Database --
create database University_library_system;

use University_library_system;

-- creation of required tables --

-- Admin table is created to maintain details of Admin at University Library --
create table Admin 
(
AdminID varchar(50) not null constraint pk_AdminID primary key,
AdminName varchar(50) not null,
PhoneNumber bigint not null, 
AdminEmail nvarchar(50) not null
); 

-- values insertion --
insert into Admin values(1234,'Xui Min',6179263,'xm@gmail.com');
insert into Admin values(1456,'Aksh Roy',2257818,'apr@gmail.com');
insert into Admin values(1556,'Shrav Sri',482940461,'s.s@gmail.com');
insert into Admin values(1356,'Kish Giri',6534649,'kg@gmail.com');
insert into Admin values(6294,'Ashish B',6634104,'ab@gmail.com');
insert into Admin values(26391,'Swa Shar',1739938,'shar.sw@gmail.com');
insert into Admin values(3694,'Sanju Sri',27979263,'sa.s@gmail.com');
insert into Admin values(1736,'Akshara Roy',2722359,'akr@gmail.com');
insert into Admin values(5216,'Sandy Sri',764040461,'sd.s@gmail.com');
insert into Admin values(6192,'Sriram Shar',2660361,'sh.sr@gmail.com');
insert into Admin values(7101,'Rupali Patil',70710704,'rups@gmail.com');
insert into Admin values(2241,'Sunita Wayal',17639938,'suni@gmail.com');

-- Login Authentication table comprises of the Login Details of Admin to login system --
create table Login_Authentication
(
LoginID varchar(100) not null constraint pk_LoginID primary key,
Passwd binary(100) not null,
AdminID varchar(50) not null
constraint FK_AdminID 
foreign key
references Admin(AdminID)
);

-- Creation of stored procedure --
-- This stored procedure is created to insert values such that the password column is encrypted --
create procedure Login_Auth_Pop
@idLogin varchar(100),
@pwd nvarchar(100),
@idAdmin varchar(50)
As
BEGIN
 SET NOCOUNT ON
	INSERT INTO Login_Authentication(LoginID,Passwd,AdminID)
	VALUES(@idLogin, HASHBYTES('SHA2_512', @pwd),@idAdmin)
END

-- values insertion using stored procedure --
EXEC Login_Auth_Pop
	@idLogin= N'a123',
	@pwd = N'bh$28@',
	@idAdmin= N'1234'

EXEC Login_Auth_Pop 
	N'b629',
	N'dh%@h',
	N'1456'
EXEC Login_Auth_Pop 
	N'd225', 
	N'5%wjd',
	N'1556'
EXEC Login_Auth_Pop
	N'j836',
	N'7349&dba$',
	N'1356'
EXEC Login_Auth_Pop
	N'x875',
	N'sgdd*fhy',
	N'6294'
EXEC Login_Auth_Pop
	N'h729',
	N'as$sj&',
	N'26391'
EXEC Login_Auth_Pop
	N'i825',
	N'asadh&',
	N'3694'
EXEC Login_Auth_Pop
	N't225',
	N'j5%wjd',
	N'1736'
EXEC Login_Auth_Pop
	N'r836',
	N'49&dba$',
	N'5216'
EXEC Login_Auth_Pop
	N'x975',
	N'sgd*fhy',
	N'6192'
EXEC Login_Auth_Pop
	N'u829',
	N'as6kabh*&',
	N'7101'
EXEC Login_Auth_Pop
	N'a725',
	N'asd@bys',
	N'2241'

-- to display the table with encrypted column Password --
select * from Login_Authentication;

-- Author table contains the details of Author of various books available at the University library --
create table Author
(
AuthorID varchar(50) not null constraint PK_AuthorID primary key, 
AuthorName varchar(50) not null,
Authoraddress varchar(50) not null,
AuthorEmail nvarchar(50) not null,
);

select * from Author;

-- values insertion to Author table--
insert into Author values(1001,'Mike Tyson','1 Bay St, Boston','mt@gmail.com');
insert into Author values(1002,'Jason Parekh','11 Mission St, Boston','jp@gmail.com');
insert into Author values(1003,'Shravas S','6 Park St, Boston','ss@gmail.com');
insert into Author values(1004,'Kishor Giri','2 Stephen St, Boston','kg@gmail.com');
insert into Author values(1005,'Mike Penn','13 Bon St, Boston','mp@gmail.com');
insert into Author values(1006,'Niki Noro','1 Cali St, Boston','nn@gmail.com');
insert into Author values(1007,'Ash B','7 NYC St, Boston','ab@gmail.com');
insert into Author values(1008,'Sally Geth','15 Germain St, Boston','sg@gmail.com');
insert into Author values(1009,'Meghan T','St. Germain St, Boston','mt@gmail.com');
insert into Author values(1010,'Kendell T','9 Montana St, Boston','kt@gmail.com');
insert into Author values(1011,'John Murphy','3 Sand St, Boston','jm@gmail.com');
insert into Author values(1012,'George Bush','15 Bay St, Boston','gb@gmail.com');


-- Publisher table contains the Publisher details of various books available at the University library --
create table Publisher
(
PublisherID varchar(50) not null constraint PK_PublisherID primary key,
PublisherName varchar(50) not null ,
PublisherAddress varchar(50) not null,
Publisheremail nvarchar(50) not null,
);

select * from Publisher;

-- values insertion to Publisher table--
insert into Publisher values(4015,'Bukky M','7 Smith St, Boston','p.bm@gmail.com');
insert into Publisher values(4016,'Sean P','2 Kane St, Boston','p.sp@gmail.com');
insert into Publisher values(4017,'Carl H','6 Jersey St, Boston','p.ch@gmail.com');
insert into Publisher values(4018,'James K','1 Heath St, Boston','p.jk@gmail.com');
insert into Publisher values(4019,'Rob S','15 Nike St, Boston','p.rs@gmail.com');
insert into Publisher values(4020,'Ash L','12 Lake St, Boston','p.al@gmail.com');
insert into Publisher values(4021,'Jessica N','17 Mike St, Boston','p.jn@gmail.com');
insert into Publisher values(4022,'Pike Z','3 Charles St, Boston','p.pz@gmail.com');
insert into Publisher values(4023,'Tucker B','6 Mission St, Boston','p.tb@gmail.com');
insert into Publisher values(4024,'Hurt G','11 Boylston St, Boston','p.hg@gmail.com');
insert into Publisher values(4025,'Dan D','3 Jake St, Boston','p.dd@gmail.com');

-- Language Index Table contains the range of languages in which books are available at university library --
create table Language_Index
(
LanguageID varchar(50) not null constraint PK_LanguageID primary key,
Lang varchar(50) not null
);

select * from Language_Index;

-- values insertion to Language Index table --
insert into Language_Index values(01,'English');
insert into Language_Index values(02,'French');
insert into Language_Index values(03,'Spanish');
insert into Language_Index values(04,'Marathi');
insert into Language_Index values(05,'Hindi');
insert into Language_Index values(06,'Urdu');
insert into Language_Index values(07,'Japnese');
insert into Language_Index values(08,'Mandarin');
insert into Language_Index values(09,'Korean');
insert into Language_Index values(10,'German');

-- Categories table contains the List of book categories available at the University library --
create table Categories
(
CategoryID varchar(50) not null constraint PK_CID primary key,
BookID varchar(50) not null,
CategoryName varchar(50) not null,
ShelfLocation varchar(50) not null
constraint chk_shelf_range
check (ShelfLocation BETWEEN 1 AND 500)
);

select * from Categories;

-- values insertion to Categories Table --
insert into Categories values('1',1,'Fiction','1')
insert into Categories values('2',10,'Non Fiction','2')
insert into Categories values('3',8,'Non Fiction','2')
insert into Categories values('4',2,'Fiction','1')
insert into Categories values('5',3,'Non Fiction','2')
insert into Categories values('6',4,'Fiction','1')
insert into Categories values('7',5,'Non Fiction','2')
insert into Categories values('8',6,'Non Fiction','2')
insert into Categories values('9',7,'Fiction','5')
insert into Categories values('10',9,'Fiction','5')

-- Book Table comprises of the entire details of available books at University library --
create table Book 
(
BookID varchar(50) not null constraint PK_BID primary key,
ISBN varchar(50) not null,
BookTitle varchar(100) not null,
CategoryID varchar(50) null
constraint FK_CID 
foreign key
references Categories(CategoryID),
AuthorID varchar(50) null
constraint FK_AuthorID 
foreign key
references Author(AuthorID),
PublisherID varchar(50) null
constraint FK_PID 
foreign key
references Publisher(PublisherID),
LanguageID varchar(50) null
constraint FK_LID 
foreign key
references Language_Index(LanguageID),
Edition int not null,
);

select * from Book;

alter table Categories 
add constraint PF_BID foreign key (BookID) references Book(BookID);

--- values insertion in Book Table --
insert into Book values(1,'A1B22','wuthering heights',1,1001,4015,1,3);
insert into Book values(2,'A1B23','Middlemarch',2,1002,4016,2,1);
insert into Book values(3,'A1B24','Nineteen Eighty-Four',3,1002,4016,3,4);
insert into Book values(4,'A1B25','The Lord of the Rings',1,1003,4017,1,5);
insert into Book values(5,'A1B26','Diary of a Nobody',2,1004,4016,2,1);
insert into Book values(6,'A1B27','His Dark Materials',3,1005,4018,3,5);
insert into Book values(7,'A1B28','Jane Eyre',1,1006,4019,1,2);
insert into Book values(8,'A1B29','Great Expectations',2,1007,4018,2,5);
insert into Book values(9,'A1B30','Rebecca',3,1008,4020,3,3);
insert into Book values(10,'A1B31','Far from the Madding Crowd',1,1009,4021,1,1);

-- Copies table stores unique ID for each book at the Library --
create table Copies 
(
CopyID varchar(50) not null constraint PK_CoID primary key,
BookID varchar(50) not null
);

select * from Copies;

-- values insertion to Copies table --
insert into copies values('11','1')
insert into copies values('12','1')
insert into copies values('21','2')
insert into copies values('22','2')
insert into copies values('31','3')
insert into copies values('32','3')
insert into copies values('41','4')
insert into copies values('42','4')
insert into copies values('51','5')
insert into copies values('52','5')
insert into copies values('61','6')
insert into copies values('62','6')
insert into copies values('71','7')
insert into copies values('72','7')
insert into copies values('81','8')
insert into copies values('82','8')
insert into copies values('91','9')
insert into copies values('92','9')
insert into copies values('101','10')
insert into copies values('102','10')

-- Member table contains the details of Members at University Library --
create table Member 
(
MemberID varchar(50) not null constraint PK_MID primary key,
FirstName varchar(50) not null,
LastName varchar(50) not null,
EmailID nvarchar(50) not null,
Department varchar(50) not null,
MemberType varchar(50) null
);

select * from Member;

-- values insertion to Member table --
insert into Member values(700001,'Harry','Page','harryp@gmail.com','College of Engineering','Faculty');
insert into Member values(700002,'Shelly','Trumph','shellyt@gmail.com','College of Computer Science','Faculty');
insert into Member values(700003,'Nick','Brown','nikeb@gmail.com','College of Engineering','Faculty');
insert into Member values(700004,'Wuping','Yang','wupingy@gmail.com','College of Engineering','Faculty');
insert into Member values(800010,'Harshit','Shah','harshits@gmail.com','College of Engineering','Student');
insert into Member values(800011,'Vinayak','Bhatt','vinayakb@gmail.com','College of Engineering','Student');
insert into Member values(800012,'Sagar','Shah','sagars@gmail.com','College of Computer Science','Student');
insert into Member values(800013,'Yogesh','K','yogeshk@gmail.com','College of Engineering','Student');
insert into Member values(800014,'Uttam','C','uttamc@gmail.com','College of Engineering','Student');
insert into Member values(800015,'Prerna','M','prernam@gmail.com','College of Computer Science','Student');
insert into Member values(800016,'Ishan','Patel','ishanp@gmail.com','College of Engineering','Student');
insert into Member values(800017,'Hugh','Jackman','hugej@gmail.com','School of Law','Student');

-- Permission Elevation table comprises of details about fine amount, etc that varies according to Member type --
create table Permission_Elevation
(
MemberType varchar(50) not null constraint PK_MT primary key,
FineAmount varchar(50) not null ,
Duration int not null
);

alter table Member 
add constraint FK_MT
foreign key(MemberType) 
references Permission_Elevation(MemberType);

select * from Permission_Elevation;

-- values insertion to Permission Elevation table --
insert into Permission_Elevation values ('Faculty','20',30)
insert into Permission_Elevation values ('Student','50',15)

-- Library Transaction Table comprises of the Transaction Details at University Library --
create table Library_Transaction
(
TransactionID varchar(50) not null constraint PK_TID primary key,
MemberID varchar(50) not null
constraint FK_MID 
foreign key
references Member(MemberID), 
CopyID varchar(50) not null 
constraint FK_CoID 
foreign key
references Copies(CopyID), 
AdminID varchar(50) not null
constraint FK_AdID 
foreign key
references Admin(AdminID),
TransactionType varchar(50) not null,
TransactionDate date
constraint TDate
default(SYSDATETIME())
);

select * from Library_Transaction;

-- values insertion to  Library Transaction Table--
insert into Library_Transaction values('A1','700001','11','1234','Issue','11/05/2018')
insert into Library_Transaction values('A2','700002','21','1556','Issue','11/06/2018')
insert into Library_Transaction values('A3','700003','31','1234','Issue','11/07/2018')
insert into Library_Transaction values('A4','700004','41','1736','Issue','11/08/2018')
insert into Library_Transaction values('A5','800010','51','1234','Issue','11/09/2018')
insert into Library_Transaction values('A6','700001','11','1356','Return','01/12/2019')
insert into Library_Transaction values('A7','700002','21','1456','Return','01/13/2019')
insert into Library_Transaction values('A8','700003','31','1234','Return','01/14/2019')
insert into Library_Transaction values('A9','700004','41','1736','Return','11/15/2018')
insert into Library_Transaction values('A10','800010','51','1234','Return','11/16/2018')

-- Book_Author Table is mainly created to resolve the Many to Many relation between Book and Author Table --
-- It Maps the Book ID and Author ID for all books at the University Library --
create table Book_Author 
(
BookID varchar(50) not null
constraint FK_BoID 
foreign key
references Book(BookID), 
AuthorID varchar(50) not null
constraint FK_AuID 
foreign key
references Author(AuthorID)
constraint PK_AB primary key clustered 
(BookID,AuthorID)
);

select * from Book_Author;

--- values insertion in Book_Author Table --
insert into Book_Author values(1,1006);
insert into Book_Author values(2,1008);
insert into Book_Author values(3,1003);
insert into Book_Author values(4,1007);
insert into Book_Author values(5,1004);
insert into Book_Author values(6,1009);
insert into Book_Author values(7,1001);
insert into Book_Author values(8,1005);
insert into Book_Author values(9,1002);
insert into Book_Author values(10,1011);

-- Issue Status Table comprises of the details concerning Issue Transaction of a Member --
create table Issue_Status
(
IssueTransactionID varchar(50) not null constraint PK_IssueTID primary key,
TransactionID varchar(50) not null
constraint FK_TID 
foreign key
references Library_Transaction(TransactionID),
Issue_Date date
constraint IDate
default(SYSDATETIME()), 
Due_Date date not null
);

select * from Issue_Status;


-- Return Status Table comprises of the details concerning Return Transaction of a Member --
create table Return_Status
(
ReturnTransactionID varchar(50) not null constraint PK_RTID primary key,
TransactionID varchar(50) not null
constraint FK_TrID 
foreign key
references Library_Transaction(TransactionID),
CopyID varchar(50) not null
constraint FK_CopID
foreign key
references Copies(CopyID), 
Return_Date date not null, 
Fine_Amount varchar(50) null,
Notes nvarchar(50) null
); 

select * from Return_Status;

-- Current Availibility Table concernes about the Availibility Status of each book at the Library --
create table Current_Availibility
(
[S.No] int not null identity,
CopyID varchar(50) not null 
constraint FK_COPYID
foreign key
references Copies(CopyID), 
Availibility_Status varchar(50) not null,
primary key([S.No])
);

select * from Current_Availibility;

-- Inventory Management Table is used to maintain inventory while order of new set of books : order's are carried out by admin --
create table Inventory_Management
(
Order_ID varchar(50) not null constraint PK_OID primary key,
Admin_ID varchar(50) not null
constraint FK_AdminID1 
foreign key
references Admin(AdminID),
New_BookID varchar(50) not null,
Book_Name varchar(50) not null,
Author varchar(50) not null, 
Publisher varchar(50) null, 
No_Copies bigint not null,
Cost_of_Copy bigint not null
);

select * from Inventory_Management;

--- values insertion in Inventory_Management Table --
insert into Inventory_Management values('P1','1234',12,'wuthering heights','Adam M','Mike M',6,80);
insert into Inventory_Management values('P2','1356',13,'Middlemarch','Tata Clark','Drake P',4,50);
insert into Inventory_Management values('P3','1456',14,'Nineteen Eighty-Four','Li Maze','Marshalls',8,100);
insert into Inventory_Management values('P4','1234',15,'The Lord of the Rings','Chin Chan','Loze K',9,230);
insert into Inventory_Management values('P5','1556',16,'Diary of a Nobody','Pablo Z','Pike D',2,200);
insert into Inventory_Management values('P6','3694',17,'His Dark Materials','San Higgs','Sean D',5,186);
insert into Inventory_Management values('P7','1456',18,'Jane Eyre','Dan Murphy','Keith L',10,300);
insert into Inventory_Management values('P8','3694',19,'Great Expectations','Mike Lopez','Nash J',5,240);
insert into Inventory_Management values('P9','5216',20,'Rebecca','James Burke','Migul B',3,160);
insert into Inventory_Management values('P10','6192',21,'Far from the Madding Crowd','Pacho Herera','Sagar K',2,183);


-- creation of function for calculating the Total cost in Inventory_Management Table --

CREATE FUNCTION fn_Calc_TotCost(@OrderID VARCHAR(50))
RETURNS BIGINT
AS
   BEGIN
      DECLARE @total BIGINT =
			(Select (No_Copies * Cost_of_Copy)
			FROM Inventory_Management 
			WHERE Order_ID = @OrderID);
      RETURN @total;
END

-- Addition of computed column TotalCost to Inventory_Management table --
-- This could help estimate total cost on the Books to be ordered --

ALTER TABLE dbo.Inventory_Management
ADD TotalCost AS (dbo.fn_Calc_TotCost(Order_ID));

-- to view table details post changes --
select * from Inventory_Management;

-- View creation to display the order made for new books along with the Total cost incurred --
-- The orders are made by the Admin hence Admin Details are also displayed alongwith the Orders for quick reference --
create view Inventory_order_details
AS
select i.Order_ID AS [ORDER ID],a.AdminID AS [ADMIN ID],a.AdminName AS [ADMIN NAME],i.Book_Name AS [BOOK TITLE],i.No_Copies*i.Cost_of_Copy AS [ TOTAL COST ] 
from Inventory_Management i
join
Admin a 
on a.AdminID = i.Admin_ID;

-- Creation of view to display member details with the fine amount --
-- This view could help the admin to easily check for member details and fine amount during checkout operation or incase of any queries --

create View Member_Fine_Details
AS
select m.MemberID,m.FirstName,m.LastName,p.FineAmount from
Member m
join 
Permission_Elevation p
on m.MemberType = p.MemberType;

-- Creation of view to dispaly the book info along with author and pulisher --
-- This view can be used to find all the related info of a book which will help admin with handling queries --

create  view Book_info
AS
select b.BookID AS [BOOK ID],b.BookTitle AS [BOOK TITLE],a.AuthorName AS [AUTHOR NAME],p.PublisherName AS [PUBLISHER NAME] from
Book b
join 
Publisher p
on p.PublisherID = b.PublisherID
join
Book_Author ba
on b.BookID = ba.BookID
join 
Author a
on ba.AuthorID = a.AuthorID ;

select * from Book_info;

-- view to display the Admin list of University Library along with their details --
create view Admin_Details
AS
Select  
    LTRIM(RTRIM(SUBSTRING(AdminName, 0, CHARINDEX(' ', AdminName)))) As [FIRST NAME]
,   LTRIM(RTRIM(SUBSTRING(AdminName, CHARINDEX(' ', AdminName)+1, 100)))As [LAST NAME],
   PhoneNumber AS [CONTACT NUMBER],
   AdminEmail AS [EMAIL]
FROM Admin;

-- to display the created views --
select * from Admin_Details;
select * from Book_info;
select * from Member_Fine_Details;

-- to create index :  TransactionID column from Library_Transaction table --
-- this helps in retrieving the data at much faster speed --
create unique index Lib_Tra
ON Library_Transaction(TransactionID);

-- to create index : BookID from Book table --
create index Book_id
ON Book(BookID);

-- Encryption of Author Adress column from Author table --
-- This is to maintain privacy of the Author --

-- adding column for encrypting password column --

alter table Author
add Encry_Address varbinary(100);

-- creation of master DB key --
create MASTER KEY 
ENCRYPTION BY PASSWORD = 'SAK_123@';

-- creating certificate with expiration date --
create certificate Author_Address
WITH SUBJECT = 'Author Contact Privacy',
EXPIRY_DATE = '2020-12-31';
GO

-- creating symmetric key for encryption --
CREATE SYMMETRIC KEY Auth_Add 
    WITH ALGORITHM = AES_256  
    ENCRYPTION BY CERTIFICATE Author_Address;  
GO  

-- opening the symmetric key --
OPEN SYMMETRIC KEY Auth_Add 
   DECRYPTION BY CERTIFICATE Author_Address; 
GO

-- Updation of the Author table with Encrypted column Author_Address --
update Author
set Encry_Address = ENCRYPTBYKEY(KEY_GUID(N'Auth_Add'),Authoraddress);

-- to view the Author table details --
select * from Author;

-- creation of function to view all the transactions based on the MemberID --
-- This would help in easy view of all transactions of a member --
CREATE FUNCTION f_GetAllTransactionForMember
(@MemID varchar(100))
RETURNS TABLE
AS
RETURN (SELECT TOP 10
 TransactionID,
 CopyID,
 AdminID,
 TransactionType
 FROM Library_Transaction
 WHERE MemberID = @MemID
 ORDER BY TransactionDate DESC, TransactionID
 );

-- to view the details by memberID --
select * from f_GetAllTransactionForMember(700001);


-- creation of view to calculate the number of days a book was borrowed --
-- This view is used for mainly Admin related purpose where Admin can cross check the duration a particular book was borrowed --
create view V_Duration
As
select i.TransactionID AS [Transaction ID],i.CopyID as [BOOK ID],DATEDIFF(day,i.Issue_Date,r.Return_Date) AS [DURATION]
from Issue_Status i
join Return_Status r
on i.CopyID = r.CopyID ;

-- creation of Triggers --
-- Triggers are created to populate the Issue Status and Return Status table when each transaction is recorded in Library Transaction table --
ALTER TRIGGER [dbo].[issue]
ON [dbo].[Library_Transaction]
AFTER INSERT
AS
BEGIN
	if((select TransactionType from inserted)='Issue')
	begin
		insert into Issue_Status(TransactionID,CopyID,Issue_Date,Due_Date)
		values((select i.TransactionID from inserted i),(select i.copyID from inserted i),(select i.TransactionDate from inserted i),
		(select case 
			  when m.MemberType='Student' 
			  then dateadd(day,15,i.transactiondate) 
			  else dateadd(day,30,i.TransactionDate) 
			  end
			  from inserted i 
			  join member m 
			  on i.MemberID=m.MemberID))
	end
	else
	begin
		insert into Return_Status(TransactionID,CopyID,Return_Date,Fine_Amount)
		values((select i.transactionID from inserted i),(select i.copyID from inserted i),(select i.TransactionDate from inserted i),
		(select case 
			when m.MemberType='Student'
			then dbo.Duration(s.Issue_Date,i.TransactionDate)*50
			else dbo.Duration(s.Issue_Date,i.TransactionDate)*20
			end
			from inserted i
			join dbo.Issue_Status s 
			on i.CopyID=s.copyID 
			join member m 
			on i.MemberID=m.MemberID))
	end
END


-- Triggers below populate and update the Availibility Status Table based on the book Availibility --

--------trigger for books in availability status------
create TRIGGER dbo.[availability]
ON dbo.copies
AFTER INSERT
AS
	begin
		insert into Current_Availibility(copyID,Availibility_Status)
		values((select i.copyID from inserted i),'1')
	end

------------------------trigger for updating availability based on transaction----
create trigger dbo.update_availiability
on dbo.library_Transaction
after insert 
as 
	begin
	if((select TransactionType from inserted)='Issue')
	begin
		update dbo.Current_Availibility
		set Availibility_Status='0'
		where CopyID=(select copyID from inserted)
	end
	else
	begin
			update dbo.Current_Availibility
			set Availibility_Status='1'
			where CopyID=(select copyID from inserted)
	end
end




