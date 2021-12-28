/*

Database = AdventureWorks2019

Scalar Subqueries

A scalar subquery is a subquery that selects only one column or expression and returns one row. 
A scalar subquery can be used anywhere in an SQL query that a column or expression can be used.

*/
SELECT
	BusinessEntityID,
	JobTitle,
	VacationHours,
	MaxVacationHours = (SELECT MAX(VacationHours) FROM AdventureWorks2019.HumanResources.Employee),		
	PercentOfMaxVacationHours = (VacationHours * 1.0) / (SELECT MAX(VacationHours) FROM AdventureWorks2019.HumanResources.Employee)

FROM AdventureWorks2019.HumanResources.Employee

WHERE (VacationHours * 1.0) / (SELECT MAX(VacationHours) FROM AdventureWorks2019.HumanResources.Employee) >= 0.8

