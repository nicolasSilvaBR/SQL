

/*
Recursive CTEs

A recursive CTE is a CTE that references itself. In doing so, the 
initial CTE is repeatedly executed, returning subsets of data, until 
the complete result is returned. ... The general layout is similar to 
a non-recursive CTE.

Recursive CTE to generate a date series of all FIRST days of the month 
(1/1/2021, 2/1/2021, etc.)

from 1/1/2020 to 12/1/2029.

*/

WITH firstDay as
(
	SELECT CAST('01-01-2020' AS DATE) AS myDate

	UNION ALL

	SELECT
		DATEADD(MONTH,1,myDate)
	FROM firstDay
	WHERE myDate < CAST('12-01-2029' AS DATE)
)

SELECT 
	myDate
FROM firstDay
-- The SQL pattern limmit is 100
OPTION(MAXRECURSION 365)
GO

************************************
myDate
2020-01-01
2020-02-01
2020-03-01
2020-04-01
2020-05-01
*************************************