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


-- SP para la tabla Producto
GO
CREATE OR ALTER PROCEDURE producto.CrearProducto
    @id_categoria_producto SMALLINT,
	@nombre_producto VARCHAR(100),
	@precio_unitario DECIMAL(10,4)
AS
BEGIN
	IF EXISTS (SELECT * FROM producto.categoria_producto cpr WHERE cpr.id_categoria_producto = @id_categoria_producto)
	BEGIN
			INSERT INTO producto.producto 
			VALUES (@id_categoria_producto, @nombre_producto, @precio_unitario);
			PRINT 'Producto agregado exitosamente.';

	END
	ELSE
		RAISERROR('La categoria del producto que se quiere insertar no se encuentra registrada',10,1)
END;


GO
CREATE OR ALTER PROCEDURE producto.ModificarProducto
	@id_producto SMALLINT, -- Solo para la busqueda
	@id_categoria_producto SMALLINT,
	@nombre_producto VARCHAR(100),
	@precio_unitario DECIMAL(10,4)
AS
BEGIN
    IF EXISTS (SELECT 1 FROM producto.producto WHERE id_producto =  @id_producto)
	BEGIN
		IF EXISTS (SELECT 1 FROM producto.categoria_producto where id_categoria_producto = @id_categoria_producto)
        BEGIN

				UPDATE producto.producto 
					SET id_categoria_producto = @id_categoria_producto, nombre_producto = @nombre_producto, precio_unitario = @precio_unitario
					WHERE id_producto = @id_producto;
            PRINT 'Producto modificado exitosamente.';

        END
		ELSE
			RAISERROR('Categoria de producto inexistente',10,1)
	END
         ELSE
             RAISERROR('El producto no existe.',10,1);
END;