/*

Database = AdventureWorks2019

EXISTS AND NOT EXISTS

Use exist IF
You want to apply a criterua to fields from a secondary table,
but don't need to include those fields in your output.

You wanto to apply criteria to fields from a secondary table,
while ensuring that multiple matches in the secondary table won't
duplicate data from the primary table in your output.

You need to check a secondary table to make sure match o some type does
not exist.

Select all records from the Purchasing.PurchaseOrderHeader table such that there is at least 
one item in the order with an order quantity greater than 500. The individual items tied to an 
order can be found in the Purchasing.PurchaseOrderDetail table.

*/

SELECT
	PurchaseOrderID
	,OrderDate
	,SubTotal
	,TaxAmt
FROM Purchasing.PurchaseOrderHeader as A

WHERE EXISTS (
	SELECT 1
	FROM Purchasing.PurchaseOrderDetail as B
	WHERE A.PurchaseOrderID = B.PurchaseOrderID
	AND B.OrderQty >500
)
ORDER BY PurchaseOrderID
GO

/*
Select all records from the Purchasing.PurchaseOrderHeader 
table such that NONE of the items within the order have a 
rejected quantity greater than 0.
*/

SELECT
       A.*

FROM AdventureWorks2019.Purchasing.PurchaseOrderHeader as A

WHERE NOT EXISTS (
	SELECT
	1
	FROM AdventureWorks2019.Purchasing.PurchaseOrderDetail as B
	WHERE A.PurchaseOrderID = B.PurchaseOrderID
		AND B.RejectedQty > 0
)

ORDER BY 1