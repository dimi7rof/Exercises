--01

SELECT TOP (5) [EmployeeID]
      ,[JobTitle]
      ,e.[AddressID]
	  , a.AddressText
  FROM [Employees] as e
  join Addresses as a
  on e.AddressID = a.AddressID
  order by AddressID 

--02

SELECT TOP 50 e.FirstName
	  ,e.LastName
	  ,t.Name AS Town
      ,a.AddressText
  FROM Employees AS e
  JOIN Addresses AS a
  ON a.AddressID = e.AddressID
  JOIN Towns AS t
  ON a.TownID = t.TownID
  ORDER BY e.FirstName, e.LastName

--03

SELECT  e.EmployeeID
      ,e.FirstName
      ,e.LastName
      ,d.Name AS DepartmentName
  FROM [Employees] AS e
  JOIN Departments AS d
  ON d.DepartmentID = e.DepartmentID AND d.Name = 'Sales'
  ORDER BY e.EmployeeID

--04

SELECT TOP 5
	e.EmployeeID
	,e.FirstName
	,e.Salary
	,d.Name AS DepartmentName
FROM Employees AS e
JOIN Departments AS d
	ON d.DepartmentID = e.DepartmentID
WHERE e.Salary > 15000
  ORDER BY e.DepartmentID

--05

SELECT TOP 3
	e.EmployeeID
	,e.FirstName
FROM Employees AS e
LEFT JOIN EmployeesProjects AS ep
	ON e.EmployeeID = ep.EmployeeID
	WHERE ep.ProjectID IS NULL
ORDER BY e.EmployeeID

--06

SELECT  e.FirstName
      ,e.LastName
      ,e.HireDate
	  ,d.Name AS DeptName
  FROM Employees AS e
  JOIN Departments AS d
  ON d.DepartmentID = e.DepartmentID 
  WHERE
	e.HireDate > '1999-01-01'
	AND (d.Name = 'Sales'
	OR d.Name = 'Finance')
  ORDER BY e.HireDate

--07

SELECT TOP 5
	E.EmployeeID
	, E.FirstName
	, P.Name AS ProjectName
  FROM Employees AS e
  JOIN EmployeesProjects AS ep
  ON ep.EmployeeID = E.EmployeeID
  JOIN Projects AS p
  ON p.ProjectID = ep.ProjectID
  WHERE EndDate IS NULL
  AND StartDate > '2002-08-13'

--08

SELECT 
	e.EmployeeID
	,e.FirstName
	,p.Name AS ProjectName
FROM Employees AS e
LEFT JOIN EmployeesProjects AS ep
	ON ep.EmployeeID = e.EmployeeID
LEFT JOIN Projects AS p 
	ON p.ProjectID = ep.ProjectID 
	AND DATEPART(YEAR, P.StartDate) < 2005
WHERE e.EmployeeID = 24
	

--09

SELECT 
	E.EmployeeID
	, E.FirstName
	, E.ManagerID
	, A.FirstName	
  FROM Employees AS E
  JOIN Employees AS A
  ON E.ManagerID = A.EmployeeID
  WHERE e.ManagerID IN (3, 7)
  ORDER BY E.EmployeeID


--10

SELECT TOP 50
	  e.EmployeeID
      ,CONCAT(e.FirstName, ' ', e.LastName) AS EmployeeName
	  ,CONCAT(m.FirstName, ' ', m.LastName) AS ManagerName
	  , d.Name AS DepartmentName
  FROM Employees AS e
  LEFT JOIN Employees AS m ON e.ManagerID = m.EmployeeID
  LEFT JOIN Departments AS d ON e.DepartmentID = d.DepartmentID
  ORDER BY e.EmployeeID

--11

SELECT
	MIN(dt.AverageSalary)
FROM
	(SELECT 
		AVG(Salary) AS AverageSalary
	FROM Employees
	GROUP BY DepartmentID) AS dt

--12

SELECT 
		C.CountryCode
		,M.MountainRange
		,P.PeakName
		,P.Elevation
	FROM Countries AS c
	 JOIN CountriesRivers AS cr
		ON c.CountryCode = cr.CountryCode
	 JOIN Rivers AS r
		ON cr.RiverId = r.Id
	LEFT JOIN MountainsCountries AS mc
		ON mc.CountryCode = c.CountryCode
	 JOIN Mountains AS m
		ON M.Id = mc.MountainId
	 JOIN Peaks AS p
		ON p.MountainId = m.Id
