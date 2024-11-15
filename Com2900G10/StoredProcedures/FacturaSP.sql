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


-- SP para la tabla factura
GO
CREATE OR ALTER PROCEDURE venta.CrearFactura
	@numero_factura VARCHAR(11),
	@id_punto_venta_empleado INT,
	@id_medio_pago SMALLINT,
	@legajo INT,
	@id_cliente INT,
	@tipo_factura CHAR(1),
	@tipo_cliente VARCHAR(50),
	@fechaHora DATETIME,
	@id_sucursal SMALLINT
AS
BEGIN
	IF NOT EXISTS (SELECT 1 FROM sucursal.punto_venta_empleado WHERE id_punto_venta_empleado = @id_punto_venta_empleado and activo = 1)
	BEGIN
		RAISERROR('El punto de venta no existe o esta inactivo.',10,1);

		RETURN
	END

	IF NOT EXISTS (SELECT 1 FROM venta.medio_pago WHERE id_medio_pago = @id_medio_pago)
	BEGIN
		RAISERROR('El medio de pago de la factura no existe.',10,1);

		RETURN
	END

	IF NOT EXISTS (SELECT 1 FROM sucursal.empleado WHERE legajo = @legajo AND activo = 1)
	BEGIN
		RAISERROR('El empleado generador de la factura no existe o esta inactivo.',10,1);

		RETURN
	END

	IF NOT EXISTS (SELECT 1 FROM venta.cliente WHERE id_cliente = @id_cliente)
	BEGIN
		RAISERROR('El cliente a facturar no existe.',10,1);

		RETURN
	END

	IF NOT EXISTS (SELECT 1 FROM sucursal.sucursal WHERE id_sucursal = @id_sucursal AND activo = 1)
	BEGIN
		RAISERROR('La sucursal de la factura no existe o esta inactiva.',10,1);

		RETURN
	END

	IF NOT EXISTS (SELECT 1 FROM sucursal.punto_venta_empleado WHERE id_punto_venta_empleado = @id_punto_venta_empleado and id_sucursal = @id_sucursal AND legajo_empleado = @legajo)
	BEGIN
		RAISERROR('El punto de venta no se encuentra asignado a la sucursal y el empleado ingresados.',10,1);

		RETURN
	END


	INSERT INTO venta.factura
    VALUES (@numero_factura, @id_punto_venta_empleado, @id_medio_pago, @legajo, @id_cliente, @tipo_factura, @tipo_cliente, @fechaHora, @id_sucursal,0.0,0); -- se inserta no pagada

	PRINT 'Factura agregada exitosamente.';
END;


GO
CREATE OR ALTER PROCEDURE venta.ModificarFactura
	@id_factura INT, -- Solo para la busqueda
	@id_punto_venta_empleado INT,
	@numero_factura VARCHAR(11),
	@id_medio_pago SMALLINT,
	@legajo INT,
	@id_cliente INT,
	@tipo_factura CHAR(1),
	@tipo_cliente VARCHAR(50),
	@fechaHora DATETIME,
	@id_sucursal SMALLINT,
	@total DECIMAL(12,2)
AS
BEGIN
	IF NOT EXISTS (SELECT 1 FROM sucursal.punto_venta_empleado WHERE id_punto_venta_empleado = @id_punto_venta_empleado and activo = 1)
	BEGIN
		RAISERROR('El punto de venta no existe o esta inactivo.',10,1);

		RETURN
	END

	IF NOT EXISTS (SELECT 1 FROM venta.medio_pago WHERE id_medio_pago = @id_medio_pago)
	BEGIN
		RAISERROR('El medio de pago de la factura no existe.',10,1);

		RETURN
	END

	IF NOT EXISTS (SELECT 1 FROM sucursal.empleado WHERE legajo = @legajo AND activo = 1)
	BEGIN
		RAISERROR('El empleado generador de la factura no existe o esta inactivo.',10,1);

		RETURN
	END

	
	IF NOT EXISTS (SELECT 1 FROM venta.cliente WHERE id_cliente = @id_cliente)
	BEGIN
		RAISERROR('El cliente a facturar no existe.',10,1);

		RETURN
	END

	IF NOT EXISTS (SELECT 1 FROM sucursal.sucursal WHERE id_sucursal = @id_sucursal AND activo = 1)
	BEGIN
		RAISERROR('La sucursal de la factura no existe o esta inactiva.',10,1);

		RETURN
	END


	IF NOT EXISTS (SELECT 1 FROM venta.factura WHERE id_factura =  @id_factura)
	BEGIN
	    RAISERROR('La factura no existe.',10,1);

		RETURN
	END

	
	IF NOT EXISTS (SELECT 1 FROM sucursal.punto_venta_empleado WHERE id_punto_venta_empleado = @id_punto_venta_empleado and id_sucursal = @id_sucursal AND legajo_empleado = @legajo)
	BEGIN
		RAISERROR('El punto de venta no se encuentra asignado a la sucursal y el empleado ingresados.',10,1);

		RETURN
	END

	UPDATE venta.factura 
		SET 
		numero_factura = @numero_factura,
		id_punto_venta_empleado = @id_punto_venta_empleado,
		id_medio_pago = @id_medio_pago,
		legajo_empleado = @legajo,
		id_cliente = @id_cliente,
		tipo_factura = @tipo_factura,
		tipo_cliente = @tipo_cliente,
		fechaHora = @fechaHora,
		id_sucursal = @id_sucursal,
		total = @total
	WHERE id_factura = @id_factura;

	PRINT 'Factura modificada exitosamente.';
END;
GO

CREATE OR ALTER PROCEDURE venta.RecalcularTotalFactura
@id_factura INT
AS
BEGIN
DECLARE @totalTemp DECIMAL(12,2)
	IF EXISTS (SELECT * FROM [venta].[factura]
	WHERE id_factura = @id_factura)
	BEGIN

		DECLARE @total DECIMAL(12,2)
		SELECT @total = SUM(subtotal) FROM  venta.detalle_factura WHERE id_factura = @id_factura;

		UPDATE[venta].[factura]
		SET total = @total
		WHERE id_factura = @id_factura

		PRINT('Total de la factura actualizado exitosamente.')
	END
	ELSE
	BEGIN
		RAISERROR('La factura a la que se le est� intentando actualizar el saldo no existe',10,1)
		RETURN
	END
END
GO

CREATE OR ALTER PROCEDURE venta.SetFacturaPagada
@id_factura INT
AS
BEGIN
DECLARE @totalTemp DECIMAL(12,2)
	IF EXISTS (SELECT * FROM [venta].[factura]
	WHERE id_factura = @id_factura AND pagada = 1)
	BEGIN

		UPDATE[venta].[factura]
		SET pagada = 1
		WHERE id_factura = @id_factura

		PRINT('Estado de la factura actualizado exitosamente.')
	END
	ELSE
	BEGIN
		RAISERROR('La factura no existe o ya esta pagada',10,1)
		RETURN
	END
END