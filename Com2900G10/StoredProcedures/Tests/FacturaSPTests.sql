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
						SP: CrearFactura
*******************************************************************************/

/* Resultado esperado: Insercion OK*/
EXEC [Com2900G10].[venta].[CrearFactura] 1,1234,'A','Consumidor Final','2024-11-09 09:00',1

/* Resultado esperado: Error - "El medio de pago de la factura no existe" */
EXEC [Com2900G10].[venta].[CrearFactura] 999,1234,'A','Consumidor Final','2024-11-09 09:00',1

/* Resultado esperado: Error - "El empleado generador de la factura no existe o esta inactivo" */
EXEC [Com2900G10].[venta].[CrearFactura] 1,9999,'A','Consumidor Final','2024-11-09 09:00',1

/* Resultado esperado: Error - "La sucursal de la factura no existe o esta inactiva" */
EXEC [Com2900G10].[venta].[CrearFactura] 1,1234,'A','Consumidor Final','2024-11-09 09:00', 999

/*******************************************************************************
						SP: ModificarFactura
*******************************************************************************/

/* Resultado esperado: Modificacion OK*/
EXEC [Com2900G10].[venta].[ModificarFactura] 1, 1,1234,'B','Consumidor Final','2024-11-09 09:00',1

/* Resultado esperado: Error - "La factura no existe" */
EXEC [Com2900G10].[venta].[ModificarFactura] 999, 1,1234,'B','Consumidor Final','2024-11-09 09:00',1

/* Resultado esperado: Error - "El medio de pago de la factura no existe" */
EXEC [Com2900G10].[venta].[ModificarFactura] 1, 999,1234,'B','Consumidor Final','2024-11-09 09:00',1