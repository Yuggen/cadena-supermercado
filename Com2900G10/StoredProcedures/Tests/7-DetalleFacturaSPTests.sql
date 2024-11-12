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

USE [Com2900G10]
GO
/*******************************************************************************
						SP: CrearDetalleFactura
*******************************************************************************/

/* Resultado esperado: Insercion OK*/
EXEC [Com2900G10].[venta].[CrearDetalleFactura] 1, 1, 10;

/* Resultado esperado: Error - "La factura a la que intenta asociar el detalle no existe" */
EXEC [Com2900G10].[venta].[CrearDetalleFactura] 99, 1, 10;

/* Resultado esperado: Error - "El producto del detalle no existe no existe" */
EXEC [Com2900G10].[venta].[CrearDetalleFactura] 1, 99, 10;

/*******************************************************************************
						SP: ModificarDetalleFactura
*******************************************************************************/

/* Resultado esperado: Modificacion OK*/
EXEC [Com2900G10].[venta].[ModificarDetalleFactura] 1, 11;

/* Resultado esperado: Error - "El detalle que quiere modificar no existe" */
EXEC [Com2900G10].[venta].[ModificarDetalleFactura] 99, 11;
