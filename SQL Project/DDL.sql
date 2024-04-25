/*
			SQL Project Name	: Pharmacy Management System
			Trainee Name		: Imam Mehedi   
			Trainee ID			: 1280706 
			Batch ID			: WADA/ASCL/58/01 

 --------------------------------------------------------------------------------

Table of Contents: DDL
			=> SECTION 01: CREATE a Database [PMS]
			=> SECTION 02: CREATE Appropriate Tables with column definition & Schema
			=> SECTION 03: ALTER, DROP AND MODIFY TABLES & COLUMNS
			=> SECTION 04: CREATE CLUSTERED AND NONCLUSTERED INDEX
			=> SECTION 05: CREATE SEQUENCE , ALTER SEQUENCE & DROP SEQUENCE
			=> SECTION 06: CREATE A VIEW & ALTER VIEW
			=> SECTION 07: CREATE STORED PROCEDURE & ALTER STORED PROCEDURE
			=> SECTION 08: CREATE FUNCTION(SCALAR, SIMPLE TABLE VALUED, MULTISTATEMENT TABLE VALUED) 
			=> SECTION 09: CREATE TRIGGER (FOR/AFTER TRIGGER and INSTEAD OF TRIGGER)
*/


-- Section 01 : Created a Database [PMS]
Create DATABASE Pharmacy
ON
( Name = Pharmacy_Management_Datafile,
FileName ='C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\Pharmacy_Management_Datafile.mdf',
Size = 5 MB,
Maxsize = 500 MB,
FileGrowth = 5%
)
Log ON
( Name = Pharmacy_Management_Logfile,
FileName ='C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\Pharmacy_Management_logfile.ldf',
Size = 5 MB,
Maxsize = 100 MB,
FileGrowth = 5%
)

go

USE Pharmacy;
go
--Section 02 : Created Appropriate Tables with column definition & Schema
-- Create Medicine table
Create TABLE Medicine (
    MID INT Identity PRIMARY KEY NonClustered,
    MName VARCHAR(100) NOT NULL,
    MCategory VARCHAR(50),
    SQuantity INT NOT NULL,
    MPrice Money NOT NULL
);
go
-- Create Stock table
Create TABLE Stock (
    SID INT IDENTITY(2401, 1) PRIMARY KEY ,
    MID INT FOREIGN KEY REFERENCES Medicine(MID) ,
    SIN INT NOT NULL,
    SOut INT NOT NULL,
    SDate smalldatetime NOT NULL
);
go

-- Create  schema called 'Pharmacy'
CREATE SCHEMA Pharmacy;
Go

-- Create Medicine table within the Pharmacy schema
CREATE TABLE Pharmacy.Medicine (
    MID INT IDENTITY(1,1) PRIMARY KEY,
    MName VARCHAR(100) NOT NULL,
    MCategory VARCHAR(50),
    SQuantity INT NOT NULL,
    MPrice MONEY NOT NULL
);
Go
-- SECTION 03: ALTER, DROP AND MODIFY TABLES & COLUMNS
--ALTER
ALTER TABLE Pharmacy.Medicine
ADD MColumn INT;
Go
--DROP
ALTER TABLE Pharmacy.Medicine
DROP COLUMN MColumn;
go
--Modify
-- Modify to a different data type FLOAT
ALTER TABLE Pharmacy.Medicine
ALTER COLUMN SQuantity FLOAT; 
go
--Rename Table
EXEC sp_rename 'Pharmacy.Medicine', 'NewMedicine';
go
--Drop Table
DROP TABLE Pharmacy.NewMedicine;
go
--Drop Schema
DROP SCHEMA Pharmacy;
go
--SECTION 04 : CREATE CLUSTERED AND NONCLUSTERED INDEX

-- CLUSTERED
CREATE CLUSTERED INDEX CI_Medicine_MID 
ON Medicine(MID);
go
-- Non-CLUSTERED
CREATE NONCLUSTERED INDEX IX_Medicine_MName 
ON Medicine(MName);
go
--Section 05 : CREATE SEQUENCE , ALTER SEQUENCE & DROP SEQUENCE

-- Create
CREATE SEQUENCE Seq_MedicineID
START WITH 1
INCREMENT BY 1
MINVALUE 1
MAXVALUE 1000
CYCLE;
go
--Alter
ALTER SEQUENCE Seq_MedicineID
INCREMENT BY 2
NO CYCLE;
go
--Drop
DROP SEQUENCE Seq_MedicineID;
go
--SECTION 06: CREATE A VIEW & ALTER VIEW
-- Create

BEGIN TRANSACTION;

CREATE VIEW MedicineView AS
SELECT MID, MName, MCategory, MPrice
FROM Medicine;


COMMIT;
go
-- Alter 
ALTER VIEW MedicineView AS
SELECT MID, MName, MCategory,MPrice,SQuantity
FROM Medicine;
go
--SECTION 07: CREATE STORED PROCEDURE & ALTER STORED PROCEDURE
-- Create
CREATE PROCEDURE GetMedicineByCategory
    @Category VARCHAR(50)
AS
BEGIN
    SELECT MID, MName, SQuantity, MPrice
    FROM Medicine
    WHERE MCategory = @Category;
END;
go
-- Alter 
ALTER PROCEDURE GetMedicineByCategory
    @Category VARCHAR(50),
    @MinPrice MONEY
AS
BEGIN
    SELECT MID, MName, SQuantity, MPrice
    FROM Medicine
    WHERE MCategory = @Category
        AND MPrice >= @MinPrice;
END;
go
--SECTION 08: CREATE FUNCTION(SCALAR, SIMPLE TABLE VALUED, MULTISTATEMENT TABLE VALUED) 

--Scalar Function
CREATE FUNCTION dbo.SumAllMprice()
RETURNS Money
AS
BEGIN

    DECLARE @TotalMprice Money;

    SELECT @TotalMprice = SUM(Mprice)
    FROM Medicine;

    RETURN @TotalMprice;
END;

go
-- Simple table-valued function 
CREATE FUNCTION GetMedicinByCategory
    (@Category VARCHAR(50))
RETURNS TABLE
AS
RETURN
(
    SELECT MID, MName, SQuantity, MPrice
    FROM Medicine
    WHERE MCategory = @Category
);
Go
--Multi-statement table-valued function
CREATE FUNCTION GetMedicineInRange
    (@MinPrice MONEY, @MaxPrice MONEY)
RETURNS @ResultTable TABLE
(
    MID INT,
    MName VARCHAR(100),
    SQuantity INT,
    MPrice MONEY
)
AS
BEGIN
    INSERT INTO @ResultTable
    SELECT MID, MName, SQuantity, MPrice
    FROM Medicine
    WHERE MPrice BETWEEN @MinPrice AND @MaxPrice;

    RETURN;
END;
GO

--SECTION 09: CREATE TRIGGER (FOR/AFTER TRIGGER and INSTEAD OF TRIGGER)
-- Create Insert Trigger
CREATE TRIGGER AfterInsertMedicine
ON Medicine
AFTER INSERT
AS
BEGIN
    -- Insert 
    INSERT INTO Medicine
    VALUES ('Napro','NSAIDS',500,15000)
END;
GO
-- INSTEAD OF DELETE Trigger
CREATE TRIGGER InsteadOfDeleteMedicine
ON Medicine
INSTEAD OF DELETE
AS
BEGIN
    
    PRINT 'Deletion of rows from Medicine table is not allowed.';
END;
go


------------------------------------------------------------THANK YOU--------------------------------------------------------------------------------------------------------











