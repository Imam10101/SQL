/*

				SQL Project Name	: Pharmacy Management System
			Trainee Name		: Imam Mehedi   
			Trainee ID			: 1280706 
			Batch ID			: WADA/ASCL/58/01 

 --------------------------------------------------------------------------------
Table of Contents: DML

			Section: 01 => Using INSERT INTO KEYWORD Insert data into Current TABLE.
			Section: 02 => Using SELECT FROM Keyword View TABLE and their Data.
			Section: 03 => Using SELECT INTO Keyword Copy all TABLE Data into another TABLE.
			Section: 04 =>  JOIN
			Section: 05 =>  WHERE CLAUSE, Order BY, DISTINCT, TOP ,BETWEEN and  Operator.
			Section: 06 => LIKE,IN.
			Section: 07 => OFFSET, FETCH, AGGREGATE FUNCTIONS.
			Section: 08 => ROLLUP, CUBE, GROUP BY, GROUPING SETS AND HAVING.
			Section: 09 => Union.
			Section: 10 => SubQuerie (subqueries,and co-related subqueries).
			Section: 11 => EXISTS CLAUSE 
			Section: 12 => CTE .
			Section: 13 => BUILT IN FUNCTIONS (GETDATE,CAST,CONVERT,TRY_CONVERT,DATEDIFF,DATENAME)
*/
USE Pharmacy
GO
--Section: 01 : Using INSERT INTO KEYWORD Insert data into Current TABLE.

-- Insert values into Medicine table
Insert Into Medicine Values('Napa','OTC',200,2000),
							('Napa Extra','OTC',100,3000),
							('Napa Extend','OTC',200,4000),
							('Ace','OTC',200,2000),
							('Ace XR','OTC',200,4000),
							('Renova','OTC',200,4000),
							('Ciprocin','Antibiotic',1000,8000),
							('Fimoxyl','Antibiotic',1000,10000),
							('Famotak','Anti-Ulcer',100,3000),
							('Op','Anti-Ulcer',100,10000),
							('Sergel','Anti-Ulcer',100,7000),
							('Nexum','Anti-Ulcer',100,5000),
							('Alatrol','Anti_Histacin',200,8000),
						    ('Fexo','Anti_Histacin',200,16000),
							('Deslor','Anti_Histacin',200,6000),
							('Rupa','Anti_Histacin',200,20000),
							('Apitac','NSAIDS',200,8000),
							('Roiac','NSAIDS',200,17000),
							('Tory','NSAIDS',200,18000),
							('Naprox','NSAIDS',200,19000)



go
SELECT * FROM Medicine
GO
-- Insert values into Stock table

Insert Into Stock Values(1, 200, 0, '2022-05-20'),
                        (2, 2000, 0, '2022-05-21'),
                        (3, 100, 0, '2022-05-22'),
                        (4, 500, 0, '2022-05-23'),
                        (5, 300, 0, '2022-05-24'),
                        (6, 1000, 0, '2022-05-25'),
                        (7, 200, 0, '2022-05-26'),
                        (8, 700, 0, '2022-05-27'),
                        (9, 300, 0, '2022-05-28'),
                        (10, 500, 0, '2022-05-29'),
                        (11, 800, 0, '2022-05-30'),
                        (12, 150, 0, '2022-05-31'),
                        (13, 250, 0, '2022-06-01'),
                        (14, 1200, 0, '2022-06-02'),
                        (15, 300, 0, '2022-06-03'),
                        (16, 600, 0, '2022-06-04'),
                        (17, 200, 0, '2022-06-05'),
                        (18, 700, 0, '2022-06-06'),
                        (19, 400, 0, '2022-06-07'),
                        (20, 900, 0, '2022-06-08');

