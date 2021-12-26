/*

Window functions give you the power to include aggregate 
calculations in your queries without changing the rest of 
your query output in any way.
The calculation is simply added to your data set as 
another column with no impact on the rest of the data. 

*/

--YTD Sales Via Aggregate Query:

SELECT

      [Total YTD Sales] = SUM(SalesYTD),
      [Max YTD Sales] = MAX(SalesYTD)

FROM AdventureWorks2019.Sales.SalesPerson


--YTD Sales With OVER:
SELECT
      BusinessEntityID,
      TerritoryID,
      SalesQuota,
      Bonus,
      CommissionPct,
      SalesYTD,
	SalesLastYear,
      [Total YTD Sales] = SUM(SalesYTD) OVER(),
      [Max YTD Sales] = MAX(SalesYTD) OVER(),
      [% of Best Performer] = SalesYTD/MAX(SalesYTD) OVER()

FROM AdventureWorks2019.Sales.SalesPerson






