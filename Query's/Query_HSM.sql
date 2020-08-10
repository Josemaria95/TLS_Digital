USE TLS_DIGITAL

-- Interacciones
SELECT DISTINCT [Fecha Hora],[ID Chat],Agente, Mensaje FROM tb_Chattigo_HSM
WHERE DATEPART(MONTH,[Fecha Hora]) = '6' OR DATEPART(MONTH,[Fecha Hora]) = '7'
ORDER BY [Fecha Hora]

-- Transferidos
DROP TABLE #tmp
SELECT DISTINCT hsm.[Fecha Hora],hsm.[ID Chat], ps.[ID Prometeo],hsm.Agente, hsm.Mensaje INTO #tmp FROM tb_Chattigo_HSM AS hsm
RIGHT JOIN tb_prometeo_seguimiento AS ps ON ps.[ID Chat] = hsm.[ID Chat]
WHERE DATEPART(MONTH,[Fecha Hora]) = '6' OR DATEPART(MONTH,[Fecha Hora]) = '7'
ORDER BY [Fecha Hora]

SELECT * FROM #tmp
-- Matriculados
SELECT DISTINCT CAST(hsm.[Fecha Hora] AS date),pp.[ID Prometeo], hsm.[ID Chat], hsm.Mensaje FROM #tmp AS hsm
JOIN tb_prometeo_pagado AS pp ON pp.[ID Prometeo] = hsm.[ID Prometeo]