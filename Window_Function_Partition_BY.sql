-- WINDOW FUNCTION
-- PARTITION BY
/*
******** DataBase = AdventureWorks2019 ********

The PARTITION BY clause divides a query's result set into partitions. 
The window function is operated on each partition separately and 
recalculate for each partition. ... If you omit the PARTITION BY clause, 
the whole result set is treated as a single partition.

*/

/*"AvgPriceByCategory " that returns the average ListPrice for 
the product category in each given row.
*/

SELECT
	Product = pp.Name,
	pp.ListPrice,
	Subcategory = ps.Name,
	Category = pc.Name,
	AvgPriceByCategory = AVG(pp.ListPrice) OVER(Partition by pc.Name)
	
FROM Production.Product as pp

INNER JOIN Production.ProductSubcategory as ps
ON pp.ProductSubcategoryID = ps.ProductSubcategoryID

INNER JOIN Production.ProductCategory as pc
ON pc.ProductCategoryID = ps.ProductCategoryID
GO

/*A product's list price, MINUS the average ListPrice for 
that product’s category.
*/
SELECT
	Product = pp.Name,
	pp.ListPrice,
	Subcategory = ps.Name,
	Category = pc.Name,
	AvgPriceByCategory = AVG(pp.ListPrice) 
		OVER(Partition by pc.Name),
	AvgPriceByCategoryAndSubcategory = AVG(pp.ListPrice) 
		OVER(PARTITION BY pc.Name,ps.Name),
	ProductVsCategoryDelta = pp.ListPrice - AVG(pp.ListPrice) 
		over(PARTITION BY pc.Name)

FROM Production.Product as pp

INNER JOIN Production.ProductSubcategory as ps
ON pp.ProductSubcategoryID = ps.ProductSubcategoryID

INNER JOIN Production.ProductCategory as pc
ON pc.ProductCategoryID = ps.ProductCategoryID
GO
