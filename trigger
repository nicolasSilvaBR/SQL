CREATE TRIGGER nome_trigger
ON qual_tabela
FOR INSERT / update / delete
AS
	  EXEC atualizar_Loc; -- chamando uma procedure     
    PRINT 'TRIGGER EXECUTADA COM SUCESSO' -- mensagem na execucao
GO
