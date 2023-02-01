CREATE DATABASE Zoo
 USE Zoo
 GO

CREATE TABLE Owners (
	Id INT PRIMARY KEY IDENTITY,
	Name VARCHAR(50) NOT NULL,
	PhoneNumber VARCHAR(15) NOT NULL,
	Address VARCHAR(50)
)

CREATE TABLE AnimalTypes (
	Id INT PRIMARY KEY IDENTITY,
	AnimalType VARCHAR(30) NOT NULL
)

CREATE TABLE Cages (
	Id INT PRIMARY KEY IDENTITY,
	AnimalTypeId INT FOREIGN KEY REFERENCES AnimalTypes(Id) NOT NULL
)

CREATE TABLE Animals (
	Id INT PRIMARY KEY IDENTITY,
	Name VARCHAR(30) NOT NULL,
	BirthDate DATE NOT NULL,
	OwnerId INT FOREIGN KEY REFERENCES Owners(Id),
	AnimalTypeId INT FOREIGN KEY REFERENCES AnimalTypes(Id) NOT NULL
)

CREATE TABLE AnimalsCages (
	CageId INT UNIQUE FOREIGN KEY REFERENCES Cages(Id) NOT NULL,
	AnimalId INT UNIQUE FOREIGN KEY REFERENCES Animals(Id) NOT NULL,
	PRIMARY KEY (CageId, AnimalId)
)

CREATE TABLE VolunteersDepartments (
	Id INT PRIMARY KEY IDENTITY,
	DepartmentName VARCHAR(30) NOT NULL
)

CREATE TABLE Volunteers (
	Id INT PRIMARY KEY IDENTITY,
	Name VARCHAR(50) NOT NULL,
	PhoneNumber VARCHAR(15) NOT NULL,
	Address VARCHAR(50),
	AnimalId INT  FOREIGN KEY REFERENCES Animals(Id),
	DepartmentId INT  FOREIGN KEY REFERENCES VolunteersDepartments(Id) NOT NULL
)

--02

INSERT INTO Volunteers (Name, PhoneNumber, Address, AnimalId, DepartmentId)
VALUES
('Anita Kostova', '0896365412', 'Sofia, 5 Rosa str.', 15,	1),
('Dimitur Stoev', '0877564223',	null,	42,	4),
('Kalina Evtimova',	'0896321112',	'Silistra, 21 Breza str.',	9,	7),
('Stoyan Tomov',	'0898564100',	'Montana, 1 Bor str.',	18,	8),
('Boryana Mileva',	'0888112233',	null,	31,	5)

INSERT INTO Animals (Name, BirthDate, OwnerId, AnimalTypeId)
VALUES
('Giraffe',	'2018-09-21',	21,	1),
('Harpy Eagle',	'2015-04-17',	15,	3),
('Hamadryas Baboon',	'2017-11-02',	null,	1),
('Tuatara',	'2021-06-30',	2,	4)

--03

UPDATE Animals
SET OwnerId = 4
WHERE OwnerId IS NULL

--04
DELETE FROM Volunteers
WHERE DepartmentId = 2

DELETE FROM VolunteersDepartments
WHERE DepartmentName = 'Education program assistant'



--05

SELECT 
Name, PhoneNumber, Address, AnimalId, DepartmentId
FROM Volunteers
ORDER BY Name, AnimalId, DepartmentId

--06

SELECT
Name, AnimalType,  FORMAT(BirthDate, 'dd.MM.yyyy')
FROM Animals AS a
JOIN AnimalTypes AS at
ON a.AnimalTypeId = at.Id
ORDER BY Name

--07

SELECT TOP(5)
o.Name, COUNT(a.OwnerId) AS CountOfAnimals
FROM Owners AS o
JOIN Animals AS a
ON a.OwnerId = o.Id
GROUP BY o.Name
ORDER BY CountOfAnimals DESC, Name

--08

SELECT 
CONCAT(o.Name, '-',a.Name) AS OwnersAnimals, PhoneNumber, CageId
FROM Animals AS a
JOIN Owners AS o
ON a.OwnerId = o.Id
JOIN AnimalsCages AS ac
ON ac.AnimalId = a.Id
JOIN AnimalTypes AS at
ON at.Id = a.AnimalTypeId
WHERE at.AnimalType = 'mammals'
ORDER BY o.Name, a.Name DESC

--09 ****

SELECT
v.Name, PhoneNumber,
--SUBSTRING(Address, 8, DATALENGTH(Address))
REPLACE(REPLACE(Address, 'Sofia, ', ''), 'Sofia , ', '')
FROM Volunteers AS v
JOIN VolunteersDepartments AS vd
ON vd.Id = v.DepartmentId
WHERE vd.DepartmentName = 'Education program assistant'
	AND Address LIKE '%Sofia%'
ORDER BY v.Name

--10

SELECT
a.Name, DATEPART(YEAR, BirthDate) AS BirthYear
, at.AnimalType
 FROM Animals AS a
 JOIN AnimalTypes AS at
 ON at.Id = a.AnimalTypeId
 WHERE (OwnerId IS NULL
  AND AnimalTypeId <> 3)
  AND DATEPART(year, BirthDate) > 2017
ORDER BY a.Name

GO --11

CREATE FUNCTION udf_GetVolunteersCountFromADepartment 
(@VolunteersDepartment VARCHAR(30))
RETURNS INT
AS
BEGIN
RETURN (
	SELECT 
	COUNT(*)
	FROM VolunteersDepartments AS vd
	JOIN Volunteers AS v
	ON vd.Id = v.DepartmentId
	WHERE vd.DepartmentName = @VolunteersDepartment)
END



GO --12

CREATE PROC usp_AnimalsWithOwnersOrNot(@AnimalName VARCHAR(30))
AS
BEGIN
	SELECT
	a.Name
	,CASE 
		WHEN a.OwnerId IS NULL THEN 'For adoption'
		ELSE o.Name
		END AS OwnersName
	FROM Animals AS a
	LEFT JOIN Owners AS o
	ON o.Id = a.OwnerId
	WHERE a.Name = @AnimalName
END
