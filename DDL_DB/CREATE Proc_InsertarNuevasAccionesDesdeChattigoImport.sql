USE [TLS_DIGITAL]
GO

/****** Object:  StoredProcedure [dbo].[Proc_InsertarNuevasAccionesDesdeChattigoImport]    Script Date: 7/08/2020 11:41:04 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		Jose Maria Muñoz Huaman
-- Create date: 20/07/2020
-- Description:	Insertar las nuevas acciones desde Chattigo
-- =============================================
ALTER PROCEDURE [dbo].[Proc_InsertarNuevasAccionesDesdeChattigoImport] 
	-- Add the parameters for the stored procedure here
	 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	-- SET NOCOUNT ON;

    -- Insert statements for procedure here


INSERT INTO [dbo].[tb_Chattigo_Acciones]
           ([ID Mensaje]
           ,[ID Chat]
           ,[ID Contacto]
           ,[Campana]
           ,[Fecha Hora]
           ,[Ident]
           ,[Nick]
           ,[Agente]
           ,[Tipo]
           ,[Estado]
           ,[Canal]
           ,[codigo_accion]
           ,[Mensaje])

SELECT [ID Mensaje]
           ,[ID Chat]
           ,[ID Contacto]
           ,[Campana]
           ,[Fecha Hora]
           ,[Ident]
           ,[Nick]
           ,[Agente]
           ,[Tipo]
           ,[Estado]
           ,[Canal]
           ,[codigo_accion]
           ,[Mensaje]
FROM (
	SELECT [ID Mensaje],
		   [ID Chat],
		   SUBSTRING([ID Contacto],3,9) AS [ID Contacto],
		   Campana, 
		   CAST([Fecha Hora] AS date) AS [Fecha Hora], 
		   [Ident], 
		   [Nick], 
		   [Agente], 
		   [Tipo], 
		   [Estado], 
		   [Canal],
		   dbo.GETWORDNUM(SUBSTRING(Mensaje,CHARINDEX(' TLS', Mensaje) + 1,15),1,' ' + CHAR(10) + CHAR(13) + CHAR(8)) as codigo_accion,
		   Mensaje
	FROM import_chattigo_data_pre AS chattigo
	WHERE Mensaje LIKE '% TLS[0-9A-Z][0-9A-Z]%') AS datosnuevos
WHERE NOT EXISTS (SELECT [ID Mensaje] FROM [dbo].[tb_Chattigo_Acciones] AS verificacion WHERE verificacion.[ID Mensaje] = datosnuevos.[ID Mensaje])
ORDER BY [ID Mensaje]

END
GO


