--Starter code:

SELECT
	   BusinessEntityID
      ,JobTitle
      ,VacationHours
	  ,MaxVacationHours = (SELECT MAX(VacationHours) FROM AdventureWorks2019.HumanResources.Employee)
	  ,PercentOfMaxVacationHours = (VacationHours * 1.0) / (SELECT MAX(VacationHours) FROM AdventureWorks2019.HumanResources.Employee)

FROM AdventureWorks2019.HumanResources.Employee
WHERE (VacationHours * 1.0) / (SELECT MAX(VacationHours) FROM AdventureWorks2019.HumanResources.Employee) >= 0.8

-- using variables

declare @MaxHours float
set @MaxHours = (SELECT MAX(VacationHours) FROM AdventureWorks2019.HumanResources.Employee)

SELECT
	   BusinessEntityID
      ,JobTitle
      ,VacationHours
	  ,MaxVacationHours = @MaxHours
	  ,PercentOfMaxVacationHours = @MaxHours

FROM AdventureWorks2019.HumanResources.Employee
WHERE (VacationHours * 1.0) / @MaxHours >= 0.8
go
