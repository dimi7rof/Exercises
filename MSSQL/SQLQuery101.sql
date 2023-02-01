-- WHILE LOOP
-- FOR LOOP
DECLARE @i int = 0

WHILE @i < 20
BEGIN
    SET @i = @i + 1
    /* do some work */
END


CREATE DATABASE [Minions]
GO
USE [Minions]
GO
-- References between tables
ALTER TABLE [Minions]
ADD [TownId] INT FOREIGN KEY REFERENCES [Towns]([Id]) NOT NULL
GO
-- Change column to Allow null
ALTER TABLE [Minions] 
ALTER COLUMN [Age] DECIMAL
GO
INSERT INTO [Towns] ([Id], [Name])
	VALUES 
		(1, 'Sofia'),
		(2, 'Plovdiv'),
		(3, 'Varna')
GO
SELECT 
	CONCAT(m.[Id], ' ', m.[Name]) AS [НОМЕР С ИМЕ]
	,FORMAT(Age, N'0,0 Години') AS [ГОДИНИ]
	,TownId
FROM [Minions] AS m
JOIN [Towns] AS t ON m.[TownId] = t.[Name]
WHERE 
	m.Age BETWEEN 17 AND 65
	AND	m.Id > 0
GO
-- Delete table records
TRUNCATE TABLE [Minions]
GO
CREATE TABLE [People0] (
	[Id] INT PRIMARY KEY IDENTITY, 
	[Name] NVARCHAR(200) NOT NULL,
	[Picture] VARBINARY(MAX),
	CHECK (DATALENGTH ([Picture]) <= 2000000),
	[Height] DECIMAL(3,2),
	[Weight] DECIMAL(5,2),
	[Gender] CHAR(1) NOT NULL,
	CHECK ([Gender] = 'm' OR [Gender] = 'f'),
	[Birthday] DATE NOT NULL,
	[Biography] NVARCHAR(MAX)
)
GO
-- Add default value, before insert values
ALTER TABLE [People]
ADD CONSTRAINT DF_DefaulBiography DEFAULT ('No Biography provided') FOR [Biography]
GO
INSERT INTO [People] ( [Name], [Gender], [Birthday])
VALUES
( 'A', 'f', '1999-11-26')
GO
-- 08
CREATE TABLE [Users1] (
	[Id] BIGINT PRIMARY KEY IDENTITY,
	[Username] VARCHAR(30) NOT NULL,
	[Password] VARCHAR(26) NOT NULL,
	[ProfilePicture] VARBINARY(MAX),
	CHECK (DATALENGTH ([ProfilePicture]) <= 900000),
	[LastLoginTime] DATETIME2,
	[IsDeleted] BIT
)
GO
-- 09 Change Primary Key
ALTER TABLE [Users]
DROP CONSTRAINT PK_Users
GO
USE SoftUni
GO
SELECT DISTINCT
	[Salary]
  FROM [Employees]
  ORDER BY Salary
GO
SELECT
*
FROM Employees
WHERE JobTitle = 'Sales Representative'
GO
SELECT
FirstName, LastName, JobTitle
FROM Employees
	WHERE Salary BETWEEN 20000 AND 30000
GO
SELECT 
CONCAT(FirstName,' ',MiddleName,' ',LastName) AS [Full Name]
FROM Employees 
WHERE Salary IN (25000, 14000, 12500, 23600)
GO
SELECT
FirstName, LastName
FROM Employees
WHERE ManagerID IS NULL
GO
SELECT
FirstName, LastName, Salary
FROM Employees
WHERE Salary > 50000
ORDER BY Salary DESC, FirstName
GO
-- NOT SUPPORTED IN JUDGE CREATE OR ALTER
CREATE OR ALTER VIEW [V_EmployeeNameJobTitle] AS
SELECT  
CONCAT(FirstName,' ', MiddleName + ' ', LastName) AS [Full Name]
, JobTitle
FROM Employees
GO
SELECT * FROM V_EmployeeNameJobTitle
GO
CREATE VIEW [V_EmployeesSalaries1] AS
SELECT
FirstName, LastName, Salary
FROM Employees
GO
UPDATE Employees
SET Salary += Salary * 0.12
WHERE DepartmentID IN (1, 2, 4, 11)
SELECT SALARY FROM Employees
GO
USE Geography
GO
SELECT CountryName, CountryCode, 
	CASE 
		WHEN CurrencyCode = 'EUR' THEN 'Euro'
		ELSE 'Not Euro'
	END AS Currency