go
Select * From Stock
go
--Section: 02 : Using SELECT FROM Keyword View TABLE and their Data
SELECT * FROM Medicine
go
Select * From Stock
go
--Section: 03 : Using SELECT INTO Keyword Copy all TABLE Data into another TABLE.
Select * Into SK From Stock
go
Select * From SK
go
--Section: 04 :  JOIN
Select * From Medicine m
Join Stock s ON m.MID=s.MID
go
--Section: 05 :  WHERE CLAUSE, Order BY, DISTINCT, TOP ,BETWEEN and  Operator.
-- WHERE CLAUSE
SELECT * FROM Medicine WHERE MCategory = 'OTC';
go
--Order BY
SELECT * FROM Medicine ORDER BY MPrice DESC;
go
--DISTINCT
SELECT DISTINCT MCategory FROM Medicine;
go
--TOP
SELECT TOP 5 * FROM Medicine ORDER BY SQuantity DESC;
go
--BETWEEN
SELECT * FROM Medicine WHERE MPrice BETWEEN 2000 AND 5000;
go
--Operator
--AND
SELECT * FROM Medicine WHERE MCategory = 'OTC' AND MPrice < 3000;
go
--OR
SELECT * FROM Medicine WHERE MCategory = 'OTC' OR MPrice < 3000;
go
--NOT
SELECT * FROM Medicine WHERE NOT MCategory = 'OTC' AND MPrice >= 3000;
go
--Section: 06 : LIKE,IN.
--Like
SELECT * FROM Medicine WHERE MName LIKE 'Nap%';
go
--IN
SELECT * FROM Medicine WHERE MCategory IN ('OTC', 'Antibiotic');
go
--Section: 07 => OFFSET, FETCH, AGGREGATE FUNCTIONS.
--OFFSET & FETCH
SELECT * FROM Medicine
ORDER BY MPrice
OFFSET 5 ROWS
FETCH NEXT 5 ROWS ONLY;
go
-- AGGREGATE FUNCTIONS
--SUM
SELECT SUM(SQuantity) AS TotalQuantity FROM Medicine;
go
--AVG
SELECT AVG(MPrice) AS AveragePrice
FROM Medicine
WHERE MCategory = 'OTC';
go
--Count
SELECT MCategory, COUNT(*) AS NumberOfMedicines
FROM Medicine
GROUP BY MCategory;
go
--Section: 08 : ROLLUP, CUBE, GROUP BY, GROUPING SETS AND HAVING.
--Group By
SELECT MCategory, COUNT(*) AS NumberOfMedicines
FROM Medicine
GROUP BY MCategory;
go
--Having
SELECT MCategory, COUNT(*) AS NumberOfMedicines
FROM Medicine
GROUP BY MCategory
HAVING COUNT(*) > 5;
go
--ROLLUP
SELECT MCategory, COUNT(*) AS NumberOfMedicines
FROM Medicine
GROUP BY ROLLUP(MCategory);
go
--CUBE
SELECT MCategory, MPrice, COUNT(*) AS NumberOfMedicines
FROM Medicine
GROUP BY CUBE(MCategory, MPrice);
go
--GROUPING SETS
SELECT MCategory, MPrice, COUNT(*) AS NumberOfMedicines
FROM Medicine
GROUP BY GROUPING SETS ((MCategory), (MPrice));
go
--Section: 09 : Union.
SELECT MID, MName, MCategory, SQuantity, MPrice
FROM Medicine
UNION
SELECT MID, 'Medicine' AS MName, NULL AS MCategory, SIN AS SQuantity, NULL AS MPrice
FROM Stock;
go
--Section: 10 => SubQuerie (subqueries,and co-related subqueries).
SELECT MName, MPrice,
       (SELECT AVG(MPrice) FROM Medicine) AS AveragePrice
FROM Medicine
WHERE MPrice > (SELECT AVG(MPrice) FROM Medicine);
go
-- co-related subqueries
SELECT MName, MCategory, SQuantity
FROM Medicine m1
WHERE SQuantity > (SELECT AVG(SQuantity) FROM Medicine m2 WHERE m2.MCategory = m1.MCategory);
go
--Section: 11 : EXISTS CLAUSE 
SELECT *
FROM Medicine
WHERE EXISTS (
    SELECT *
    FROM Stock
    WHERE Stock.MID = Medicine.MID
    AND Medicine.SQuantity > 100
);
--Section: 12 : CTE.
WITH MedicineQuantities AS (
    SELECT M.MID, M.MName, M.MCategory, M.SQuantity
    FROM Medicine M
    JOIN Stock S ON M.MID = S.MID
)
SELECT *
FROM MedicineQuantities
WHERE SQuantity > 100;
go
--Section: 13 : BUILT IN FUNCTIONS (GETDATE,CAST,CONVERT,TRY_CONVERT,DATEDIFF,DATENAME)
--GETDATE
SELECT SDate, GETDATE() AS CurrentDateTime
FROM Stock;
go
--CAST & CONVERT
SELECT
    SDate,
    CAST(SDate AS DATE) AS StockDate,
    CONVERT(VARCHAR, SDate, 108) AS StockTime
FROM Stock;
GO
--TRY_CONVERT
SELECT SDate, TRY_CONVERT(DATE, SDate) AS ConvertedStockDate
FROM Stock;
GO
--DATEDIFF
SELECT SDate, DATEDIFF(DAY, SDate, GETDATE()) AS DaysDifference
FROM Stock;
GO
--DATENAME
SELECT SDate, DATENAME(MONTH, SDate) AS StockMonth
FROM Stock;
GO










