-- Variavle and Function
-- Formating as a Percentage 100.00 %

CREATE FUNCTION dbo.ufnIntegerPercent(@number1 int, @number2 int)
returns varchar(8)
as
begin
	declare @result float = @number1 *1.0/@number2
	return format(@result,'P') -- FORMAT AS A PERCENTAGE
end

-- Storing the MAX of Hours
DECLARE @maxVactionHours int 
set @maxVactionHours =
(
	SELECT MAX(VacationHours)
	FROM AdventureWorks2019.HumanResources.Employee
)

-- OUTPUT
SELECT
	BusinessEntityID
	,JobTitle
	,VacationHours
	-- Calling the Function dbo.ufnIntegerPercent and the Variable @maxVactionHours
	,PercentOfMaxVacation = dbo.ufnIntegerPercent(VacationHours,@maxVactionHours)
FROM AdventureWorks2019.HumanResources.Employee
GO