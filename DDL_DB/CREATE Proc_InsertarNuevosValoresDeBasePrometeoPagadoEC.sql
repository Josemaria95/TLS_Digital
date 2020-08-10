-- ================================================
-- Template generated from Template Explorer using:
-- Create Procedure (New Menu).SQL
--
-- Use the Specify Values for Template Parameters 
-- command (Ctrl-Shift-M) to fill in the parameter 
-- values below.
--
-- This block of comments will not be included in
-- the definition of the procedure.
-- ================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Jose Maria Muñoz Huaman
-- Create date: 06/08/2020
-- Description:	Insertar nuevos valores de Base Prometeo Pagado Educación Continua.
-- =============================================
CREATE PROCEDURE  [dbo].[Proc_InsertarNuevosValoresDeBasePrometeoPagadoEC]
	-- Add the parameters for the stored procedure here

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	--SET NOCOUNT ON;

    -- Insert statements for procedure here

INSERT INTO [dbo].[tb_prometeo_pagado_educacioncontinua]
           ([id_cliente]
           ,[apellidos]
           ,[nombres]
           ,[accion]
           ,[fecha_accion]
           ,[area]
           ,[programa]
           ,[curso]
           ,[vendedor]
           ,[campania]
           ,[id_actividad]
           ,[SedeInteres]
           ,[Asesor Contacto]
           ,[Sesión]
           ,[Tipo Cliente]
           ,[Descuento]
           ,[Total]
           ,[Campus ID]
           ,[Venta Anulada]
           ,[VentaOnline]
           ,[available]
           ,[Campus_ID]
           ,[FLAG]
           ,[FLAG1]
           ,[ID2_Campus]
           ,[ID2_Contrato]
           ,[Estado]
           ,[Fecha_Acción]
           ,[Número de semana]
           ,[año]
           ,[mes]
           ,[AÑOMES]
           ,[día]
           ,[Concatenar]
           ,[Duración (meses)]
           ,[Venta_Forzada]
           ,[Estado_Final]
           ,[Programa_2]
           ,[Programa_Final]
           ,[Dia_Sem])

SELECT [id_cliente]
           ,[apellidos]
           ,[nombres]
           ,[accion]
           ,[fecha_accion]
           ,[area]
           ,[programa]
           ,[curso]
           ,[vendedor]
           ,[campania]
           ,[id_actividad]
           ,[SedeInteres]
           ,[Asesor Contacto]
           ,[Sesión]
           ,[Tipo Cliente]
           ,[Descuento]
           ,[Total]
           ,[Campus ID]
           ,[Venta Anulada]
           ,[VentaOnline]
           ,[available]
           ,[Campus_ID]
           ,[FLAG]
           ,[FLAG1]
           ,[ID2_Campus]
           ,[ID2_Contrato]
           ,[Estado]
           ,[Fecha_Acción]
           ,[Número de semana]
           ,[año]
           ,[mes]
           ,[AÑOMES]
           ,[día]
           ,[Concatenar]
           ,[Duración (meses)]
           ,[Venta_Forzada]
           ,[Estado_Final]
           ,[Programa_2]
           ,[Programa_Final]
           ,[Dia_Sem]
FROM (
	SELECT [id_cliente]
           ,[apellidos]
           ,[nombres]
           ,[accion]
           ,[fecha_accion]
           ,[area]
           ,[programa]
           ,[curso]
           ,[vendedor]
           ,[campania]
           ,[id_actividad]
           ,[SedeInteres]
           ,[Asesor Contacto]
           ,[Sesión]
           ,[Tipo Cliente]
           ,[Descuento]
           ,[Total]
           ,[Campus ID]
           ,[Venta Anulada]
           ,[VentaOnline]
           ,[available]
           ,[Campus_ID]
           ,[FLAG]
           ,[FLAG1]
           ,[ID2_Campus]
           ,[ID2_Contrato]
           ,[Estado]
           ,[Fecha_Acción]
           ,[Número de semana]
           ,[año]
           ,[mes]
           ,[AÑOMES]
           ,[día]
           ,[Concatenar]
           ,[Duración (meses)]
           ,[Venta_Forzada]
           ,[Estado_Final]
           ,[Programa_2]
           ,[Programa_Final]
           ,[Dia_Sem]
	FROM import_prometeo_pagado_educacioncontinua_data_pre
	WHERE Estado LIKE '%Pagante%') AS datosnuevos
WHERE NOT EXISTS (SELECT 1 FROM [dbo].[tb_prometeo_pagado_educacioncontinua] AS verificacion WHERE verificacion.[id_cliente] = datosnuevos.[id_cliente])
END
GO
