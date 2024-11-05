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


-- SP para la tabla Producto
GO
CREATE PROCEDURE CrearProducto
    @id_categoria_producto SMALLINT,
	@nombre_producto VARCHAR(100),
	@precio_unitario DECIMAL(10,4),
	@moneda CHAR(3)
AS
BEGIN
	INSERT INTO producto.producto 
    VALUES (@id_categoria_producto, @nombre_producto, @precio_unitario, @moneda);

	PRINT 'Producto agregado exitosamente.';
END;


GO
CREATE PROCEDURE ModificarProducto
	@id_producto SMALLINT, -- Solo para la busqueda
	@id_categoria_producto SMALLINT,
	@nombre_producto VARCHAR(100),
	@precio_unitario DECIMAL(10,4),
	@moneda CHAR(3)
AS
BEGIN
    IF EXISTS (SELECT 1 FROM producto.producto WHERE id_producto =  @id_producto)
        BEGIN
            UPDATE producto.producto 
				SET id_categoria_producto = @id_categoria_producto, nombre_producto = @nombre_producto, precio_unitario = @precio_unitario, moneda = @moneda
			WHERE id_producto = @id_producto;
            PRINT 'Producto modificado exitosamente.';
        END

         ELSE
            BEGIN
                PRINT 'El producto no existe.';
            END
END;

-- TODO: Definir baja de producto