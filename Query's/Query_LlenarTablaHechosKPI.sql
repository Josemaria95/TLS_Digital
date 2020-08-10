USE [DM_KPI_TLS]
GO

DELETE FROM H_KPI

INSERT INTO [dbo].[H_KPI]
           ([id_campania]
           ,[id_canal]
           ,[id_tiempo]
           ,[id_accion]
           ,[interacciones]
           ,[transferencias]
           ,[matriculado]
           ,[codigo_accion_ref])

SELECT MIN(id_campania) AS id_campania, 
	   MIN(c.id_canal) AS id_canal, 
	   MIN(t.id_tiempo) AS id_tiempo,
	   MIN(a.id_accion) AS id_accion,
	   COUNT(1) AS interacciones,
	   COUNT(ps.[ID Chat]) AS transferencias,
	   COUNT(pp.[Celular]) AS matriculado,
	   base.codigo_accion
FROM TLS_DIGITAL.[dbo].tb_Chattigo_Acciones as base
LEFT JOIN [DM_KPI_TLS].[dbo].D_Canal as c ON base.Canal = c.nombre_canal
LEFT JOIN [DM_KPI_TLS].[dbo].D_Acciones AS a ON base.codigo_accion = a.codigo_accion
LEFT JOIN [DM_KPI_TLS].[dbo].[D_Tiempo] AS t ON base.[Fecha Hora] = t.id_tiempo
LEFT JOIN [DM_KPI_TLS].[dbo].D_Campania AS camp ON base.Campana = camp.nombre_campania
LEFT JOIN [TLS_DIGITAL].[dbo].tb_prometeo_seguimiento AS ps ON base.[ID Contacto] = ps.[Ident#]
LEFT JOIN [TLS_DIGITAL].[dbo].tb_prometeo_pagado AS pp ON base.[ID Contacto] = pp.[Celular]
GROUP BY base.Canal, base.[Fecha Hora], base.codigo_accion
