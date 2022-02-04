/*
	QUANTIDADE
	TOTAL
	MEDIA
	MAXIMO
	MINIMO
	AMPLITUDE
	VARIANCIA
	DESVIO PADRAO
	MEDIANA
	COEF VAR.
*/

use [DATA_SCIENCE]
go

SELECT
	maquina
	,Quantidade = count(qtd)
	,Total = sum(qtd)
	,Media = avg(qtd)
	,Maximo = max(qtd)
	,Minimo = min(qtd)
	,Amplitude = max(qtd) - min(qtd)
	,Variancia = VARP(qtd)
	,[Desvio Padrao] = round(STDEVP(qtd),2)
	,[Coeficiente de Variacao] = round((STDEVP(qtd)/AVG(qtd)*100),2)
	,MEDIAN = (SELECT DISTINCT PERCENTILE_DISC(.5) WITHIN GROUP (ORDER BY QTD) OVER (PARTITION BY 1) FROM [dbo].[LogMaquinasCSV])
	
FROM [dbo].[LogMaquinasCSV]
Group by
	maquina
	
/*MEDIAN HOLE POPULATION*/
SELECT DISTINCT PERCENTILE_DISC(.5) WITHIN GROUP (ORDER BY QTD)
OVER (PARTITION BY 1) AS MEDIAN
FROM [dbo].[LogMaquinasCSV]

/*MEDIAN FOR EACH MACHINE*/
SELECT DISTINCT 
	MAQUINA,
	PERCENTILE_DISC(.5) WITHIN GROUP (ORDER BY QTD) OVER (PARTITION BY MAQUINA) AS MEDIAN
FROM [dbo].[LogMaquinasCSV]