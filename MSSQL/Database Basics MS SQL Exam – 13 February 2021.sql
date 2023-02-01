--1
 
 CREATE TABLE Users (
	Id INT PRIMARY KEY IDENTITY,
	Username VARCHAR(30),
	Password VARCHAR (30),
	Email VARCHAR(50)
)
CREATE TABLE Repositories (
	Id INT PRIMARY KEY IDENTITY,
	[Name] VARCHAR(50) NOT NULL
	)
	
	CREATE  TABLE RepositoriesContributors (
	RepositoryId INT FOREIGN KEY REFERENCES Repositories(Id) NOT NULL,
	ContributorId INT FOREIGN KEY REFERENCES Users(Id) NOT NULL,
	PRIMARY KEY (RepositoryId, ContributorId)
	)

	CREATE TABLE Issues (
	Id INT PRIMARY KEY IDENTITY,
Title VARCHAR(255) NOT NULL,
IssueStatus VARCHAR(6) NOT NULL,
RepositoryId INT FOREIGN KEY REFERENCES Repositories(Id) NOT NULL,
AssigneeId  INT FOREIGN KEY REFERENCES Users(Id) NOT NULL
	)

	CREATE TABLE Commits (
	Id INT PRIMARY KEY IDENTITY,
[Message]  VARCHAR(255) NOT NULL,
IssueId INT FOREIGN KEY REFERENCES Issues(Id),
RepositoryId INT FOREIGN KEY REFERENCES Repositories(Id) NOT NULL,
ContributorId INT FOREIGN KEY REFERENCES Users(Id) NOT NULL
	)

	CREATE TABLE Files (
	Id  INT PRIMARY KEY IDENTITY,
[Name]  VARCHAR(100) NOT NULL,
Size DECIMAL(18,2) NOT NULL,
ParentId INT FOREIGN KEY REFERENCES Files(Id),
CommitId INT FOREIGN KEY REFERENCES Commits(Id)	
	)

--2

INSERT INTO Files ([Name], Size, CommitId)
VALUES
('Trade.idk',	2598.0, 1),
('menu.net',	9238.31, 2),
('Administrate.soshy',	1246.93, 3),
('Controller.php',	7353.15,4),
('Find.java',	9957.86,5),
('Controller.json',	14034.87,6),
('Operate.xix',	7662.92,7)

INSERT INTO Issues (Title, IssueStatus, RepositoryId, AssigneeId)
VALUES
('Critical Problem with HomeController.cs file',	'open',	1	,4),
('Typo fix in Judge.html',	'open',	4,	3),
('Implement documentation for UsersService.cs',	'closed',	8	,2),
('Unreachable code in Index.cs',	'open',	9,	8)


--3

UPDATE ISSUES
SET IssueStatus = 'closed'
WHERE AssigneeId = 6
 
 --4

 DELETE FROM Commits
WHERE IssueId IN  (SELECT Id FROM Issues
 WHERE RepositoryId = ( SELECT Id FROM Repositories
	WHERE [Name] = 'Softuni-Teamwork'))

-- ^ NOT NESSESARY

DELETE FROM RepositoriesContributors
WHERE RepositoryId = ( SELECT Id FROM Repositories
	WHERE [Name] = 'Softuni-Teamwork')

DELETE FROM Issues WHERE RepositoryId = ( SELECT Id FROM Repositories
	WHERE [Name] = 'Softuni-Teamwork')
 
 -- 5

 SELECT Id, [Message], RepositoryId, ContributorId
 FROM Commits
 ORDER BY Id,[Message],RepositoryId,ContributorId
 
 --6

 SELECT ID,[Name], Size
 FROM Files
 WHERE SIZE > 1000
	AND [Name] LIKE '%html%'
ORDER BY Size DESC,Id, [Name]

--7

SELECT I.Id,
CONCAT(U.Username, ' : ',I.Title) AS IssueAssignee
FROM Issues AS i
JOIN Users AS u
ON I.AssigneeId = U.Id
ORDER BY i.Id DESC, i.AssigneeId

--8

SELECT f.Id, f.[Name], CONCAT(f.Size, 'KB') AS Size
FROM Files AS f
LEFT JOIN Files AS ff
ON f.Id = ff.ParentId
WHERE ff.ParentId IS NULL
ORDER BY f.Id,f.Name, f.Size DESC

--9

SELECT TOP (5) 
r.Id, r.Name, COUNT (*) AS Commits
FROM Repositories AS r
JOIN Commits AS c
ON c.RepositoryId = r.Id
JOIN RepositoriesContributors AS rc
ON rc.RepositoryId = r.Id
GROUP BY r.Id, r.Name
ORDER BY Commits DESC, r.Id, r.Name

-- 10 

SELECT   u.Username, AVG(f.Size) AS Size FROM Commits AS c
JOIN Users AS u ON u.Id = c.ContributorId
JOIN Files AS f ON f.CommitId = c.Id
GROUP BY  u.Username
 ORDER BY Size DESC, Username

--11
GO
CREATE FUNCTION udf_AllUserCommits(@username VARCHAR(30)) 
RETURNS INT
AS
BEGIN
DECLARE @uID INT  = (
		SELECT Id
		FROM Users 
		WHERE Username = @username
		)
		DECLARE @cCNT INT = (
			SELECT COUNT(Id)
			FROM Commits
			WHERE ContributorId = @uID
		)
		RETURN @cCNT
END
GO
SELECT dbo.udf_AllUserCommits('UnderSinduxrein')

GO --12

CREATE PROC usp_SearchForFiles @fileExtension VARCHAR(30)
AS
BEGIN
	SELECT Id, Name, CONCAT(Size, 'KB') AS Size
	FROM Files
	WHERE Name LIKE CONCAT('%[.]', @fileExtension)
	ORDER BY Id, Name, Size DESC
END