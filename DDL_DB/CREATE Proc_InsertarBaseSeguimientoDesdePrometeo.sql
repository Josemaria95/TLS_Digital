USE [TLS_DIGITAL]
GO

/****** Object:  StoredProcedure [dbo].[Proc_InsertarBaseSeguimientoDesdePrometeo]    Script Date: 25/07/2020 18:19:58 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




-- =============================================
-- Author:		Jose Maria Muñoz Huaman
-- Create date: 20/07/2020
-- Description:	Insertar las nuevas acciones desde Chattigo
-- =============================================
CREATE PROCEDURE [dbo].[Proc_InsertarBaseSeguimientoDesdePrometeo] 
	-- Add the parameters for the stored procedure here
	 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	-- SET NOCOUNT ON;

    -- Insert statements for procedure here


DELETE tb_prometeo_seguimiento FROM tb_prometeo_seguimiento,(SELECT DATEPART(year, Fecha) as anio, DATEPART(MONTH,Fecha)as mes FROM import_prometeo_seguimiento_data_pre) as filtro
WHERE filtro.anio = DATEPART(year, tb_prometeo_seguimiento.Fecha) AND filtro.mes = DATEPART(MONTH, tb_prometeo_seguimiento.Fecha)

INSERT INTO [dbo].[tb_prometeo_seguimiento]
           ([ID Prometeo]
           ,[ID Chat]
           ,[ID Mensaje]
           ,[Campana]
           ,[Fecha]
           ,[ID Contacto]
           ,[Ident#]
           ,[Nick]
           ,[Agente]
           ,[Tipo]
           ,[Estado]
           ,[Canal]
           ,[Detalle]
           ,[Pool]
           ,[Mensaje]
           ,[Tipificacion]
           ,[Estado Prometeo]
           ,[Scoring]
           ,[Fecha_accion]
           ,[Hora]
           ,[Pagos])

SELECT DISTINCT  [ID Prometeo]
           ,[ID Chat]
           ,[ID Mensaje]
           ,[Campana]
           ,[Fecha]
           ,[ID Contacto]
           ,[Ident#]
           ,[Nick]
           ,[Agente]
           ,[Tipo]
           ,[Estado]
           ,[Canal]
           ,[Detalle]
           ,[Pool]
           ,[Mensaje]
           ,[Tipificacion]
           ,[Estado Prometeo]
           ,[Scoring]
           ,[Fecha_accion]
           ,[Hora]
           ,[Pagos]
		FROM (
	SELECT [ID Prometeo]
           ,[ID Chat]
           ,[ID Mensaje]
           ,[Campana]
           ,[Fecha]
           ,[ID Contacto]
           ,[Ident#]
           ,[Nick]
           ,[Agente]
           ,[Tipo]
           ,[Estado]
           ,[Canal]
           ,[Detalle]
           ,[Pool]
           ,[Mensaje]
           ,[Tipificacion]
           ,[Estado Prometeo]
           ,[Scoring]
           ,[Fecha_accion]
           ,[Hora]
           ,[Pagos]
FROM import_prometeo_seguimiento_data_pre
WHERE [Estado Prometeo] IS NOT NULL AND [ID Prometeo] IS NOT NULL
) AS datos_nuevos
WHERE NOT EXISTS (SELECT 1 FROM [dbo].[tb_prometeo_seguimiento] AS verificacion WHERE verificacion.[ID Prometeo] = datos_nuevos.[ID Prometeo])

END
GO

