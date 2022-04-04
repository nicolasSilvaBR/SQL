DECLARE @Today				DATE;
DECLARE @NumberOfWeek		TINYINT;
DECLARE @DayOfTheWeek		TINYINT;
DECLARE @NameOfDay			VARCHAR(10);
DECLARE @StartDateOfWeek	DATE;
DECLARE @EndDateOFWeek		DATE;

SET DATEFIRST 1				
SET @Today =				DATEADD(DAY,7,GETDATE());
SET @NumberOfWeek =			DATEPART(WEEK,@today);
SET @DayOfTheWeek =			DATEPART(DW,@today);
SET @NameOfDay =			DATENAME(DW,@today);

SET @StartDateOfWeek =		CASE 
								WHEN DATEPART(DW,@today) = 1 THEN @today
								WHEN DATEPART(DW,@today) = 2 THEN DATEADD(DAY,-1,@today)
								WHEN DATEPART(DW,@today) = 3 THEN DATEADD(DAY,-2,@today)
								WHEN DATEPART(DW,@today) = 4 THEN DATEADD(DAY,-3,@today)
								WHEN DATEPART(DW,@today) = 5 THEN DATEADD(DAY,-4,@today)
								WHEN DATEPART(DW,@today) = 6 THEN DATEADD(DAY,-5,@today)
								WHEN DATEPART(DW,@today) = 7 THEN DATEADD(DAY,-6,@today)
							END

SET @EndDateOFWeek =		CASE
								WHEN DATEPART(DW,@today) = 1 THEN DATEADD(DAY,6,@today)
								WHEN DATEPART(DW,@today) = 2 THEN DATEADD(DAY,5,@today)
								WHEN DATEPART(DW,@today) = 3 THEN DATEADD(DAY,4,@today)
								WHEN DATEPART(DW,@today) = 4 THEN DATEADD(DAY,3,@today)
								WHEN DATEPART(DW,@today) = 5 THEN DATEADD(DAY,2,@today)
								WHEN DATEPART(DW,@today) = 6 THEN DATEADD(DAY,2,@today)
								WHEN DATEPART(DW,@today) = 7 THEN @today
							END


SELECT @today,@NumberOfWeek,@dayOfTheWeek,@NameOfDay,@StartDateOfWeek,@EndDateOFWeek