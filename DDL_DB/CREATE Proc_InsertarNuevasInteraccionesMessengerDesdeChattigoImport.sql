USE [TLS_DIGITAL]
GO

/****** Object:  StoredProcedure [dbo].[Proc_InsertarNuevasAccionesDesdeChattigoImport]    Script Date: 7/08/2020 23:36:32 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		Jose Maria Muñoz Huaman
-- Create date: 20/07/2020
-- Description:	Insertar las nuevas acciones desde Chattigo
-- =============================================
CREATE PROCEDURE [dbo].[Proc_InsertarNuevasInteraccionesMessengerDesdeChattigoImport] 
	-- Add the parameters for the stored procedure here
	 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	-- SET NOCOUNT ON;

    -- Insert statements for procedure here

INSERT INTO [dbo].[tb_Chattigo_Messenger]
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
           ,[Mensaje]
FROM (
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
           ,[Mensaje]
	FROM import_chattigo_data_pre AS chattigo
	WHERE chattigo.Canal LIKE 'MESSENGER' AND NOT chattigo.Mensaje LIKE '% TLS[0-9A-Z][0-9A-Z]%') AS datosnuevos
WHERE NOT EXISTS (SELECT [ID Mensaje] FROM [dbo].[tb_Chattigo_Messenger] AS verificacion WHERE verificacion.[ID Mensaje] = datosnuevos.[ID Mensaje])
ORDER BY [ID Mensaje]

END
GO


