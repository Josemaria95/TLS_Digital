USE [TLS_DIGITAL]
GO

/****** Object:  StoredProcedure [dbo].[Proc_InsertarNuevosMatriculadosDesdePrometeoAG_EC]    Script Date: 6/08/2020 18:30:55 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Jose Maria Muñoz Huaman
-- Create date: 04/08/2020
-- Description:	Union de las tablas de Prometeo Pagado de Antegrado y Educación Continua
-- =============================================
ALTER PROCEDURE  [dbo].[Proc_InsertarNuevosMatriculadosDesdePrometeoAG_EC]
	-- Add the parameters for the stored procedure here
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	--SET NOCOUNT ON;

    -- Insert statements for procedure here

INSERT INTO [dbo].[tb_prometeo_pagado]
           ([ID Prometeo]
           ,[Fecha])

SELECT * 
FROM (
	SELECT pa.[Id Sisproven], pa.[Fecha de Pago]
	FROM [TLS_DIGITAL].[dbo].[import_prometeo_pagado_antegrado_data_pre] AS pa
	UNION
	SELECT pe.id_cliente, pe.fecha_accion 
	FROM [TLS_DIGITAL].[dbo].[import_prometeo_pagado_educacioncontinua_data_pre] AS pe ) AS datosnuevos
WHERE NOT EXISTS (SELECT 1 FROM [dbo].[tb_prometeo_pagado] AS verificacion WHERE verificacion.[ID Prometeo] = datosnuevos.[Id Sisproven])

END
GO


