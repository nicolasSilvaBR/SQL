/*
CTE
A Common Table Expression (CTE) is an expression that can be thought of as a temporary result set which 
is defined within the execution of a single SQL statement. A CTE is similar to a derived table in that 
it is not stored as an object and lasts only for the duration of the query

**********************

The top 10 orders per month are actually outliers that need to be clipped out of our data 
before doing meaningful analysis.

The sum of sales AND purchases (minus these "outliers") listed side by side, by month.

Using a CTE 

Hints:

Database = [AdventureWorks2019]
Table = SalesOrderHeader
Table = PurchaseOrderHeader

CTEs:
- Sales
- Purchases
- AvgPurchasesMinusTop10
- AvgPurchasesMinusTop10

*/

WITH Sales as
(
	SELECT
		 OrderDate
		 ,OrderMonth = DATEFROMPARTS(YEAR(OrderDate),MONTH(OrderDate),1)
		 ,TotalDue
		 ,OrderRank = ROW_NUMBER() OVER(PARTITION BY DATEFROMPARTS(YEAR(OrderDate),MONTH(OrderDate),1) ORDER BY TotalDue desc )
	FROM AdventureWorks2019.Sales.SalesOrderHeader	
),
AvgSalesMinusTop10 AS
(
	SELECT
		OrderMonth
		,TotalSales = SUM(TotalDue)
	FROM Sales
	WHERE OrderRank >10
	GROUP BY OrderMonth
),
Purchases AS
(
	SELECT
		OrderDate
		,OrderMonth = DATEFROMPARTS(YEAR(OrderDate),MONTH(OrderDate),1)
		,TotalDue
		,OrderRank = ROW_NUMBER () OVER (PARTITION BY DATEFROMPARTS(YEAR(OrderDate),MONTH(OrderDate),1) ORDER BY TotalDue desc)
	FROM AdventureWorks2019.Purchasing.PurchaseOrderHeader
),
AvgPurchasesMinusTop10 as
(
	SELECT
		OrderMonth
		,TotalPurchases = SUM(TotalDue)
	FROM Purchases
	WHERE OrderRank >10
	GROUP BY OrderMonth
)

/* Select statment*/
SELECT
	a.OrderMonth
	,a.TotalSales
	,b.TotalPurchases
FROM AvgSalesMinusTop10 AS a
INNER JOIN AvgPurchasesMinusTop10 as b
ON a.OrderMonth = b.OrderMonth
GO
	

