/*
DATABASE = AdventureWorks2019

A correlated subquery 

Correlated subqueries are used for row-by-row processing. ... A correlated subquery is one way of reading 
every row in a table and comparing values in each row against related data. It is used whenever a subquery 
must return a different result or set of results for each candidate row considered by the main query.

For each purchase order ID in the query output, the number of line items from the Purchasing.PurchaseOrderDetail 
table which did not have any rejections (i.e., RejectedQty = 0).
*/

SELECT
	PurchaseOrderID
	,VendorID
	,OrderDate
	,TotalDue	
	,NonRejectedItems =
	(	SELECT
			COUNT(*)
		FROM Purchasing.PurchaseOrderDetail A
		WHERE A.PurchaseOrderID = B.PurchaseOrderID
		AND RejectedQty = 0
	)
FROM purchasing.PurchaseOrderHeader B

/*
For each purchase order ID, the UnitPrice of the most expensive item for 
that order in the Purchasing.PurchaseOrderDetail table.
*/
SELECT
	PurchaseOrderID
	,VendorID
	,OrderDate
	,TotalDue	
	,MostExpensiveItem =
	(SELECT
		MAX(A.UnitPrice)
	FROM Purchasing.PurchaseOrderDetail A
	WHERE A.PurchaseOrderID = B.PurchaseOrderID
	)
	
FROM purchasing.PurchaseOrderHeader B