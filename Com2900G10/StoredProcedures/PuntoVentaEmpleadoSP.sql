/*******************************************************************************
*                                                                             *
*                           Entrega 3 - Grupo 10                              *
*																			  *
*                           Integrantes:                                      *
*                           43.988.577 Juan Pi�an                             *
*                           43.049.457 Matias Matter                          *
*                           42.394.230 Lucas Natario                          *
*                           40.429.974 Pablo Monardo                          *
*                                                                             *
*                                                                             *
* "Cree la base de datos, entidades y relaciones. Incluya restricciones y     *
* claves. Deber� entregar un archivo .sql con el script completo de creaci�n  *
* (debe funcionar si se lo ejecuta �tal cual� es entregado). Incluya          *
* comentarios para indicar qu� hace cada m�dulo de c�digo.                    *
* Genere store procedures para manejar la inserci�n, modificaci�n, borrado    *
* (si corresponde, tambi�n debe decidir si determinadas entidades solo        *
* admitir�n borrado l�gico) de cada tabla."                                   *
*                                                                             *
*******************************************************************************/


GO
USE Com2900G10;
GO

CREATE OR ALTER PROCEDURE CrearPuntoVentaEmpleado
@nro_punto_venta INT,
@id_sucursal SMALLINT,
@legajo_empleado INT
AS
BEGIN
	IF EXISTS (SELECT * FROM [Com2900G10].[sucursal].[empleado]
	WHERE legajo = @legajo_empleado AND id_sucursal = @id_sucursal) --Si el empleado existe y trabaja en la sucursal que se quiere asociar el punto de venta
	BEGIN
		IF EXISTS (SELECT * FROM [Com2900G10].[sucursal].[punto_venta]
		WHERE numero_punto_venta = @nro_punto_venta and id_sucursal = @id_sucursal)
		BEGIN
			INSERT INTO [Com2900G10].[sucursal].[punto_venta_empleado] VALUES (@nro_punto_venta,@id_sucursal,@legajo_empleado,1)
			PRINT ('Puesto de venta asociado exitosamente con empleado.')
		END
		ELSE
		BEGIN
			RAISERROR('El numero de punto de venta que quiere asociar no existe o no pertenece a la sucursal.',10,1)
			RETURN
		END
	END
	ELSE
	BEGIN
		RAISERROR('El empleado que esta queriendo asociar al punto de venta no existe o no trabaja en la sucursal.',10,1)
		RETURN
	END
END
GO

CREATE OR ALTER PROCEDURE BajaPuntoVentaEmpleado
@id_punto_venta_empleado int
AS
BEGIN
	IF EXISTS (SELECT * FROM [Com2900G10].[sucursal].[punto_venta_empleado]
	WHERE id_punto_venta_empleado = @id_punto_venta_empleado)
	BEGIN
		UPDATE [Com2900G10].[sucursal].[punto_venta_empleado]
		SET activo = 0
		WHERE id_punto_venta_empleado = @id_punto_venta_empleado
	END
	ELSE
	BEGIN
		RAISERROR('La asociacion de punto de venta con empleado que esta queriendo dar de baja no existe.',10,1)
		RETURN
	END
END
GO

CREATE OR ALTER PROCEDURE BajaPuntoVentaEmpleadoPorEmpleado 
@legajo_empleado_baja int
AS
BEGIN
	IF EXISTS (SELECT * FROM [Com2900G10].[sucursal].[punto_venta_empleado]
	WHERE legajo_empleado = @legajo_empleado_baja)
	BEGIN
		UPDATE [Com2900G10].[sucursal].[punto_venta_empleado]
		SET activo = 0
		WHERE legajo_empleado = @legajo_empleado_baja
	END
	ELSE
	BEGIN
		RAISERROR ('El empleado no se encuentra registrado en la tabla punto_venta_empleado',10,1)
		RETURN
	END
END
GO

CREATE OR ALTER PROCEDURE BajaPuntoVentaEmpleadoPorSucursal
@id_sucursal_baja smallint
AS
BEGIN
	IF EXISTS (SELECT * FROM [Com2900G10].[sucursal].[punto_venta_empleado] 
	WHERE id_sucursal = @id_sucursal_baja)
	BEGIN
		UPDATE [Com2900G10].[sucursal].[punto_venta_empleado]
		SET activo = 0
		WHERE legajo_empleado = @id_sucursal_baja

		PRINT('Punto de venta empleado dado de baja exitosamente.')
	END
	ELSE
	BEGIN
		RAISERROR ('El empleado no se encuentra registrado en la tabla punto_venta_empleado',10,1)
		RETURN
	END
END
GO

CREATE OR ALTER PROCEDURE BajaPuntoVentaEmpleadoPorPuntoVentaSucursal
@id_sucursal_baja smallint,
@nro_punto_venta_baja int
AS
BEGIN
	IF EXISTS (SELECT * FROM [Com2900G10].[sucursal].[punto_venta_empleado] 
	WHERE id_sucursal = @id_sucursal_baja AND numero_punto_venta = @nro_punto_venta_baja)
	BEGIN
		UPDATE [Com2900G10].[sucursal].[punto_venta_empleado]
		SET activo = 0
		WHERE legajo_empleado = @id_sucursal_baja
	END
	ELSE
	BEGIN
		RAISERROR ('El empleado no se encuentra registrado en la tabla punto_venta_empleado',10,1)
		RETURN
	END
END