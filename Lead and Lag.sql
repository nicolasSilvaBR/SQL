/*
Database = AdventureWorks2019

What is Lead SQL?
In SQL Server (Transact-SQL), the LEAD function is an analytic function 
that lets you query more than one row in a table at a time without having 
to join the table to itself. It returns values from the next row in the table.

What is lead and lag SQL?
For starters, the LEAD and LAG functions were first introduced in SQL Server 2012. 
They are window functions. The LEAD function is used to access data from SUBSEQUENT 
rows along with data from the current row. The LAG function is used to access data 
from PREVIOUS rows along with data from the current row.

*/

SELECT
	SalesOrderID,
	OrderDate,
	CustomerID,
	TotalDue,
	NextTotalDue = LEAD(TotalDue, 1) OVER(ORDER BY SalesOrderID),
	PrevTotalDue = LAG(TotalDue, 1) OVER(ORDER BY SalesOrderID)

FROM AdventureWorks2019.Sales.SalesOrderHeader

ORDER BY SalesOrderID


/*
"Next2OrderByEmployeeVendor" that returns, within the group of all orders 
that have the same EmployeeID, the vendor name offset TWO orders into the 
“future” relative to the order in the current row.
*/

SELECT
	pp.PurchaseOrderID,
	pp.OrderDate,
	pp.TotalDue,
	pv.Name,
	pp.VendorID,
	PrevOrderFromVendorAmt = LAG(pp.TotalDue,1) OVER(partition by pp.VendorID ORDER BY pp.OrderDate),
	NextOrderByEmployeeVendor = LEAD(pv.Name,1)	OVER(partition by pp.EmployeeID ORDER BY pp.OrderDate ),
	Next2OrderByEmployeeVendor = LEAD(pv.name,2) OVER(partition by pp.EmployeeID ORDER BY pp.OrderDate )

FROM Purchasing.PurchaseOrderHeader AS pp
INNER JOIN Purchasing.Vendor as pv
ON pp.VendorID = pv.BusinessEntityID
WHERE year(pp.OrderDate) >= 2013
AND pp.TotalDue >500
ORDER BY 
  pp.VendorID,
  pp.OrderDate
go
