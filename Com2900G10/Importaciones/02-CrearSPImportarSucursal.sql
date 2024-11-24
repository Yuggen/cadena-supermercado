/*******************************************************************************
*                                                                             *
*                           Entrega 3 - Grupo 10                              *
*                                                                             *
*                           Integrantes:                                      *
*                           43.988.577 Juan Pi�an                             *
*                           43.049.457 Matias Matter                          *
*                           42.394.230 Lucas Natario                          *
*                           40.429.974 Pablo Monardo                          *
*                                                                             *
*                                                                             *
* "Se requiere que importe toda la informaci�n antes mencionada a la base de  *
* datos:                                                                      *
* � Genere los objetos necesarios (store procedures, funciones, etc.) para    *
*   importar los archivos antes mencionados. Tenga en cuenta que cada mes se  *
*   recibir�n archivos de novedades con la misma estructura, pero datos nuevos*
*   para agregar a cada maestro.                                              *
* � Considere este comportamiento al generar el c�digo. Debe admitir la       *
*   importaci�n de novedades peri�dicamente.                                  *
* � Cada maestro debe importarse con un SP distinto. No se aceptar�n scripts  *
*   que realicen tareas por fuera de un SP.                                   *
* � La estructura/esquema de las tablas a generar ser� decisi�n suya. Puede   *
*   que deba realizar procesos de transformaci�n sobre los maestros recibidos *
*   para adaptarlos a la estructura requerida.                                *
* � Los archivos CSV/JSON no deben modificarse. En caso de que haya datos mal *
*   cargados, incompletos, err�neos, etc., deber� contemplarlo y realizar las *
*   correcciones en el fuente SQL. (Ser�a una excepci�n si el archivo est�    *
*   malformado y no es posible interpretarlo como JSON o CSV)."               *
*                                                                             *
*******************************************************************************/


GO
USE Com2900G10;

-- SP para la importar datos de sucursales
GO
CREATE OR ALTER PROCEDURE importacion.ImportarSucursales
@pathArchivos VARCHAR(200),
@hojaArchivo VARCHAR(100)
AS
BEGIN
	DECLARE @sql NVARCHAR(max) = 'SELECT * FROM
			 OPENROWSET(''Microsoft.ACE.OLEDB.12.0'',
						''Excel 12.0; Database=' + @pathArchivos + ''', 
						''SELECT * FROM ['+@hojaArchivo+'$]'');'

	CREATE TABLE #importacion_sucursal(ciudad VARCHAR(100), reemplazar_por VARCHAR(100), direccion VARCHAR(200), horario VARCHAR(100), telefono VARCHAR(30))

	INSERT INTO #importacion_sucursal
		exec sp_executesql @sql;

	-- Si ya existe una direccion pero est� inactiva en la BDD, lo activo
	UPDATE s
		SET activo = 1
	FROM sucursal.sucursal s 
		INNER JOIN #importacion_sucursal t1 ON t1.direccion = s.direccion

	-- Inserto las nuevas sucursales
	INSERT INTO sucursal.sucursal(ciudad, reemplazar_por, direccion, horario, telefono, activo)
	SELECT t1.ciudad, t1.reemplazar_por, t1.direccion, t1.horario, t1.telefono, 1
	FROM #importacion_sucursal t1
		LEFT JOIN sucursal.sucursal s ON t1.direccion = s.direccion
	WHERE s.direccion IS NULL

	DROP TABLE #importacion_sucursal

END;