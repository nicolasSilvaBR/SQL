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

SELECT
	SubcategoryName = a.Name
	,ProductsName = 
		STUFF(
		(
		SELECT 
			',' + b.Name		
		FROM Production.Product AS B
		WHERE a.ProductSubcategoryID = b.ProductSubcategoryID
		FOR XML PATH ('')
		)
		,1,1,'')

FROM Production.ProductSubcategory as a