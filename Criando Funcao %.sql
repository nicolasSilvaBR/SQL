CREATE FUNCTION dbo.ufnPorcentagem (@Number1 int, @Number2 int)
RETURNS varchar(8) -- vai retornar 80 %
AS
BEGIN	
	DECLARE @RESULT FLOAT 
	SET @RESULT = @Number1 * 1.0 / @Number2
	RETURN format(@RESULT,'p') -- Formatar como porcentagem 80 %, so devolve um valor
END
GO

SELECT dbo.ufnPorcentagem(8,10)