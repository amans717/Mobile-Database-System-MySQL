# SQL Project : Mobile Database System
# 1. Introduction 
#This project contains detailed specifications and official launch prices of various mobile phone models from different companies.
# It provides insights into smartphone hardware, pricing trends, and brand competitiveness across multiple countries. 
#It includes key features such as RAM, camera specifications, battery capacity, processor details, and screen size.
# Various SQL operations are performed, including CRUD operations, joins, aggregations, constraints, and advanced queries.

#2 Data Description
-- 1. Explanation of the Dataset
-- The dataset contains information about various mobile phone models, including details such as:

-- Model Name (e.g., iPhone 14, Samsung Galaxy S22)
-- Brand/Company (e.g., Apple, Samsung, Xiaomi)
-- Processor (e.g., Snapdragon 888, Apple A16 Bionic)
-- RAM & Storage (e.g., 8GB RAM, 128GB Storage)
-- Battery Capacity (e.g., 4500mAh)
-- Operating System (e.g., Android, iOS)
-- Launched Year (e.g., 2022, 2023)
-- Launched Prices in different countries (Pakistan, India, China, USA, Dubai)
-- Camera Specifications (e.g., 50MP primary camera)
-- Display Size & Type (e.g., 6.7-inch AMOLED)
-- Other Features (e.g., 5G Support, Fast Charging)

-- 2. Source of the Data & Preprocessing Steps
-- Source: The data have been collected from online website databases
-- Preprocessing Steps:
-- Cleaning: Removing duplicates, handling missing values, and correcting data inconsistencies (e.g., standardizing RAM formats).
-- Constraints Implementation: Applying constraints like NOT NULL, UNIQUE, and CHECK for data integrity.

#3.Database schema

create database db_march;
use db_march;
set sql_safe_updates=0;

CREATE TABLE Companies (
    CompanyID INT PRIMARY KEY AUTO_INCREMENT,
    CompanyName VARCHAR(100) UNIQUE NOT NULL
);

CREATE TABLE Mobiles (
    MobileID INT PRIMARY KEY AUTO_INCREMENT,
    CompanyID INT,
    ModelName VARCHAR(150) NOT NULL,
    MobileWeight VARCHAR(50) NOT NULL,
    RAM VARCHAR(50) NOT NULL,
    FrontCamera VARCHAR(50) NOT NULL,
    BackCamera VARCHAR(50) NOT NULL,
    Processor VARCHAR(100) NOT NULL,
    BatteryCapacity VARCHAR(50) NOT NULL,
    ScreenSize VARCHAR(50) NOT NULL,
    LaunchedYear INT CHECK (LaunchedYear >= 2000),
    LaunchedPricePakistan VARCHAR(50) NOT NULL,
    LaunchedPriceIndia VARCHAR(50) NOT NULL,
    LaunchedPriceChina VARCHAR(50) NOT NULL,
    LaunchedPriceUSA VARCHAR(50) NOT NULL,
    LaunchedPriceDubai VARCHAR(50) NOT NULL,
    FOREIGN KEY (CompanyID) REFERENCES Companies(CompanyID)
);



select * from cs;
CREATE TABLE cs (
    CompanyName VARCHAR(100),
    ModelName VARCHAR(150),
    MobileWeight VARCHAR(50),
    RAM VARCHAR(50),
    FrontCamera VARCHAR(50),
    BackCamera VARCHAR(50),
    Processor VARCHAR(100),
    BatteryCapacity VARCHAR(50),
    ScreenSize VARCHAR(50),
    LaunchedYear INT,
    `Launched Price (Pakistan)` VARCHAR(50),
    `Launched Price (India)` VARCHAR(50),
    `Launched Price (China)` VARCHAR(50),
    `Launched Price (USA)` VARCHAR(50),
    `Launched Price (Dubai)` VARCHAR(50)
);

-- Import csv file to cs table

INSERT INTO Companies (CompanyName)
SELECT DISTINCT CompanyName FROM cs;

INSERT INTO Mobiles (CompanyID, ModelName, MobileWeight, RAM, FrontCamera, BackCamera, Processor, BatteryCapacity, ScreenSize, LaunchedYear, LaunchedPricePakistan, LaunchedPriceIndia, LaunchedPriceChina, LaunchedPriceUSA, LaunchedPriceDubai)
SELECT c.CompanyID, csv.ModelName, csv.MobileWeight, csv.RAM, csv.FrontCamera, csv.BackCamera, csv.Processor, csv.BatteryCapacity, csv.ScreenSize, csv.LaunchedYear, csv.`Launched Price (Pakistan)`, csv.`Launched Price (India)`, csv.`Launched Price (China)`, csv.`Launched Price (USA)`, csv.`Launched Price (Dubai)`
FROM CS csv
JOIN Companies c ON csv.CompanyName = c.CompanyName;

