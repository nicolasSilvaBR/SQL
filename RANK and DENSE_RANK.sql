/*
Database = AdventureWorks2019

ROW_Number	
	It assigns the sequential rank number to each unique record.

RANK
	It assigns the rank number to each row in a partition. It skips the number for similar values.

Dense_RANK	
	It assigns the rank number to each row in a partition. It does not skip the number for similar values.
*/

/*
Derived column called "Category Price Rank With Dense Rank" that uses the DENSE_RANK 
function to rank all products by ListPrice – within each category - in descending order. 

Observe the differences among the “Category Price Rank”, 
“Category Price Rank With Rank”, and “Category Price Rank With Dense Rank”
*/

SELECT
	Product = pp.Name,
	pp.ListPrice,
	Subcategory = ps.Name,
	Category = pc.Name,
	PriceRank = ROW_NUMBER() over(ORDER BY pp.ListPrice desc),
	CategoryPriceRank = ROW_NUMBER() over(PARTITION BY pc.Name ORDER BY pp.ListPrice DESC),
	[`Category Price Rank With Rank`] = RANK() over(PARTITION BY pc.Name ORDER BY pp.ListPrice DESC),
	[`Category Price Rank With Dense Rank`] = DENSE_RANK() over(PARTITION BY pc.Name ORDER BY pp.ListPrice DESC )	
	
FROM Production.Product as pp

INNER JOIN Production.ProductSubcategory as ps
ON pp.ProductSubcategoryID = ps.ProductSubcategoryID

INNER JOIN Production.ProductCategory as pc
ON pc.ProductCategoryID = ps.ProductCategoryID
GO