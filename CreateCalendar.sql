
DECLARE @VarFirstDayOfMonth			DATETIME = DATEFROMPARTS(@VarYearDate,@VarMonthDate,'1')
DECLARE @VarLastDayOfMonth			DATETIME = EOMONTH(@VarMinDate) -- Last Day of the Month

CREATE TABLE #IntakeData (
	  [Date]			DATE,
	  [Column1]			SMALLINT,
	  [Column2]			SMALLINT,
	  [Column3]			INT
	)	

	
	WHILE ( @VarFirstDayOfMonth <= @VarLastDayOfMonth )

	BEGIN
	  INSERT INTO #IntakeData (
	  	[Date]
	  ) 
	  VALUES( @VarFirstDayOfMonth )
	  SELECT @VarFirstDayOfMonth = DATEADD(DAY, 1, @VarFirstDayOfMonth )
	END	