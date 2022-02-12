
SELECT * FROM [Sales].[SalesOrderHeader]
GO

-- Simple Query HARD CODING
SELECT
	Date = cast(OrderDate as date)
	,TotalDue
FROM [Sales].[SalesOrderHeader]
WHERE year(OrderDate) BETWEEN 2011 AND 2012
AND TotalDue >= 1400
GO

-- STORE PROCEDURE USING DYNAMIC INPUTS
CREATE PROCEDURE dbo.OrdersAboveThreshold (@StartYear int,@EndYear int,@Threshold money)
AS
	BEGIN
		SELECT
			Date = cast(OrderDate as date)
			,TotalDue
			FROM [Sales].[SalesOrderHeader]		
			WHERE year(OrderDate) BETWEEN @StartYear AND @EndYear
			AND TotalDue >= @Threshold 
	END
GO

EXEC OrdersAboveThreshold 2011,2012,1500