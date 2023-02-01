DROP DATABASE CigarShop
CREATE DATABASE CigarShop
USE CigarShop

--01

CREATE TABLE Sizes (
Id INT PRIMARY KEY IDENTITY,
[Length] INT CHECK ([Length] >= 10 AND [Length] <= 25) NOT NULL,
RingRange DECIMAL(18,2) CHECK (RingRange >= 1.5 AND RingRange <= 7.5) NOT NULL
)
CREATE TABLE Tastes (
Id INT PRIMARY KEY IDENTITY,
TasteType VARCHAR(20) NOT NULL,
TasteStrength VARCHAR(15) NOT NULL,
ImageURL NVARCHAR(100) NOT NULL
)
CREATE TABLE Brands(
Id INT PRIMARY KEY IDENTITY,
BrandName VARCHAR(30) UNIQUE NOT NULL,
BrandDescription VARCHAR(MAX)
)
CREATE TABLE Cigars (
Id INT PRIMARY KEY IDENTITY,
CigarName VARCHAR(80) NOT NULL,
BrandId INT FOREIGN KEY REFERENCES Brands(Id) NOT NULL,
TastId INT FOREIGN KEY REFERENCES Tastes(Id) NOT NULL,
SizeId INT FOREIGN KEY REFERENCES Sizes(Id) NOT NULL ,
PriceForSingleCigar DECIMAL(18,2) NOT NULL,
ImageURL NVARCHAR(100) NOT NULL
)

CREATE TABLE Addresses (
Id INT PRIMARY KEY IDENTITY,
Town VARCHAR(30) NOT NULL,
Country NVARCHAR(30) NOT NULL,
Streat NVARCHAR(100) NOT NULL,
ZIP VARCHAR(20) NOT NULL
)
CREATE TABLE Clients (
Id INT PRIMARY KEY IDENTITY,
FirstName NVARCHAR(30) NOT NULL,
LastName NVARCHAR(30) NOT NULL,
Email NVARCHAR(50) NOT NULL,
AddressId INT FOREIGN KEY REFERENCES Addresses(Id) NOT NULL, 
)
CREATE TABLE ClientsCigars (
ClientId INT FOREIGN KEY REFERENCES Clients(Id) NOT NULL, 
CigarId INT FOREIGN KEY REFERENCES Cigars(Id) NOT NULL
PRIMARY KEY (ClientId, CigarId)
)

--02

INSERT INTO Cigars 
(CigarName, BrandId, TastId, SizeId, PriceForSingleCigar, ImageURL)
VALUES
('COHIBA ROBUSTO',	9,	1,	5,	15.50,	'cohiba-robusto-stick_18.jpg'),
('COHIBA SIGLO I',	9,	1,	10,	410.00,	'cohiba-siglo-i-stick_12.jpg'),
('HOYO DE MONTERREY LE HOYO DU MAIRE',	14,	5,	11,	7.50,	'hoyo-du-maire-stick_17.jpg'),
('HOYO DE MONTERREY LE HOYO DE SAN JUAN',	14,	4,	15,	32.00,	'hoyo-de-san-juan-stick_20.jpg'),
('TRINIDAD COLONIALES',	2,	3,	8,	85.21,	'trinidad-coloniales-stick_30.jpg')

INSERT INTO Addresses (Town,	Country,	Streat,	ZIP)
VALUES
('Sofia',	'Bulgaria',	'18 Bul. Vasil levski',	1000),
('Athens',	'Greece',	'4342 McDonald Avenue',	10435),
('Zagreb',	'Croatia',	'4333 Lauren Drive',	10000)

--03

UPDATE Cigars
SET PriceForSingleCigar = PriceForSingleCigar * 1.2
WHERE TastId = 1

UPDATE Brands
SET BrandDescription = 'New description'
WHERE BrandDescription IS NULL

--04

DELETE FROM Clients
WHERE AddressId IN (SELECT Id FROM Addresses WHERE Country LIKE 'C%')

DELETE FROM  Addresses
WHERE Country LIKE 'C%'

--05

SELECT CigarName, PriceForSingleCigar, ImageURL
FROM Cigars
ORDER BY PriceForSingleCigar, CigarName DESC

--06

SELECT c.Id,	CigarName,	PriceForSingleCigar,	TasteType,	TasteStrength
FROM Cigars AS c
JOIN Tastes AS t
ON t.Id = c.TastId
WHERE TasteType IN ('Earthy', 'Woody')
ORDER BY PriceForSingleCigar DESC

--07

SELECT Id, CONCAT(FirstName, ' ', LastName) AS ClientName, Email
FROM Clients AS cl
LEFT JOIN ClientsCigars AS cc
ON cc.ClientId = cl.Id
WHERE CigarId IS NULL
ORDER BY 2

--08 NOT WORK

SELECT 
--TOP(5) 
CigarName, PriceForSingleCigar, ImageURL 
,Length, RingRange
FROM Cigars AS c
JOIN Sizes AS s
ON s.Id = c.SizeId
WHERE 
(Length > 12 AND CigarName LIKE '%ci%') OR
(PriceForSingleCigar > 50 AND RingRange > 2.55)
	ORDER BY CigarName, PriceForSingleCigar DESC

--09

SELECT DISTINCT CONCAT(FirstName, ' ', LastName) AS FullName,
a.Country, a.ZIP
,RANK() OVER (PARTITION BY c.Id ORDER BY PriceForSingleCigar) AS CigarPrice
FROM Clients AS c
JOIN Addresses AS a
ON a.Id = c.AddressId
JOIN ClientsCigars AS cc
ON cc.ClientId = c.Id
JOIN Cigars AS ci
ON ci.Id = cc.CigarId
WHERE ZIP NOT LIKE '%[a-zA-Z][a-zA-Z]%'
ORDER BY 1



--10

SELECT LastName,
AVG(s.Length) AS CiagrLength,
CEILING(AVG(s.RingRange)) AS CiagrRingRange
FROM Clients AS cl
JOIN ClientsCigars AS cc
ON cc.ClientId = cl.Id
JOIN Cigars AS c
ON c.Id = cc.CigarId
JOIN Sizes AS s
ON s.Id = c.SizeId
GROUP BY LastName
ORDER BY 2 DESC

GO--11

CREATE FUNCTION udf_ClientWithCigars(@name NVARCHAR(30))
RETURNS INT
AS
BEGIN
DECLARE @out INT
SET @out =
 (SELECT COUNT(CigarId) 
	FROM ClientsCigars AS cc
	JOIN Clients AS c ON c.Id = cc.ClientId
	WHERE cc.ClientId IN (
			SELECT Id FROM Clients
			--WHERE FirstName = 'Rachel')
			WHERE FirstName = @name)
	GROUP BY CC.ClientId)
RETURN @out
END
GO
SELECT dbo.udf_ClientWithCigars('Rachel')

GO -- 12

CREATE PROC usp_SearchByTaste(@taste VARCHAR(20))
AS
BEGIN
	SELECT CigarName
		,CONCAT('$',PriceForSingleCigar) AS Price
		, TasteType
		, BrandName
		,CONCAT(Length, ' cm') AS  CigarLength
		,CONCAT(RingRange, ' cm') AS CigarRingRange
	FROM Tastes AS t
	JOIN Cigars AS c ON c.TastId = t.Id
	JOIN Brands AS b ON b.Id = c.BrandId
	JOIN Sizes AS s ON s.Id = c.SizeId
	WHERE TasteType = @taste
	ORDER BY Length, RingRange DESC
END