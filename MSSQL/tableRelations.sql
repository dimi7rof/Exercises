-- 09

SELECT 
M.MountainRange, P.PeakName, P.Elevation
FROM Mountains AS m
LEFT JOIN PEAKS AS p
ON P.MountainId = M.Id
WHERE MountainRange = 'Rila'
ORDER BY P.Elevation DESC
 
 --06

 create table Majors
(
	MajorID int primary key,
	[Name] varchar(50)
)
create table Subjects(
	SubjectID int primary key,
	SubjectName varchar(50)
)
create table Students(
	StudentID int primary key,
	StudentNumber int not null,
	StudentName varchar(50),
	MajorID int foreign key references Majors(MajorID)
)
create table Payments(
	PaymentID int primary key,
	PaymentDate datetime2,
	PaymentAmount decimal(5,2),
	StudentID int foreign key references Students(StudentID)
)
create table Agenda (
	StudentID int foreign key references Students(StudentID),
	SubjectID int foreign key references Subjects(SubjectID),
	primary key (StudentID, SubjectID)
)

-- 05 (66%)

CREATE TABLE Cities (
	CityID int primary key identity,
	[Name] varchar(50) not null
)
CREATE TABLE Customers(
	CustomerID int primary key identity,
	[Name] varchar(50) not null,
	Birthday date,
	CityID int foreign key references Cities(CityID)
)
CREATE TABLE Orders (
	OrderID int primary key identity,
	CustomersID int foreign key references Customers(CustomerID) not null
)
CREATE TABLE ItemTypes (
	ItemTypeID int primary key identity,
	[Name] varchar(50) not null
)
CREATE TABLE Items (
	ItemID int primary key identity, 
	[Name] varchar(50) not null,
	ItemTypeID int foreign key references ItemTypes(ItemTypeID)
)
CREATE TABLE OrderItems (
	OrderID int foreign key references Orders(OrderID),
	ItemID int foreign key references Items(ItemID),
	primary key (OrderID, ItemID)
)

-- 04  Self-Referencing
CREATE TABLE Teachers (
	TeacherID INT PRIMARY KEY IDENTITY,
	[Name] VARCHAR(20) NOT NULL,
	ManagerID INT FOREIGN KEY REFERENCES Teachers(TeacherID)
)

-- 03 Many-To-Many Relationship

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

-- 02 One-To-Many Relationship

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
INSERT INTO Manufacturers (Name, EstablishedOn)
VALUES
('BMW', '07/03/1916'),
('Tesla', '01/01/2003'),
('Lada', '01/05/1966')
INSERT INTO Models (Name, ManufacturerID)
VALUES
('X1', 1),
('i6',1),
('Model S', 2),
('Model X', 2),
('Model 3', 2),
('Nova', 3)

-- 01 One-To-One Relationship

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

INSERT INTO [Passports]([PassportNumber])
VALUES 
('N34FG21B'),
('K65LO4R7'),
('ZE657QP2')
INSERT INTO Persons(FirstName, Salary, PassportID)
	VALUES 
	('Roberto', 43300.00, 102),
	('Tom', 56100.00, 103),
	('Yana', 60200.00, 101)