/*

Entrega 3 - Grupo 10 - Pi�an, Monardo, Matter, Natario

"Genere store procedures para manejar la inserci�n, modificado, borrado (si corresponde,
tambi�n debe decidir si determinadas entidades solo admitir�n borrado l�gico) de cada tabla.
Los nombres de los store procedures NO deben comenzar con �SP�.
Genere esquemas para organizar de forma l�gica los componentes del sistema y aplique esto
en la creaci�n de objetos. NO use el esquema �dbo�"

*/

GO
USE Com2900G10;


-- SP para la tabla factura
GO
CREATE PROCEDURE CrearFactura
	@id_medio_pago SMALLINT,
	@id_empleado INT,
	@tipo_factura CHAR(1),
	@tipo_cliente VARCHAR(50),
	@genero VARCHAR(10),
	@fechaHora DATETIME,
	@id_sucursal SMALLINT
AS
BEGIN
	INSERT INTO venta.factura 
    VALUES (@id_medio_pago, @id_empleado, @tipo_factura, @tipo_cliente, @genero, @fechaHora, @id_sucursal);

	PRINT 'Factura agregada exitosamente.';
END;


GO
CREATE PROCEDURE ModificarFactura
	@id_factura INT, -- Solo para la busqueda
	@id_medio_pago SMALLINT,
	@id_empleado INT,
	@tipo_factura CHAR(1),
	@tipo_cliente VARCHAR(50),
	@genero VARCHAR(10),
	@fechaHora DATETIME,
	@id_sucursal SMALLINT
AS
BEGIN
    IF EXISTS (SELECT 1 FROM venta.factura WHERE id_factura =  @id_factura)
        BEGIN
            UPDATE venta.factura 
				SET id_medio_pago = @id_medio_pago,
				id_empleado = @id_empleado,
				tipo_factura = @tipo_factura,
				tipo_cliente = @tipo_cliente,
				genero = @genero,
				fechaHora = @fechaHora,
				id_sucursal = @id_sucursal
			WHERE id_factura = @id_factura;

            PRINT 'Factura modificada exitosamente.';
        END

         ELSE
            BEGIN
                PRINT 'La factura no existe.';
            END
END;