USE TLS_DIGITAL
GO

SELECT [ID Mensaje],[ID Chat],[ID Contacto],
	   Campana, [Fecha Hora],
	   dbo.GETWORDNUM(SUBSTRING(Mensaje,CHARINDEX(' TLS', Mensaje) + 1,15),1,' ' + CHAR(10) + CHAR(13) + CHAR(8)) as codigo_accion,
	   Mensaje
FROM import_chattigo_data_pre
WHERE Mensaje LIKE '% TLS[0-9A-Z][0-9A-Z]%'
--AND [ID Chat] = '21021103'
ORDER BY [ID Mensaje]
GO
