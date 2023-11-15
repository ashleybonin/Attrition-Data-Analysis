--Exploring the data--
SELECT *
FROM HRdata.dbo.['HR-Employee-Attrition$']

--Look at max and min ages to ensure that the youngest and oldest ages are correct
SELECT MAX(Age), MIN(Age)
FROM HRdata.dbo.['HR-Employee-Attrition$']

--Ensure that all of the 1-4 value columns do not contain any values > 4
SELECT *
FROM HRdata.dbo.['HR-Employee-Attrition$']
WHERE JobSatisfaction > 4 
OR EnvironmentSatisfaction > 4 
OR WorkLifeBalance > 4 
OR JobInvolvement > 4 
OR PerformanceRating > 4
OR RelationshipSatisfaction > 4

--Check to make sure there are no inconsistensies in the data 
SELECT distinct(Attrition)
FROM HRdata.dbo.['HR-Employee-Attrition$']

--Clean the data--

--Remove any redundant columns
--Check for the distinct values in EmployeeCount to ensure that it is a redundant column
SELECT distinct(EmployeeCount)
FROM HRdata.dbo.['HR-Employee-Attrition$']

--Since all values in EmployeeCount are '1' it can be deleted as it does not provide any additional insight 
ALTER TABLE HRdata.dbo.['HR-Employee-Attrition$']
DROP COLUMN EmployeeCount

--Check for distinct values in Over18 to ensure that it is a redundant column
SELECT distinct(Over18)
FROM HRdata.dbo.['HR-Employee-Attrition$']

--Since all employees are over 18, this column is unnecessary 
ALTER TABLE HRdata.dbo.['HR-Employee-Attrition$']
DROP COLUMN Over18

-----------
--Rename column to clarify distance metrics 

--Add new column for KilometersFromHome
ALTER TABLE HRdata.dbo.['HR-Employee-Attrition$']
ADD KilometersFromHome INT;

--Set KilometersFromHome equal to DistanceFromHome to copy the data
UPDATE HRdata.dbo.['HR-Employee-Attrition$']
SET KilometersFromHome = DistanceFromHome

--Drop the DistanceFromHome column as it is no longer needed
ALTER TABLE HRdata.dbo.['HR-Employee-Attrition$']
DROP COLUMN DistanceFromHome

------------

--Check for duplicates
SELECT EmployeeNumber, COUNT(distinct(EmployeeNumber))
FROM HRdata.dbo.['HR-Employee-Attrition$']
GROUP BY EmployeeNumber
HAVING COUNT(distinct(EmployeeNumber)) > 1
--In this case there are no duplicates so no need to remove any rows 

------------
--Alter the numbers in the Education column with category names to make data more clear

--change data type of education column in order to switch int to strings
ALTER TABLE HRdata.dbo.['HR-Employee-Attrition$']
ALTER COLUMN Education Nvarchar(255);

--create case state to change all instances of each number to the correct education category
UPDATE HRdata.dbo.['HR-Employee-Attrition$']
SET Education = CASE
	WHEN Education = '1' THEN 'High School'
	WHEN Education = '2' THEN 'Associate''s Degree'
	WHEN Education = '3' THEN 'Bachelor''s Degree'
	WHEN Education = '4' THEN 'Master''s Degree'
	WHEN Education = '5' THEN 'Doctorate'
	END;

----------

--To make wage data more consistent, daily and yearly income will be calculated based off the monthly income variable 
--Already existing daily and yearly data will be dropped from the dataset

--add AnnualIncome column
ALTER TABLE HRdata.dbo.['HR-Employee-Attrition$']
ADD AnnualIncome float;

--Calculate AnnualIncome based on MonthlyIncome 
UPDATE HRdata.dbo.['HR-Employee-Attrition$']
SET AnnualIncome = MonthlyIncome*12

--Add IncomePerPaycheck column
ALTER TABLE HRdata.dbo.['HR-Employee-Attrition$']
ADD IncomePerPaycheck float;

UPDATE HRdata.dbo.['HR-Employee-Attrition$']
SET IncomePerPaycheck = ROUND(AnnualIncome/26, 2)

--Drop non-calculated DailyRate, HourlyRate and MonthlyRate
ALTER TABLE HRdata.dbo.['HR-Employee-Attrition$']
DROP COLUMN DailyRate, HourlyRate, MonthlyRate

-----------------
--Add column to assign generation based on age for each employee

--Determine the oldest and youngest employees at the company to see the max and min generations 
SELECT MAX(Age), MIN(Age)
FROM HRdata.dbo.['HR-Employee-Attrition$']

--add column for generation 
ALTER TABLE HRdata.dbo.['HR-Employee-Attrition$']
ADD Generation Nvarchar(255);

--Fill in generation column data based on the age of each employee
UPDATE HRdata.dbo.['HR-Employee-Attrition$']
SET Generation = CASE
	WHEN Age >= 59 THEN 'Baby Boomer'
	WHEN Age <= 58 AND Age >= 44 THEN 'Generation X'
	WHEN Age <= 43 AND Age >= 29 THEN 'Millennial'
	WHEN Age <= 28 THEN 'Generation Z'
	END;
----------------

--Select all data to upload to Tableau for data viz
SELECT *
FROM HRdata.dbo.['HR-Employee-Attrition$']