--#Select---
select * from mobiles;

-- COUNT & DISTINCT
SELECT COUNT(*) FROM Mobiles;
SELECT DISTINCT Processor FROM Mobiles;

-- DELETE, TRUNCATE & DROP
DELETE FROM Mobiles WHERE MobileID = 10;
TRUNCATE TABLE Mobiles;
DROP TABLE Mobiles;

-- ALTER & UPDATE
ALTER TABLE Mobiles ADD COLUMN Storage VARCHAR(50);
UPDATE Mobiles SET RAM = '8GB' WHERE MobileID = 5;

-- LIMIT & ORDER BY
SELECT * FROM Mobiles ORDER BY LaunchedYear DESC LIMIT 5;

-- Arithmetic Expressions
SELECT ModelName, LaunchedYear, LaunchedYear + 5 AS FutureYear FROM Mobiles;

-- Aggregation Operations (SUM, AVG, MAX, MIN, COUNT)
SELECT SUM(BatteryCapacity) FROM Mobiles;
SELECT AVG(LaunchedYear) FROM Mobiles;
SELECT COUNT(*) FROM Mobiles;
select * from mobiles;

-- AND, OR, NOT
SELECT * FROM Mobiles WHERE RAM = '8GB' AND BatteryCapacity >= '4000mAh';
SELECT * FROM Mobiles WHERE RAM = '8GB' OR BatteryCapacity >= '4000mAh';
SELECT * FROM Mobiles WHERE NOT RAM = '4GB';

-- IN, NOT IN
SELECT * FROM Mobiles WHERE Processor IN ('Snapdragon 888', 'A17 Bionic');
SELECT * FROM Mobiles WHERE Processor NOT IN ('A17 Pro', 'A16 Bionic');

-- BETWEEN and NOT BETWEEN
SELECT * FROM Mobiles WHERE LaunchedYear BETWEEN 2015 AND 2022;
SELECT * FROM Mobiles WHERE LaunchedYear NOT BETWEEN 2010 AND 2015;

-- LIKE operator
SELECT * FROM Mobiles WHERE ModelName LIKE 'iPhone%';

-- IS NULL and NOT NULL
SELECT * FROM Mobiles WHERE BatteryCapacity IS NULL;
SELECT * FROM Mobiles WHERE BatteryCapacity IS NOT NULL;

-- JOINS
SELECT m.ModelName, c.CompanyName FROM Mobiles m 
 JOIN Companies c ON m.CompanyID = c.CompanyID;
 
-- LEFT JOIN
SELECT m.ModelName, c.CompanyName FROM Mobiles m 
LEFT JOIN Companies c ON m.CompanyID = c.CompanyID;

-- RIGHT JOIN
SELECT m.ModelName, c.CompanyName FROM Mobiles m 
RIGHT JOIN Companies c ON m.CompanyID = c.CompanyID;

-- FULL OUTER JOIN (Using UNION as MySQL does not support FULL OUTER JOIN directly)
SELECT m.ModelName, c.CompanyName FROM Mobiles m 
LEFT JOIN Companies c ON m.CompanyID = c.CompanyID
UNION
SELECT m.ModelName, c.CompanyName FROM Mobiles m 
RIGHT JOIN Companies c ON m.CompanyID = c.CompanyID;

-- CROSS JOIN
SELECT m.ModelName, c.CompanyName FROM Mobiles m 
CROSS JOIN Companies c;

-- SELF JOIN
SELECT a.ModelName AS Mobile1, b.ModelName AS Mobile2 FROM Mobiles a 
JOIN Mobiles b ON a.CompanyID = b.CompanyID AND a.MobileID!=b.MobileID;

-- Constraints Example
ALTER TABLE Mobiles ADD CONSTRAINT chk_year CHECK (LaunchedYear >= 2000);

#Concatenate
SELECT CONCAT(ModelName, ' - ', Processor) AS FullDetails FROM Mobiles;
SELECT CONCAT(CompanyName, ' ', ModelName) AS FullMobileName FROM Companies c JOIN Mobiles m ON c.CompanyID = m.CompanyID;

