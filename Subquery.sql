/*
Database = [AdventureWorks2019]

What is a subquery in SQL?
A subquery is a query that is nested inside a SELECT , INSERT , UPDATE , 
or DELETE statement, or inside another subquery.

The three most expensive orders, per vendor ID, from the Purchasing.
PurchaseOrderHeader table. 

There should ONLY be three records per Vendor ID, even if some of the 
total amounts due are identical. 
"Most expensive" is defined by the amount in the "TotalDue" field.
*/

-- Three most expensive orders per vendor ID
SELECT *
FROM
(
SELECT
	PurchaseOrderID,
	VendorID,
	OrderDate,
	TaxAmt,
	Freight,
	TotalDue,	
	RankOrder = ROW_NUMBER() OVER(PARTITION BY VendorID ORDER BY TotalDue DESC)
FROM Purchasing.PurchaseOrderHeader 
)as subQueryA

WHERE RankOrder <=3
GO