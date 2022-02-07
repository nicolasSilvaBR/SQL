/*
STUFF

The STUFF function inserts a string into another string. 
It deletes a specified length of characters in the first 
string at the start position and then inserts the second 
string into the first string at the start position

for xml path('')

The Path mode with FOR XML in SQL Server returns a result 
set as the XML element. Unlike other XML modes, this SQL 
FOR XML PATH mode provides control over the generated XML file. 
It is because FOR XML path mode treats column names and alias 
names as the XPath expression.
*/

/*

The "Name" field from Production.ProductSubcategory, which should 
be aliased as "SubcategoryName"

A derived field called "Products" which displays, for each Subcategory 
in Production.ProductSubcategory, a semicolon-separated list of all 
products from Production.Product contained within the given subcategory

*/

SELECT *
FROM Production.ProductSubcategory
--
SELECT *
from Production.Product

-- FOR XML PATH
SELECT
	',' + name
FROM Production.Product
FOR XML PATH('')
-- SUBQUERY FOR XML PATH
SELECT
	SubcategoryName = name,
	Products = (
		SELECT
		',' + name
		FROM Production.Product as b
		WHERE B.ProductSubcategoryID = A.ProductSubcategoryID
		FOR XML PATH('')		
	)
FROM Production.ProductSubcategory as a
-- WITH STUFF
SELECT
	SubcategoryName = name,
	Products = 
	STUFF(
			(SELECT
			',' + name
			FROM Production.Product as b
			WHERE B.ProductSubcategoryID = A.ProductSubcategoryID
			FOR XML PATH('')
			),1,1,'')
FROM Production.ProductSubcategory as a
