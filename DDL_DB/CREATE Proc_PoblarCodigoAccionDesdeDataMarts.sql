USE [DM_KPI_TLS]
GO

/****** Object:  StoredProcedure [dbo].[Proc_PoblarCodigoAccionDesdeDataMarts]    Script Date: 29/07/2020 19:28:11 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Jose Maria Muñoz Huaman
-- Create date: 29/07/2020
-- Description:	Poblar la base de datos con los diferentes codigos de acciones de la plataforma Chattigo.
-- =============================================
ALTER PROCEDURE [dbo].[Proc_PoblarCodigoAccionDesdeDataMarts] 
	-- Add the parameters for the stored procedure here
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	--SET NOCOUNT ON;

    -- Insert statements for procedure here

INSERT INTO [DM_KPI_TLS].[dbo].[D_Acciones]
           ([codigo_accion]
		   ,[tipo_accion]
		   ,[producto])

SELECT [Codigo]
	   ,[Accion]
	   ,[Producto]
FROM (
	SELECT Codigo, MAX(Accion) AS Accion, MAX(Producto) AS Producto
	FROM [TLS_DIGITAL].[dbo].tb_bitacora_antegrado
	GROUP BY Codigo) AS datosnuevos

WHERE NOT EXISTS (SELECT 1 FROM [DM_KPI_TLS].[dbo].[D_Acciones] AS verificacion WHERE verificacion.[codigo_accion] = datosnuevos.[Codigo])

-- Actualizamos la informacion de tipo accion y producto que se obtiene de las bitacoras de antegrado y educacion continua
INSERT INTO [DM_KPI_TLS].[dbo].[D_Acciones]
           ([codigo_accion]
		   ,[tipo_accion]
		   ,[producto])

SELECT [Codigo]
	   ,[Accion]
	   ,[Producto]
FROM (
	SELECT Codigo, MAX(Accion) AS Accion, MAX(Producto) AS Producto
	FROM [TLS_DIGITAL].[dbo].tb_bitacora_educacioncontinua
	GROUP BY Codigo) AS datosnuevos

WHERE NOT EXISTS (SELECT 1 FROM [DM_KPI_TLS].[dbo].[D_Acciones] AS verificacion WHERE verificacion.[codigo_accion] = datosnuevos.[Codigo])
END
GO


