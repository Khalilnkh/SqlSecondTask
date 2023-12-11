CREATE DATABASE Library
GO

USE Library

CREATE TABLE Books(
ID INT IDENTITY PRIMARY KEY,
[Name] NVARCHAR(100) CHECK(LEN(Name) >= 2 AND LEN(Name) <= 100),
[PageCount] INT CHECK(PageCount >= 10)
)

INSERT INTO Books VALUES
('Herb Ve SUlh', 657),
('Karamazov Qardaslari', 256),
('1984', 320),
('Sakit Don', 136),
('Cinayet ve Ceza', 428),
('Mavi Melekler', 960),
('10 Zenci Balasi', 464),
('Ogru Quli', 625),
('BulBulu oldurmek', 326),
('Beyaz geceler', 555)


CREATE TABLE Authors(
ID INT IDENTITY PRIMARY KEY,
[Name] NVARCHAR(50),
Surname NVARCHAR (50)
)

INSERT INTO Authors VALUES
('LEv','Tolostoy'),
('Fyodor','Dostayevski'),
('Corc', 'Oruel'),
('Anton', 'Cexov'),
('Cingiz', 'Abdullayev'),
('Aqata', 'Kristi'),
('Harper', 'Li')


CREATE TABLE BookAuthor(
ID INT IDENTITY,
BookID INT FOREIGN KEY REFERENCES Books(ID),
AuthorID INT FOREIGN KEY REFERENCES Authors(ID)
)

INSERT INTO BookAuthor VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 2),
(6, 5),
(7, 6),
(8, 5),
(9, 7),
(9, 6),
(10, 2)




CREATE VIEW BooksAndAuthors
AS
SELECT B.ID, B.[Name], B.[PageCount], CONCAT(A.[Name],' ',A.Surname) AS FullName 
FROM Books AS B 
JOIN 
BookAuthor AS BA ON  B.ID = BA.BookID
JOIN
Authors AS A ON A.ID = BA.AuthorID
GO

SELECT * FROM BooksAndAuthors
GO

CREATE VIEW AuthorDetails
AS
SELECT A.ID,  CONCAT(A.[Name],' ',A.Surname) AS FullName, COUNT(B.ID) AS BooksCount, SUM(B.PageCount) AS MaxPageCount
FROM Authors AS A 
JOIN 
BookAuthor AS BA ON  A.ID = BA.AuthorID
JOIN
Books AS B ON B.ID = BA.BookID
GROUP BY A.ID, A.[Name], A.Surname
GO

SELECT * FROM AuthorDetails
GO

CREATE PROCEDURE sp_GetAuthorDetails @name NVARCHAR(50)
AS
BEGIN
SELECT B.ID, B.[Name], B.[PageCount], CONCAT(A.[Name],' ',A.Surname) AS FullName 
FROM Authors AS A
JOIN
BookAuthor AS BA ON  A.ID = BA.AuthorID
JOIN
Books AS B ON B.ID = BA.BookID
 WHERE A.[Name] = @name
END

GO

CREATE PROCEDURE sp_InsertToAuthor @insName NVARCHAR(50), @insSurname NVARCHAR(50)
AS
BEGIN
INSERT INTO Authors VALUES
(@insName, @insSurname)
END

GO

CREATE PROCEDURE sp_UpdateOnAuthor @id INT, @updName NVARCHAR(50), @updSurname NVARCHAR(50)
AS
BEGIN
UPDATE Authors SET [Name] = @updName, Surname = @updSurname
WHERE ID = @id
END

GO

CREATE PROCEDURE sp_DeleteFromAuthor @delId INT
AS
BEGIN
DELETE FROM Authors WHERE ID = @delId
END