FROM Countries
ORDER BY CountryName
GO
--        INNER JOIN
SELECT 
	m.MountainRange
	, p.PeakName
	, P.Elevation
FROM Mountains AS m
JOIN Peaks AS p ON 
	m.Id = p.MountainId  
	--AND m.MountainRange = 'Rila'
ORDER BY p.Elevation DESC


--         TABLE RELATIONS EXERCISE


--          ONE TO ONE RELATION


CREATE TABLE Passports (
	PassportID INT PRIMARY KEY IDENTITY(101,1),
	PassportNumber VARCHAR(10) NOT NULL
)
CREATE TABLE Persons (
	PersonID INT PRIMARY KEY IDENTITY,
	FirstName NVARCHAR(50) NOT NULL,
	Salary DECIMAL(9,2) NOT NULL,
	PassportID INT FOREIGN KEY REFERENCES Passports(PassportID) UNIQUE NOT NULL
	-- WITHOUT UNIQUE IS ONE TO MANY
	)


--        ONE TO MANY REALTION


CREATE TABLE Manufacturers(
	ManufacturerID INT PRIMARY KEY IDENTITY,
	[Name] VARCHAR(30) NOT NULL,
	EstablishedOn DATE NOT NULL
)
CREATE TABLE Models
(
	ModelID INT PRIMARY KEY IDENTITY(101,1),
	Name VARCHAR(20) NOT NULL,
	ManufacturerID INT FOREIGN KEY REFERENCES Manufacturers(ManufacturerID)
)

SELECT * FROM Models AS mo
LEFT JOIN Manufacturers AS ma
ON mo.ManufacturerID = ma.ManufacturerID

--         MANY TO MANY RELATION

CREATE TABLE Students (
	StudentID INT PRIMARY KEY IDENTITY,
	[Name] VARCHAR(20) NOT NULL
)
CREATE TABLE Exams (
	ExamID INT PRIMARY KEY IDENTITY(101,1),
	[Name] VARCHAR(20) NOT NULL
)
-- MAPPING TABLE
CREATE TABLE StudentsExams (
	StudentID INT FOREIGN KEY REFERENCES Students(StudentID),
	ExamID INT FOREIGN KEY REFERENCES Exams(ExamID),
	PRIMARY KEY(StudentID, ExamID)
	-- COMPOSITE PRIMARY KEY
) 

--       SELF REFERENCING

CREATE TABLE Teachers (
	TeacherID INT PRIMARY KEY IDENTITY,
	[Name] VARCHAR(20) NOT NULL,
	ManagerID INT FOREIGN KEY REFERENCES Teachers(TeacherID)
)

--       WILDCARD

USE SoftUni
SELECT TownID, [Name]
  FROM [Towns]
  WHERE Name LIKE '[^RBD]%'
  ORDER BY Name
GO
SELECT FirstName, LastName
FROM Employees
WHERE LEN(LastName) IN (5,6)
GO

--             SUBQUERY


SELECT * FROM 
(
	SELECT  [EmployeeID]      ,[FirstName]      ,[LastName]      ,[Salary]
	  ,DENSE_RANK() OVER (PARTITION BY SALARY ORDER BY EMPLOYEEID) AS [Rank] 
  FROM [Employees]
  WHERE Salary BETWEEN 10000 AND 50000
  )
  AS RankingSubqueury
  WHERE [Rank] = 2
  ORDER BY Salary DESC