WHERE C.CountryCode = 'BG' 
	AND P.Elevation > 2835
ORDER BY P.Elevation DESC

--13

 SELECT CountryCode
		, COUNT(MountainId)
		FROM MountainsCountries
WHERE CountryCode IN ('BG','US','RU') 
GROUP BY CountryCode

--14

SELECT TOP 5
	c.CountryName
	,r.RiverName
FROM Countries AS c
LEFT JOIN CountriesRivers AS cr
	ON c.CountryCode = cr.CountryCode
LEFT JOIN Rivers AS r
	ON r.Id = cr.RiverId
WHERE c.ContinentCode = 'AF'
ORDER BY CountryName

--15

SELECT 
	ContinentCode
	, CurrencyCode
	, CurrencyUsage
	FROM (
	 SELECT *
		, DENSE_RANK() OVER (PARTITION BY ContinentCode ORDER BY CurrencyUsage DESC) AS CurrencyRank
	  FROM (
		SELECT 
			co.ContinentCode
			,c.CurrencyCode
			,COUNT(CurrencyCode) AS CurrencyUsage
		FROM Continents AS co
		JOIN Countries AS C
		  ON c.ContinentCode = co.ContinentCode
	GROUP BY co.ContinentCode, c.CurrencyCode
	) AS CurrencyUsageQuery
	WHERE CurrencyUsage > 1
) AS CurrencyRankingQuery
WHERE CurrencyRank = 1
ORDER BY ContinentCode



--16

SELECT 
	MAX(NullRank) AS [Count]
  FROM (
	SELECT 
		c.CountryName 
		,m.MountainRange 
		,DENSE_RANK() OVER(PARTITION BY MountainRange ORDER BY CountryName )
		AS NullRank
	FROM Countries AS c
	LEFT JOIN MountainsCountries AS mc
		ON mc.CountryCode = c.CountryCode
	LEFT JOIN Mountains AS m
		ON m.Id = mc.MountainId
		) AS [Rank]

--17

SELECT TOP 5
		c.CountryName
		, MAX(p.Elevation) AS HighestPeakElevation
		, MAX(r.Length) AS LongestRiverLength
	FROM Countries AS c
	LEFT JOIN CountriesRivers AS cr
		ON c.CountryCode = cr.CountryCode
	LEFT JOIN Rivers AS r
		ON cr.RiverId = r.Id
	LEFT JOIN MountainsCountries AS mc
		ON mc.CountryCode = c.CountryCode
	LEFT JOIN Mountains AS m
		ON M.Id = mc.MountainId
	LEFT JOIN Peaks AS p
		ON p.MountainId = m.Id
	GROUP BY c.CountryName
ORDER BY HighestPeakElevation DESC, LongestRiverLength DESC, CountryName

--18

 SELECT TOP 5 Country
		,CASE
			WHEN PeakName IS NULL THEN '(no highest peak)'
			ELSE PeakName
		END AS [Highest Peak Name]
		,CASE
			WHEN Elevation IS NULL THEN 0
			ELSE Elevation
		END AS [Highest Peak Elevation]
		,CASE 
			WHEN MountainRange IS NULL THEN '(no mountain)'
			ELSE MountainRange
		END AS Mountain
 FROM ( 
  SELECT 
	c.CountryName AS Country
	,m.MountainRange
	,p.PeakName
	,p.Elevation
	,m.MountainRange AS Mountain
	,DENSE_RANK() OVER (PARTITION BY c.CountryName ORDER BY Elevation DESC)
	AS PeakRank
	FROM Countries AS c
	LEFT JOIN MountainsCountries AS mc
		ON mc.CountryCode = c.CountryCode
	LEFT JOIN Mountains AS m
		ON m.Id = mc.MountainId
	LEFT JOIN Peaks AS p
		ON p.MountainId = m.Id
		) AS PeakRankingQuery
WHERE PeakRank = 1
ORDER BY Country, [Highest Peak Name]


