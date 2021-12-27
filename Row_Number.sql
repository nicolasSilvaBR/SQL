/*
Database = AdventureWorks2019

The ROW_NUMBER() is a window function that assigns a sequential integer 
to each row within the partition of a result set. The row number starts
with 1 for the first row in each partition.

"Top 5 Price In Category" that returns the string “Yes” 
if a product has one of the top 5 list prices in its product 
category, and “No” if it does not. 

*/

SELECT
	Product = pp.Name,
	pp.ListPrice,
	Subcategory = ps.Name,
	Category = pc.Name,
	PriceRank = ROW_NUMBER() 
		over(ORDER BY pp.ListPrice desc),
	CategoryPriceRank = ROW_NUMBER() 
		over(PARTITION BY pc.Name ORDER BY pp.ListPrice DESC),

	['Top 5 Price In Category'] = 
	CASE
		WHEN ROW_NUMBER() 
			over(PARTITION BY pc.Name ORDER BY pp.ListPrice DESC) <= 5 
			THEN 'Yes'
		ELSE 'No'
	END
FROM Production.Product as pp

INNER JOIN Production.ProductSubcategory as ps
ON pp.ProductSubcategoryID = ps.ProductSubcategoryID

INNER JOIN Production.ProductCategory as pc
ON pc.ProductCategoryID = ps.ProductCategoryID
GO
