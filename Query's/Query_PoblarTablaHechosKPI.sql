USE DM_KPI_TLS
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

SELECT	   x.id_campania,
		   x.id_canal,
		   x.id_tiempo,
		   x.id_accion,
		   SUM(x.interacciones) AS interacciones,
		   SUM(x.transferencias) AS transferidos,
		   COUNT(y.[ID Prometeo]) AS matriculado_pagado,
		   x.codigo_accion
FROM
(
	SELECT	MIN(id_campania) AS id_campania, 
			MIN(c.id_canal) AS id_canal, 
			MIN(t.id_tiempo) AS id_tiempo,
			MIN(a.id_accion) AS id_accion,
			COUNT(base.ID_Chattigo_Accion) AS interacciones,
			COUNT(ps.[ID Chat]) AS transferencias,
			base.codigo_accion,
			ps.[ID Prometeo]
	FROM TLS_DIGITAL.[dbo].tb_Chattigo_Acciones as base
	LEFT JOIN [DM_KPI_TLS].[dbo].D_Canal as c ON base.Canal = c.nombre_canal
	LEFT JOIN [DM_KPI_TLS].[dbo].D_Acciones AS a ON SUBSTRING(base.codigo_accion,1,LEN(a.codigo_accion)) = a.codigo_accion
	LEFT JOIN [DM_KPI_TLS].[dbo].[D_Tiempo] AS t ON base.[Fecha Hora] = t.id_tiempo
	LEFT JOIN [DM_KPI_TLS].[dbo].D_Campania AS camp ON base.Campana = camp.nombre_campania
	LEFT JOIN [TLS_DIGITAL].[dbo].tb_prometeo_seguimiento AS ps ON base.[ID Chat] = ps.[ID Chat]
	GROUP BY base.Canal, base.[Fecha Hora], base.codigo_accion, ps.[ID Prometeo] ) AS x
LEFT JOIN
(
	SELECT [ID Prometeo]
	FROM TLS_DIGITAL.[dbo].[tb_prometeo_pagado]
	GROUP BY [ID Prometeo]) AS y
ON x.[ID Prometeo] = y.[ID Prometeo]
GROUP BY x.id_campania, x.id_canal, x.id_tiempo, x.id_accion,  x.codigo_accion
