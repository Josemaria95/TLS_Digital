USE [TLS_DIGITAL]
GO

/****** Object:  StoredProcedure [dbo].[Proc_InsertarNuevosHSMDesdeChattigoImport]    Script Date: 5/08/2020 12:10:42 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO





-- =============================================
-- Author:		Jose Maria Muñoz Huaman
-- Create date: 27/07/2020
-- Description:	Insertar los nuevos HSM desde Chattigo
-- =============================================
ALTER PROCEDURE [dbo].[Proc_InsertarNuevosHSMDesdeChattigoImport] 
	-- Add the parameters for the stored procedure here
	 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	-- SET NOCOUNT ON;

    -- Insert statements for procedure here

INSERT INTO [dbo].[tb_Chattigo_HSM]
           ([ID Mensaje]
           ,[ID Chat]
           ,[ID Contacto]
           ,[Campana]
           ,[Fecha Hora]
           ,[Canal]
           ,[Tipo]
           ,[Agente]
           ,[Mensaje])

SELECT [ID Mensaje]
           ,[ID Chat]
           ,[ID Contacto]
           ,[Campana]
           ,[Fecha Hora]
           ,[Canal]
           ,[Tipo]
           ,[Agente]
           ,[Mensaje]
		FROM (
	SELECT *
FROM import_chattigo_data_pre
WHERE Tipo LIKE '%MASSIVE%' AND (Agente LIKE '%Melissa%' OR (Agente LIKE '%Ivonne%' AND DATEPART(MONTH,[Fecha Hora])= '7'))) AS datos_nuevos
WHERE NOT EXISTS (SELECT [ID Mensaje] FROM [dbo].[tb_Chattigo_HSM] AS verificacion WHERE verificacion.[ID Mensaje] = datos_nuevos.[ID Mensaje])
ORDER BY [ID Mensaje]

END
GO


