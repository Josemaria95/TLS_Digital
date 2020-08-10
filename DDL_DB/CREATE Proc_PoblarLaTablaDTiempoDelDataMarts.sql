USE [DM_KPI_TLS]
GO

/****** Object:  StoredProcedure [dbo].[Proc_PoblarLaTablaDTiempoDelDataMarts]    Script Date: 29/07/2020 22:00:08 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:	Jose Maria Muñoz Huaman
-- Create date: 29/07/2020
-- Description:	Inserta nuevos valores de tiempo a la tabla de dimensión tiempo que se encuentra dentro del Data Mart.
-- =============================================
ALTER PROCEDURE [dbo].[Proc_PoblarLaTablaDTiempoDelDataMarts] 
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	-- SET NOCOUNT ON;

    -- Insert statements for procedure here

INSERT INTO [DM_KPI_TLS].[dbo].[D_Tiempo]
           ([id_tiempo]
		   ,[dia]
           ,[mes]
           ,[trimestre]
           ,[anio])        

SELECT [Fecha Hora]
		   ,[dia]
           ,[mes]
           ,[trimestre]
           ,[anio]
		FROM (
	SELECT [Fecha Hora],
		   DATEPART(DAY,[Fecha Hora]) AS dia,
		   DATEPART(MONTH,[Fecha Hora]) AS mes,
		   CASE WHEN DATEPART(MONTH,[Fecha Hora]) IN (1,2,3) THEN 1
		   WHEN DATEPART(MONTH,[Fecha Hora]) IN (4,5,6) THEN 2
		   WHEN DATEPART(MONTH,[Fecha Hora]) IN (7,8,9) THEN 3
		   WHEN DATEPART(MONTH,[Fecha Hora]) IN (10,11,12) THEN 4 
		   END AS trimestre,
		   DATEPART(YEAR,[Fecha Hora]) AS anio
FROM [TLS_DIGITAL].[dbo].[tb_Chattigo_Acciones]
GROUP BY [Fecha Hora]) AS datosnuevos

WHERE NOT EXISTS (SELECT 1 FROM [dbo].[D_Tiempo] AS verificacion WHERE verificacion.[id_tiempo] = datosnuevos.[Fecha Hora])
AND [Fecha Hora] IS NOT NULL 

END
GO


