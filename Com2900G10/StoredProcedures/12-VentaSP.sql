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
-- SP para la tabla Venta
CREATE OR ALTER PROCEDURE venta.GenerarVenta
@id_factura INT,
@legajo_empleado INT,
@id_sucursal  SMALLINT,
@tipo_cliente VARCHAR(50),
@id_cliente	INT,
@id_punto_venta_empleado INT
AS
BEGIN
	IF NOT EXISTS (SELECT * FROM [Com2900G10].[venta].[venta] where id_factura = @id_factura)
	BEGIN
		
	END
	ELSE
	BEGIN
		RAISERROR ('No puede haber 2 ventas para una misma factura.',10,1)
		RETURN
	END
END
GO