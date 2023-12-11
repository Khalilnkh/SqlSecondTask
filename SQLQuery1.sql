CREATE DATABASE Devices
GO

USE Devices

CREATE TABLE Brands(
ID INT IDENTITY PRIMARY KEY,
[Name] NVARCHAR(30)
)

INSERT INTO Brands VALUES
('Apple'),
('Samsung'),
('Fujitsu'),
('Xiaomi'),
('Asus')

CREATE TABLE Laptops(
ID INT IDENTITY PRIMARY KEY,
[Name] NVARCHAR(30),
Price NUMERIC,
BrandID INT FOREIGN KEY REFERENCES Brands(ID)
)

INSERT INTO Laptops VALUES
('Macbook ', 1200, 1),
('Samsung Galaxy', 1390, 2),
('Fujitsu ZPro', 1250, 3),
('Xiaomi Book', 900, 4),
('ASUS Zenbook Pro', 560, 5),
('MacBook Air15', 22000, 1),
('Samsung Z Flip', 1620, 2),
('Fujitsu Book', 3690, 3),
('Xiaomi RedMi Not 8', 290, 4),
('ASUS TUF Dash', 3780, 5),
('MacBook Pro', 6900, 1),
('MacBook Pro M1', 2500, 1),
('ASUS F515', 990, 5)


CREATE TABLE Phones(
ID INT IDENTITY PRIMARY KEY,
[Name] NVARCHAR(30),
Price NUMERIC,
BrandID INT FOREIGN KEY REFERENCES Brands(ID)
)

INSERT INTO Phones VALUES
('iPhoneXS', 400, 1),
('Galaxy S3', 960, 2),
('Fujitsu S58', 750, 3),
('Xiaomi Phone', 1500, 4),
('ASUS ROG7', 1100, 5),
('iPhone15 Pro Max', 5000, 1),
('Galaxy sS', 5600, 2),
('Xiaomi Mi8', 1800, 3),
('Fujitsu M89 ', 700, 4),
('ASUS ZenFone', 1900, 5)





--Task 3
SELECT L.[Name], B.[Name] AS BrandName, L.Price 
FROM Laptops AS L
JOIN
Brands AS B ON L.BrandID = B.ID

--Task 4
SELECT P.[Name], B.[Name] AS BrandName, P.Price 
FROM Phones AS P
JOIN
Brands AS B ON P.BrandID = B.ID

--Task5
SELECT * FROM Brands
WHERE [Name] LIKE '%s%'

--Task6
SELECT * FROM Laptops
WHERE (Price BETWEEN 2000 AND 5000) OR Price>5000

--Task7
SELECT * FROM Phones
WHERE (Price BETWEEN 1000 AND 1500) OR Price>1500

--Task8
SELECT B.[Name], COUNT(L.ID) AS LaptopCount
FROM Laptops AS L
JOIN
Brands AS B ON L.BrandID = B.ID
GROUP BY B.[Name]

--Task9
SELECT B.[Name], COUNT(P.ID) AS PhoneCount 
FROM Phones AS P
JOIN
Brands AS B ON P.BrandID = B.ID
GROUP BY B.[Name]

--Task10
SELECT [Name], BrandID FROM Phones 
UNION 
SELECT [Name], BrandID FROM Laptops

--Task11
SELECT * FROM Phones
UNION ALL
SELECT * FROM Laptops
GO

--Create VIEW
--
CREATE VIEW AllDevice
AS
SELECT
    'Phone' AS DeviceType,
    P.ID AS DeviceId,
    P.[Name] AS DeviceName, 
    P.Price AS DevicePrice,
    B.[Name] AS BrandName 
FROM Phones AS P
JOIN Brands AS B ON P.BrandID = B.ID

UNION ALL

SELECT
    'Laptop' AS DeviceType,
    L.ID AS DeviceId,
    L.[Name] AS DeviceName, 
    L.Price AS DevicePrice,
	B.[Name] AS BrandName 
FROM Laptops AS L
JOIN Brands AS B ON L.BrandID = B.ID
GO
--
--

--Task12
SELECT * FROM AllDevice

--Task13
SELECT * FROM AllDevice
WHERE DevicePrice > 1000

--Task14
SELECT B.[Name] AS BrandName, SUM(P.Price) AS TotalPrice, COUNT(P.ID) AS ProductCount 
FROM Phones AS P
JOIN
Brands AS B ON P.BrandID = B.ID
GROUP BY B.[Name]

--Task15
SELECT B.[Name] AS BrandName, SUM(L.Price) AS TotalPrice, COUNT(L.ID) AS ProductCount 
FROM Laptops AS L
JOIN
Brands AS B ON L.BrandID = B.ID
GROUP BY B.[Name]
HAVING COUNT(L.ID) >= 3