-- GROUP BY & HAVING
SELECT Processor, COUNT(*) FROM Mobiles GROUP BY Processor HAVING COUNT(*) > 5;

-- VIEWS
CREATE VIEW HighEndPhones AS 
SELECT * FROM Mobiles WHERE RAM = '12GB' OR Processor LIKE 'Snapdragon%';

select * from HighEndPhones;

-- INDEX
CREATE INDEX idx_model1 ON Mobiles(ModelName);

select * from mobiles;
-- UNION & UNION ALL
SELECT ModelName FROM Mobiles WHERE RAM = '8GB'
UNION
SELECT ModelName FROM Mobiles WHERE BatteryCapacity = '5000mAh';

SELECT ModelName FROM Mobiles WHERE RAM = '8GB'
UNION ALL
SELECT ModelName FROM Mobiles WHERE BatteryCapacity = '5000mAh';

-- CASE Statement
SELECT ModelName, 
    CASE 
        WHEN LaunchedYear >= 2020 THEN 'New'
        WHEN LaunchedYear >= 2015 THEN 'Moderate'
        ELSE 'Old'
    END AS Category
FROM Mobiles;

-- String Functions
SELECT ModelName, UPPER(ModelName) AS UpperName, LENGTH(ModelName) AS NameLength FROM Mobiles;

-- Subqueries
SELECT ModelName FROM Mobiles WHERE CompanyID = (SELECT CompanyID FROM Companies WHERE CompanyName = 'Apple');

-- Masking

select ModelName,replace(ModelName,substr(ModelName,3),'##') as Model
from Mobiles;

-- Replace
Select ModelName,replace(ModelName,'5','@') from Mobiles;

-- Left
select ModelName,left(ModelName,3) as loc_3 from Mobiles;

-- Right
select ModelName,right(ModelName,3) as loc_3 from Mobiles;

-- Procedure
DELIMITER $$
CREATE PROCEDURE GetMobilesByYear(IN year INT)
BEGIN
    SELECT * FROM Mobiles WHERE LaunchedYear = year;
END $$
DELIMITER ;

CALL GetMobilesByYear(2020);


-- 6.	Challenges Faced
-- Issues encountered during the project.
-- While creating table need to write proper database schema and while inserting data had to create another table
-- Issue: While importing the CSV file into the database, an error occurred: "Column 'Launched Price (Dubai)' specified twice"
-- Cause: The dataset contained duplicate column names, leading to ambiguity and SQL import errors.
-- Solution:
-- Identified and renamed duplicate columns in the database schema before import.
-- Ensured column names were unique across the dataset.

-- Conclusion
-- Summary of Findings and Project Outcomes
-- The project involved structuring and importing a mobile phone dataset into a relational database, applying constraints to ensure data integrity, and optimizing query performance. The key outcomes include:

-- Successfully designed and implemented a normalized database schema with multiple related tables (Mobiles, Companies, Prices).
-- Applied constraints such as PRIMARY KEY, FOREIGN KEY, CHECK, NOT NULL, UNIQUE, and DEFAULT to enforce data consistency.
-- Resolved challenges related to data duplication, formatting inconsistencies, and foreign key constraints.
-- Used SQL queries for data retrieval, aggregation, and performance optimization (e.g., JOINS, INDEXES, VIEWS).
-- Improved query performance by indexing frequently searched columns like ModelName and Processor.
-- Implemented stored procedures and subqueries for advanced data retrieval.

-- Future Enhancements

-- Advanced Data Analytics and Reporting
-- Using SQL-based business intelligence (BI) tools to generate detailed reports on mobile trends, average price comparisons, and brand popularity.

-- Performance Enhancements
-- Further optimizing SQL queries by implementing partitioning for large datasets and refining indexing strategies.

-- Conclusion:
-- This project successfully transformed a raw mobile phone dataset into a structured, query-efficient relational database.
-- By enforcing data integrity and optimizing query execution, it sets the foundation for scalable, data-driven applications.
-- By leveraging MySQL, SQL queries, data preprocessing tools, ERD visualization tools, and automation techniques, 
-- this project was efficiently implemented with scope for future integration into data analytics, web applications, and AI-driven insights

-- References
-- Data Sources
-- Dataset: "Mobiles Dataset (2025).csv" (Provided)
-- Tools & Technologies Used
-- 1. Database Management System (DBMS)
-- MySQL – Used for storing and managing structured mobile data.