GO
USE Geography
SELECT  p.PEAKNAME
	 , r.[RiverName]
	 , LOWER(CONCAT(LEFT(p.PEAKNAME, LEN(P.PEAKNAME) - 1), R.RIVERNAME)) AS MiX
  FROM  [Rivers] AS r
  , Peaks AS p
 WHERE RIGHT(P.PeakName, 1) = LEFT(R.RiverName, 1)
  ORDER BY Mix 
GO
USE Diablo
SELECT [Username]     
      ,SUBSTRING([Email], CHARINDEX('@', Email) + 1, LEN(Email)) AS [Email Provider]
  FROM [Users]
  ORDER BY [Email Provider], USERNAME
GO

--           CASE 
				--WHEN     THEN
				--ELSE
				--END AS 
SELECT [Name]
      ,CASE
		WHEN DATEPART(HOUR, [Start]) BETWEEN 0 AND 11 THEN 'Morning'
		WHEN DATEPART(HOUR, [Start]) BETWEEN 12 AND 17 THEN 'Afternoon'
		ELSE 'Evening'
		END AS [Part of the Day]
      ,CASE
		WHEN Duration <= 3 THEN 'Extra Short'
		WHEN Duration BETWEEN 4 AND 6 THEN 'Short'
		WHEN Duration > 6 THEN 'Long'
		ELSE 'Extra Long'
		END AS Duration
  FROM [Games] AS g
  ORDER BY g.[Name], Duration

  GO
  SELECT TOP (50) [Name]
      ,FORMAT([Start], 'yyyy-MM-dd') AS [Start]
  FROM [Games]
  WHERE DATEPART(YEAR, [Start]) BETWEEN 2011 AND 2012 
  ORDER BY [Start], [Name]
  GO
  use Orders
  SELECT [ProductName]
      ,[OrderDate]
	  , DATEADD(DAY, 3, ORDERDATE ) AS [Pay Due]
	  , DATEADD(MONTH, 1 , ORDERDATE) AS [Deliver Due]
  FROM [Orders]
  --    GROUP BY
  GO
  SELECT 
	DepositGroup
	,IsDepositExpired
	,AVG(DepositInterest) AS AverageInterest
FROM WizzardDeposits
WHERE DepositStartDate > '1985-01-01'
GROUP BY DepositGroup, IsDepositExpired
ORDER BY DepositGroup DESC, IsDepositExpired
GO
---  LEAD
SELECT 
	SUM([Host Wizard Deposit] - [Guest Wizard Deposit])
		AS SumDifference
	FROM (
SELECT 
	FirstName 
		AS [Host Wizard]
	,DepositAmount 
		AS [Host Wizard Deposit]
	,LEAD(FirstName) OVER(ORDER BY Id) 
		AS [Guest Wizard]
	,LEAD(DepositAmount) OVER(ORDER BY Id) 
		AS [Guest Wizard Deposit]
FROM WizzardDeposits ) AS sub
WHERE [Guest Wizard] IS NOT NULL
GO
--  SELECT INTO NEW TABLE
SELECT * 
	INTO [NewTable]
	FROM Employees
WHERE Salary > 30000
DELETE FROM newTable WHERE ManagerID = 42
UPDATE newTable
	SET 
		Salary = Salary + 5000
	WHERE DepartmentID = 1
SELECT DepartmentID,AVG(Salary) AS [AverageSalary] FROM newTable
GROUP BY DepartmentID
GO
SELECT DISTINCT DepartmentID
	,Salary AS ThirdHighestSalary
 FROM (
	SELECT DepartmentID
		,Salary
		,DENSE_RANK() OVER(PARTITION BY DepartmentID ORDER BY Salary DESC)
			AS SalaryRank
	FROM Employees ) AS sub
WHERE SalaryRank = 3
GO
-- PROCEDURES
CREATE PROC usp_GetEmployeesSalaryAbove35000
AS
SELECT FirstName, LastName
FROM Employees
WHERE Salary > 35000
GO
CREATE OR ALTER PROC usp_GetTownsStartingWith  (@INPUT VARCHAR(20))
AS
SELECT [Name]
FROM Towns
WHERE @INPUT = LEFT(Name, LEN(@INPUT))

