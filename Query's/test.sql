
SELECT SUM(x.interacciones) AS interacciones,
	   SUM(X.transferidos) AS transferidos,
	   COUNT(y.[ID Prometeo]) AS matriculados
FROM(
	SELECT COUNT(mssg.ID_Chattigo_Messenger) AS interacciones,
		   COUNT(ps.[ID Chat]) AS transferidos,
		   ps.[ID Prometeo] AS id_prometeo
	FROM tb_Chattigo_Messenger AS mssg
	LEFT JOIN tb_prometeo_seguimiento AS ps ON ps.[ID Chat] = mssg.[ID Chat]
	WHERE mssg.Estado = '%TRASNF%'
	--WHERE mssg.Mensaje LIKE '%Chat transf%'
	GROUP BY ps.[ID Prometeo]) AS x
LEFT JOIN (
	SELECT pp.[ID Prometeo] FROM tb_prometeo_pagado AS pp
	GROUP BY pp.[ID Prometeo]) AS y
ON x.id_prometeo = y.[ID Prometeo]
GROUP BY x.id_prometeo

SELECT ps.[ID Prometeo], mssg.[ID Chat], ps.[ID Chat] FROM tb_Chattigo_Messenger AS mssg
JOIN tb_prometeo_seguimiento AS ps ON ps.[ID Chat] = mssg.[ID Chat]
WHERE mssg.Mensaje LIKE '%Chat transf%'
GROUP BY ps.[ID Chat], ps.[ID Prometeo], mssg.[ID Chat]