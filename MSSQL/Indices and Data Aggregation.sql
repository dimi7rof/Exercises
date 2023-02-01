--01

SELECT 
	COUNT(*) AS [Count]
FROM WizzardDeposits

--02

SELECT 
	MAX(MagicWandSize) AS LongestMagicWand
FROM WizzardDeposits

--03

SELECT 
	DepositGroup
	,MAX(MagicWandSize) AS LongestMagicWand
FROM WizzardDeposits
GROUP BY DepositGroup

--04

SELECT TOP 2
	DepositGroup
FROM WizzardDeposits
GROUP BY DepositGroup
ORDER BY AVG(MagicWandSize)

--05

SELECT 
	DepositGroup
	,SUM(DepositAmount) AS TotalSum
FROM WizzardDeposits
GROUP BY DepositGroup

--06

SELECT 
	DepositGroup
	,SUM(DepositAmount) AS TotalSum
FROM WizzardDeposits
WHERE MagicWandCreator = 'Ollivander family'
GROUP BY DepositGroup

--07

SELECT 
	DepositGroup
	,SUM(DepositAmount) AS TotalSum
FROM WizzardDeposits
WHERE MagicWandCreator = 'Ollivander family'	
GROUP BY DepositGroup
HAVING SUM(DepositAmount) < 150000
ORDER BY TotalSum DESC

--08

SELECT 
	DepositGroup
	,MagicWandCreator
	,MIN(DepositCharge) AS MinDepositCharge
FROM WizzardDeposits
GROUP BY DepositGroup , MagicWandCreator
ORDER BY MagicWandCreator, DepositGroup

--09

SELECT *
  ,COUNT(*) AS [WizzardCount] 
 FROM (
   SELECT 
	CASE
	 WHEN Age BETWEEN 0 AND 10 THEN '[0-10]'
	 WHEN Age BETWEEN 11 AND 20 THEN '[11-20]'
	 WHEN Age BETWEEN 21 AND 30 THEN '[21-30]'
	 WHEN Age BETWEEN 31 AND 40 THEN '[31-40]'
	 WHEN Age BETWEEN 41 AND 50 THEN '[41-50]'
	 WHEN Age BETWEEN 51 AND 60 THEN '[51-60]'
	 ELSE '[61+]'
	END AS [AgeGroup]
  FROM WizzardDeposits) AS sub
GROUP BY sub.AgeGroup

--10

SELECT * 
	FROM (
		SELECT LEFT(FirstName,1) AS FirstLetter
		FROM WizzardDeposits
	WHERE DepositGroup = 'Troll Chest' ) AS sub
GROUP BY sub.FirstLetter

--11

SELECT 
	DepositGroup
	,IsDepositExpired
	,AVG(DepositInterest) AS AverageInterest
FROM WizzardDeposits
WHERE DepositStartDate > '1985-01-01'
GROUP BY DepositGroup, IsDepositExpired
ORDER BY DepositGroup DESC, IsDepositExpired

--12

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

--13

SELECT
DepartmentID
,SUM(Salary) AS TotalSalary
FROM Employees
GROUP BY DepartmentID
ORDER BY DepartmentID

--14

SELECT
DepartmentID
,MIN(Salary) AS MinimumSalary
FROM Employees
WHERE DepartmentID IN (2,5,7)
	AND HireDate > '2000-01-01'
GROUP BY DepartmentID
ORDER BY DepartmentID

--15

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

--16

SELECT * FROM (
	SELECT DepartmentID
		  ,MAX(Salary) AS [MaxSalary] 
	 FROM Employees
GROUP BY DepartmentID ) AS a
WHERE a.MaxSalary NOT BETWEEN 30000 AND 70000

--17

SELECT COUNT(*) AS [Count]
FROM Employees
WHERE ManagerID IS NULL

--18

SELECT DISTINCT DepartmentID
	,Salary AS ThirdHighestSalary
 FROM (
	SELECT DepartmentID
		,Salary
		,DENSE_RANK() OVER(PARTITION BY DepartmentID ORDER BY Salary DESC)
			AS SalaryRank
	FROM Employees ) AS sub
WHERE SalaryRank = 3

-- 19

SELECT TOP 10
	FirstName
	,LastName
	,DepartmentID
FROM Employees AS e
WHERE Salary > (SELECT AVG(Salary) AS AVGSALARY
			FROM Employees as se
			WHERE se.DepartmentID = e.DepartmentID
			GROUP BY DepartmentID)
ORDER BY e.DepartmentID
