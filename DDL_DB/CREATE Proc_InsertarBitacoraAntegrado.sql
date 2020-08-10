USE [TLS_DIGITAL]
GO

/****** Object:  StoredProcedure [dbo].[Proc_InsertarBitacoraAntegrado]    Script Date: 6/08/2020 23:50:21 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[Proc_InsertarBitacoraAntegrado]
	-- Add the parameters for the stored procedure here

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	--SET NOCOUNT ON;

INSERT INTO [dbo].[tb_bitacora_antegrado]
           ([Fecha]
           ,[Hora de Accion (envio)]
           ,[Producto]
           ,[Accion]
           ,[Detalle]
           ,[Nombre de Accion]
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
           ,[Nombre de Accion]
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
           ,[Nombre de Accion]
           ,[Fuente de Datos]
           ,[Volumen de Datos]
           ,[Contenido usado]
           ,[Mensaje Predeterminado]
           ,[Estado]
           ,[Codigo]
           ,[Pieza]
           ,[Link Bitly]
FROM import_bitacora_antegrado_data_pre
WHERE [ID Bitacora_Ant] IS NOT NULL) AS datos_nuevos
WHERE NOT EXISTS (SELECT 1 FROM [dbo].[tb_bitacora_antegrado] AS verificacion WHERE verificacion.[Codigo] = datos_nuevos.Codigo)

END
GO


