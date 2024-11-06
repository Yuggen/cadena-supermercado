/*

Entrega 4 - Grupo 10 - Pi�an, Monardo, Matter, Natario

"
Se requiere que importe toda la informaci�n antes mencionada a la base de datos:
� Genere los objetos necesarios (store procedures, funciones, etc.) para importar los
archivos antes mencionados. Tenga en cuenta que cada mes se recibir�n archivos de
novedades con la misma estructura, pero datos nuevos para agregar a cada maestro.
� Considere este comportamiento al generar el c�digo. Debe admitir la importaci�n de
novedades peri�dicamente.
� Cada maestro debe importarse con un SP distinto. No se aceptar�n scripts que
realicen tareas por fuera de un SP.
� La estructura/esquema de las tablas a generar ser� decisi�n suya. Puede que deba
realizar procesos de transformaci�n sobre los maestros recibidos para adaptarlos a la
estructura requerida.
� Los archivos CSV/JSON no deben modificarse. En caso de que haya datos mal
cargados, incompletos, err�neos, etc., deber� contemplarlo y realizar las correcciones
en el fuente SQL. (Ser�a una excepci�n si el archivo est� malformado y no es posible
interpretarlo como JSON o CSV). 

"

*/

GO
USE Com2900G10;
GO

-- SP para la importar datos de medios de pago
GO
CREATE OR ALTER PROCEDURE ImportarMediosPago
@pathArchivos varchar(200)
AS
BEGIN

	DECLARE @sql varchar(max)= 'SELECT TRIM(F2), TRIM(F3) FROM
			 OPENROWSET(''Microsoft.ACE.OLEDB.12.0'',
						''Excel 12.0; Database='+ @pathArchivos+''', 
						''SELECT * FROM [medios de pago$]'')'

	CREATE TABLE #importacion_medios_pago(
		nombre_eng VARCHAR(200),
		nombre_esp VARCHAR(200)
	)

	INSERT INTO #importacion_medios_pago(nombre_eng, nombre_esp)
		exec sp_executesp @sql;

	-- Inserto solo los nuevos
	INSERT INTO venta.medio_pago(nombre_eng, nombre_esp)
	SELECT i.*
		FROM #importacion_medios_pago i 
			LEFT JOIN venta.medio_pago mp ON i.nombre_esp = mp.nombre_esp
	WHERE mp.nombre_esp is null

	drop table #importacion_medios_pago

END;

/* SELECT * FROM venta.medio_pago;
DELETE FROM venta.medio_pago
EXEC ImportarMediosPago;
SELECT * FROM venta.medio_pago; */
