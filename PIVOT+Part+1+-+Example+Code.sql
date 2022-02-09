SELECT
[Accessories],
[Bikes],
[Clothing],
[Components]

FROM
(
SELECT
	   ProductCategoryName = D.Name,
	   A.LineTotal

FROM AdventureWorks2019.Sales.SalesOrderDetail A
	JOIN AdventureWorks2019.Production.Product B
		ON A.ProductID = B.ProductID
	JOIN AdventureWorks2019.Production.ProductSubcategory C
		ON B.ProductSubcategoryID = C.ProductSubcategoryID
	JOIN AdventureWorks2019.Production.ProductCategory D
		ON C.ProductCategoryID = D.ProductCategoryID
) E

PIVOT(
SUM(LineTotal)
FOR ProductCategoryName IN([Accessories],[Bikes],[Clothing],[Components])
) F

ORDER BY 1