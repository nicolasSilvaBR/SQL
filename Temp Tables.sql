/*
Temp Tables

Use temp tables when:
- You need to reference one of your virtual tables in multiple outputs
- You need to join massive datasats in your virtual tables
- You need a "scrip" instead of a query

--------------------------------------------------
Tables
	AdventureWorks2019.Sales.SalesOrderHeader
	AdventureWorks2019.Purchasing.PurchaseOrderHeader

Columns
	OrderDate
	OrderMonth = datfromparts
	TotalDue
	OrderRank

Tenp #Tables
Sales
AvgSalesMinusTop10
Purchases
AvgPurchasesMinusTop10
---------------------------------------------------
*/

-- Temp tables with INTO #

Select
	OrderDate
	,OrderMonth = datefromparts(year(OrderDate),month(OrderDate),1)
	,TotalDue
	,OrderRank = ROW_NUMBER() OVER(Partition by datefromparts(year(OrderDate),month(OrderDate),1) ORDER BY TotalDue Desc )
INTO #Sales
FROM AdventureWorks2019.Sales.SalesOrderHeader


Select
	OrderMonth
	,sumOfSales = sum(TotalDue)	
INTO #AvgSalesMinusTop10
FROM #Sales
WHERE OrderRank > 10
GROUP BY OrderMonth	


SELECT
	OrderDate
	,OrderMonth = DATEFROMPARTS(YEAR(OrderDate),MONTH(OrderDate),1)
	,TotalDue
	,OrderRank = ROW_NUMBER() OVER (PARTITION BY DATEFROMPARTS(YEAR(OrderDate),MONTH(OrderDate),1) ORDER BY TotalDue Desc)
INTO #Purchases
FROM AdventureWorks2019.Purchasing.PurchaseOrderHeader
		

SELECT
	OrderMonth
	,sumOfPurchases = SUM(TotalDue)
INTO #AvgPurchasesMinusTop10
FROM #Purchases
WHERE OrderRank > 10
GROUP BY OrderMonth

-- OUTPUT
SELECT
	A.OrderMonth
	,A.sumOfSales
	,B.sumOfPurchases	
FROM #AvgSalesMinusTop10 AS A
INNER JOIN #AvgPurchasesMinusTop10 AS B
ON A.OrderMonth = B.OrderMonth
GO


-- dropping tables
DROP TABLE #Sales
DROP TABLE #Purchases
DROP TABLE #AvgSalesMinusTop10
DROP TABLE #AvgPurchasesMinusTop10


-- CREATING TEMP TABLE ***************************************************************************************************************

-- TABLE  #Sales
DROP TABLE IF EXISTS #Sales
CREATE TABLE #Sales
(	OrderDate date
	,OrderMonth date
	,TotalDue money
	,OrderRank int
)
-- INSERT INTO
INSERT INTO #Sales
(
	OrderDate
	,OrderMonth
	,TotalDue
	,OrderRanK
)
-- VALUES
Select
	OrderDate
	,OrderMonth = datefromparts(year(OrderDate),month(OrderDate),1)
	,TotalDue
	,OrderRank = ROW_NUMBER() OVER(Partition by datefromparts(year(OrderDate),month(OrderDate),1) ORDER BY TotalDue Desc )
FROM AdventureWorks2019.Sales.SalesOrderHeader

-- ***************************************************


-- TABLE #AvgSalesMinusTop10
DROP TABLE IF EXISTS #AvgSalesMinusTop10
CREATE TABLE #AvgSalesMinusTop10
(
	OrderMonth DATE
	,sumOfSales MONEY
)
-- INSERT INTO
INSERT INTO #AvgSalesMinusTop10
(
	OrderMonth
	,sumOfSales
)
-- VALUES
Select
	OrderMonth
	,sumOfSales = sum(TotalDue)	
FROM #Sales
WHERE OrderRank > 10
GROUP BY OrderMonth	

-- *****************************

-- TABLE #Purchases
DROP TABLE IF EXISTS #Purchases
CREATE TABLE #Purchases
(
	OrderDate DATE
	,OrderMonth DATE
	,TotalDue MONEY
	,OrderRank INT
)
-- INSERT INTO
INSERT INTO #Purchases
(
	OrderDate 
	,OrderMonth
	,TotalDue
	,OrderRank
)
-- VALUES
SELECT 
	OrderDate
	,OrderMonth = DATEFROMPARTS(YEAR(OrderDate),MONTH(OrderDate),1)
	,TotalDue
	,OrderRank = ROW_NUMBER() OVER (PARTITION BY DATEFROMPARTS(YEAR(OrderDate),MONTH(OrderDate),1) ORDER BY TotalDue Desc)
FROM AdventureWorks2019.Purchasing.PurchaseOrderHeader
		
-- ********************************

-- TABLE #AvgPurchasesMinusTop10
DROP TABLE IF EXISTS #AvgPurchasesMinusTop10
CREATE TABLE #AvgPurchasesMinusTop10
(
	OrderMonth DATE
	,sumOfPurchase MONEY
)
-- INSERT INTO
INSERT INTO #AvgPurchasesMinusTop10
(
	OrderMonth 
	,sumOfPurchase
)
-- VALUES
SELECT
	OrderMonth
	,sumOfPurchases = SUM(TotalDue)
FROM #Purchases
WHERE OrderRank > 10
GROUP BY OrderMonth

-- ********************************

-- OUTPUT
SELECT
	A.OrderMonth
	,A.sumOfSales
	,B.sumOfPurchase	
FROM #AvgSalesMinusTop10 AS A
INNER JOIN #AvgPurchasesMinusTop10 AS B
ON A.OrderMonth = B.OrderMonth
GO

