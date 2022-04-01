	-- Get the First Day and Last Day of, Current Month, Last Month, Same month las Year 


	DECLARE @var_startofMonth				DATE;
	DECLARE @var_endofMonth					DATE;
	DECLARE @var_startLastMonth				DATE;
	DECLARE @var_endLastMonth				DATE;
	DECLARE @var_startSameMonthLastYear		DATE;
	DECLARE @var_endSameMonthLastYear		DATE;
	
	SET @var_startofMonth =				DATEFROMPARTS(YEAR(GETDATE()),MONTH(GETDATE()), 1);		-- First Day of the Current Month
	SET @var_endofMonth =				EOMONTH(@var_startofMonth);								-- Last Day of the Current Month
	SET @var_startLastMonth =			DATEADD(MONTH,-1,@var_startofMonth);					-- Start Date Last Month
	SET @var_endLastMonth =				DATEADD(DAY,-1,@var_startofMonth);						-- End Date Last Month
	SET @var_startSameMonthLastYear =	DATEADD(YEAR,-1,@var_startofMonth);						-- Star Date Same Month Last Year
	SET @var_endSameMonthLastYear =		EOMONTH(@var_startSameMonthLastYear);					-- Star Date Same Month Last Year

	
	SELECT @var_startofMonth,@var_endofMonth, @var_startLastMonth,@var_endLastMonth,@var_startSameMonthLastYear,@var_endSameMonthLastYear