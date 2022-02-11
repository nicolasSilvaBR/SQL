
--Create Table
CREATE TABLE Adventureworks2019.dbo.Calendar(
	DateValue DATE,
	DayOfWeekNumber INT,
	DayOfWeekName VARCHAR(32),
	DayOfMonthNumber INT,
	MonthNumber INT,
	YearNumber INT,
	WeekendFlag TINYINT,
	HolidayFlag TINYINT
)
--Insert values manually
INSERT INTO Adventureworks2019.dbo.Calendar (
	DateValue,
	DayOfWeekNumber,
	DayOfWeekName,
	DayOfMonthNumber,
	MonthNumber,
	YearNumber,
	WeekendFlag,
	HolidayFlag
)

SELECT * FROM Adventureworks2019.dbo.Calendar

--Insert dates to table with recursive CTE
-- YYYY/MM/DD
-- MM/DD/YYYY
WITH Dates as(
	SELECT 
		Mydate = CAST('01-01-2000' AS date)
	UNION ALL
	SELECT
		DATEADD(day,1,Mydate)
	FROM Dates
	WHERE Mydate < CAST('12-31-2045' AS date)
)
INSERT INTO Adventureworks2019.dbo.Calendar (
	DateValue
)
SELECT
	Mydate
FROM Dates
OPTION(MAXRECURSION 20000)

UPDATE Adventureworks2019.dbo.Calendar
SET 	
	DayOfWeekNumber = DATEPART(WEEKDAY,DateValue),
	DayOfWeekName = FORMAT(DateValue,'dddd'),
	DayOfMonthNumber = day(DateValue),
	MonthNumber = MONTH(DateValue),
	YearNumber = Year(DateValue)

UPDATE Adventureworks2019.dbo.Calendar
SET
	WeekendFlag = 
	CASE	
		WHEN DayOfWeekNumber IN (7,1) THEN 1
		ELSE 0
	END

SELECT * FROM Adventureworks2019.dbo.Calendar




