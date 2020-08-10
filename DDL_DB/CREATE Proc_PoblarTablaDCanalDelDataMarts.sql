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
-- Create date: 29/07/2020
-- Description:	Poblar la base de datos D_Canal de las Bitacoras AG y EC
-- =============================================
CREATE PROCEDURE Proc_PoblarTablaDCanalDelDataMarts 
	-- Add the parameters for the stored procedure here
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	--SET NOCOUNT ON;

    -- Insert statements for procedure here
	
INSERT INTO [DM_KPI_TLS].[dbo].[D_Canal]
           ([nombre_canal])

SELECT *
FROM (
		SELECT Canal
		FROM [TLS_DIGITAL].[dbo].[tb_Chattigo_Acciones]
		GROUP BY Canal) AS datosnuevos
WHERE NOT EXISTS (SELECT 1 FROM [dbo].[D_Canal] AS verificacion WHERE verificacion.[nombre_canal] = datosnuevos.[Canal])
END
GO
