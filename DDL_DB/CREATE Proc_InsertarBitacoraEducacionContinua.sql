USE [TLS_DIGITAL]
GO

/****** Object:  StoredProcedure [dbo].[Proc_InsertarBitacoraEducacionContinua]    Script Date: 6/08/2020 23:53:16 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Jose Maria Muñoz Huaman
-- Create date: 27/07/2020
-- Description:	Insertar los nuevos valores de la bitacora de educacion continua 
-- =============================================
ALTER PROCEDURE [dbo].[Proc_InsertarBitacoraEducacionContinua] 
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	--SET NOCOUNT ON;

INSERT INTO [dbo].[tb_bitacora_educacioncontinua]
           ([Fecha]
           ,[Hora de Accion (envio)]
           ,[Producto]
           ,[Accion]
           ,[Detalle]
           ,[Nombre de accion]
           ,[Fuente de Datos]
           ,[Volumen de Datos]
           ,[Contenido usado]
           ,[Mensaje Predeterminado]
           ,[Estado]
           ,[Codigo]
           ,[Pieza]
           ,[Link Bitly])

SELECT DISTINCT  [Fecha]
           ,[Hora de Accion (envio)]
           ,[Producto]
           ,[Accion]
           ,[Detalle]
           ,[Nombre de accion]
           ,[Fuente de Datos]
           ,[Volumen de Datos]
           ,[Contenido usado]
           ,[Mensaje Predeterminado]
           ,[Estado]
           ,[Codigo]
           ,[Pieza]
           ,[Link Bitly]
		FROM (
	SELECT [Fecha]
           ,[Hora de Accion (envio)]
           ,[Producto]
           ,[Accion]
           ,[Detalle]
           ,[Nombre de accion]
           ,[Fuente de Datos]
           ,[Volumen de Datos]
           ,[Contenido usado]
           ,[Mensaje Predeterminado]
           ,[Estado]
           ,[Codigo]
           ,[Pieza]
           ,[Link Bitly]
FROM import_bitacora_educacioncontinua_data_pre
WHERE [ID Bitacora_EC] IS NOT NULL) AS datos_nuevos
WHERE NOT EXISTS (SELECT 1 FROM [dbo].[tb_bitacora_educacioncontinua] AS verificacion WHERE verificacion.[Codigo] = datos_nuevos.[Codigo])

END
GO


