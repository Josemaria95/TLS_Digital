USE [TLS_DIGITAL]
GO

/****** Object:  StoredProcedure [dbo].[Proc_InsertarNuevosValoresDeBitacoraAnt_EC]    Script Date: 6/08/2020 23:40:44 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Jose Maria
-- Create date: 06/08/2020
-- Description:	Insertar nuevos valores de las bitácoras de antegrado y educación continua.
-- =============================================
ALTER PROCEDURE  [dbo].[Proc_InsertarNuevosValoresDeBitacoraAnt_EC]
	-- Add the parameters for the stored procedure here

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	--SET NOCOUNT ON;

    -- Insert statements for procedure here

INSERT INTO [dbo].[tb_bitacora]
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

SELECT *
FROM (
	SELECT ant.[Fecha]
           ,ant.[Hora de Accion (envio)]
           ,ant.[Producto]
           ,ant.[Accion]
           ,ant.[Detalle]
           ,ant.[Nombre de Accion]
           ,ant.[Fuente de Datos]
           ,ant.[Volumen de datos]
           ,ant.[Contenido usado]
           ,ant.[Mensaje Predeterminado]
           ,ant.[Estado]
           ,ant.[Codigo]
           ,ant.[Pieza]
           ,ant.[Link Bitly] 
	FROM [dbo].[tb_bitacora_antegrado] AS ant
	UNION
	SELECT ec.[Fecha]
           ,ec.[Hora de Accion (envio)]
           ,ec.[Producto]
           ,ec.[Accion]
           ,ec.[Detalle]
           ,ec.[Nombre de accion]
           ,ec.[Fuente de Datos]
           ,ec.[Volumen de datos]
           ,ec.[Contenido usado]
           ,ec.[Mensaje Predeterminado]
           ,ec.[Estado]
           ,ec.[Codigo]
           ,ec.[Pieza]
           ,ec.[Link Bitly] 
	FROM [dbo].[tb_bitacora_educacioncontinua] AS ec) AS datosnuevos


END
GO


