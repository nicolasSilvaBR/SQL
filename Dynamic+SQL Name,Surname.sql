--Exercise 1

CREATE PROCEDURE dbo.NameSearch(@NameToSearch VARCHAR(100),@SearchPattern VARCHAR(100))

AS

BEGIN
	DECLARE @NameColumn VARCHAR(100)
	DECLARE @DynamicSQL VARCHAR(MAX)

	IF LOWER(@NameToSearch) = 'First'
		SET @NameColumn = 'FirstName'

	IF LOWER(@NameToSearch) = 'Middle'
		SET @NameColumn = 'MiddleName'

	IF LOWER(@NameToSearch) = 'Last'
		SET @NameColumn = 'LastName'

	SET @DynamicSQL = 
	'SELECT
	*
	FROM AdventureWorks2019.Person.Person
	WHERE '

	SET @DynamicSQL = @DynamicSQL + @NameColumn

	SET @DynamicSQL = @DynamicSQL + ' LIKE ' + '''' + '%' + @SearchPattern + '%' + ''''

	EXEC(@DynamicSQL)
END



--Exercise 2

ALTER PROCEDURE dbo.NameSearch(@NameToSearch VARCHAR(100),@SearchPattern VARCHAR(100), @MatchType INT)

AS

BEGIN
	DECLARE @NameColumn VARCHAR(100)
	DECLARE @DynamicWhere VARCHAR(MAX)
	DECLARE @DynamicSQL VARCHAR(MAX)

	IF LOWER(@NameToSearch) = 'First'
		SET @NameColumn = 'FirstName'

	IF LOWER(@NameToSearch) = 'Middle'
		SET @NameColumn = 'MiddleName'

	IF LOWER(@NameToSearch) = 'Last'
		SET @NameColumn = 'LastName'


	IF @MatchType = 1
		SET @DynamicWhere = ' = ' + '''' + @SearchPattern + ''''

	IF @MatchType = 2
		SET @DynamicWhere = ' LIKE ' + '''' + @SearchPattern + '%' + ''''

	IF @MatchType = 3
		SET @DynamicWhere = ' LIKE ' + '''' + '%' + @SearchPattern + ''''

	IF @MatchType = 4
		SET @DynamicWhere = ' LIKE ' + '''' + '%' + @SearchPattern + '%' + ''''


	SET @DynamicSQL = 
	'SELECT
	*
	FROM AdventureWorks2019.Person.Person
	WHERE '

	SET @DynamicSQL = @DynamicSQL + @NameColumn + @DynamicWhere

	SELECT  @DynamicSQL

	EXEC(@DynamicSQL)
END

