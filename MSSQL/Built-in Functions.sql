--01. Find Names of All Employees by First Name

SELECT
      [FirstName]
      ,[LastName]
  FROM [Employees]
  WHERE SUBSTRING(FirstName, 1, 2) = 'Sa'

--02. Find Names of All Employees by Last Name

SELECT
      [FirstName]
      ,[LastName]
  FROM [Employees]
  WHERE  LastName LIKE '%ei%'

--03. Find First Names of All Employess

SELECT 
      [FirstName]
	 
  FROM [Employees]
 WHERE  DATEPART(YEAR, HIREDATE) BETWEEN 1995 AND 2005
  AND DepartmentID = 10
  OR DepartmentID =3

--04. Find All Employees Except Engineers

SELECT 
      [FirstName]
	  , LastName
  FROM [Employees]
WHERE  JobTitle NOT LIKE '%engineer%'

--05. Find Towns with Name Length

SELECT [Name]
  FROM [Towns]
  WHERE LEN([Name]) = 5
	OR LEN([Name]) = 6
	ORDER BY Name

--06. Find Towns Starting With

SELECT TownID, [Name]
  FROM [Towns]
  WHERE Name LIKE '[MKBE]%'
  ORDER BY Name

--07. Find Towns Not Starting With

SELECT TownID, [Name]
  FROM [Towns]
  WHERE Name LIKE '[^RBD]%'
  ORDER BY Name

--08. Create View Employees Hired After

CREATE VIEW [V_EmployeesHiredAfter2000] AS
SELECT
FirstName, LastName
FROM Employees
WHERE DATEPART(YEAR, HireDate) > 2000

--09. Length of Last Name

SELECT
FirstName, LastName
FROM Employees
WHERE LEN(LastName) = 5

--10. Rank Employees by Salary

SELECT  [EmployeeID]
      ,[FirstName]
      ,[LastName]
      ,[Salary]
	  ,DENSE_RANK() OVER (PARTITION BY SALARY ORDER BY EMPLOYEEID) AS [Rank] 
  FROM [Employees]
  WHERE Salary BETWEEN 10000 AND 50000
  ORDER BY Salary DESC

--11. Find All Employees with Rank 2

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

--12. Countries Holding 'A'

SELECT[CountryName]
	   ,[IsoCode]
  FROM [Countries]
  WHERE CountryName LIKE '%A%A%A%'
  ORDER BY IsoCode

--13. Mix of Peak and River Names

SELECT  p.PEAKNAME
	 , r.[RiverName]
	 , LOWER(CONCAT(LEFT(p.PEAKNAME, LEN(P.PEAKNAME) - 1), R.RIVERNAME)) AS MiX
  FROM  [Rivers] AS r
  , Peaks AS p
 WHERE RIGHT(P.PeakName, 1) = LEFT(R.RiverName, 1)
  ORDER BY Mix 

--14. Games From 2011 and 2012 Year

SELECT TOP (50) [Name]
      ,FORMAT([Start], 'yyyy-MM-dd') AS [Start]
  FROM [Games]
  WHERE DATEPART(YEAR, [Start]) BETWEEN 2011 AND 2012 
  ORDER BY [Start], [Name]

--15. User Email Providers

SELECT [Username]     
      ,SUBSTRING([Email], CHARINDEX('@', Email) + 1, LEN(Email)) AS [Email Provider]
  FROM [Users]
  ORDER BY [Email Provider], USERNAME

--16. Get Users with IPAddress Like Pattern

SELECT[Username]
      ,[IpAddress]
  FROM [Users]
  WHERE [IpAddress] LIKE '___.1%.%.___'
  ORDER BY [Username]

--17. Show All Games with Duration

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

--18. Orders Table

SELECT [ProductName]
      ,[OrderDate]
	  , DATEADD(DAY, 3, ORDERDATE ) AS [Pay Due]
	  , DATEADD(MONTH, 1 , ORDERDATE) AS [Deliver Due]
  FROM [Orders]