USE DM_KPI_TLS

--SELECT SUM(interacciones), SUM(transferencias), SUM(matriculado) FROM H_KPI
SELECT codigo_accion_ref, sum(interacciones), sum(transferencias), sum(matriculado) FROM H_KPI
WHERE codigo_accion_ref IN ('%TLS7220D3%','TLS7320D3')
GROUP BY codigo_accion_ref

DROP TABLE #tmp
SELECT ps.[ID Prometeo] INTO #tmp FROM TLS_DIGITAL.dbo.tb_Chattigo_Acciones as tb
LEFT JOIN TLS_DIGITAL.dbo.tb_prometeo_seguimiento as ps ON ps.[ID Chat] = tb.[ID Chat]
WHERE codigo_accion LIKE '%TLSLEAN01O%'


SELECT * FROM #tmp AS tb
LEFT JOIN TLS_DIGITAL.dbo.tb_prometeo_pagado as pp ON pp.[ID Prometeo] = tb.[ID Prometeo]

