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
-- Description:	Poblar la base de datos Campaña desde la tabla de Chattigo
-- =============================================
CREATE PROCEDURE  [dbo].[Proc_PoblarTablaDCampaniaDelDataMarts]
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	--SET NOCOUNT ON;

    -- Insert statements for procedure here

INSERT INTO [DM_KPI_TLS].[dbo].[D_Campania]
           ([nombre_campania])

SELECT *
FROM (
	  SELECT Campana
	  FROM [TLS_DIGITAL].[dbo].[tb_Chattigo_Acciones]
	  GROUP BY Campana) AS datosnuevos
WHERE NOT EXISTS (SELECT 1 FROM [dbo].[D_Campania] AS verificacion WHERE verificacion.[nombre_campania] = datosnuevos.[Campana])

END
GO
