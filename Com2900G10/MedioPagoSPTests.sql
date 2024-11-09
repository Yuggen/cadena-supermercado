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
						SP: CrearMedioPago
*******************************************************************************/

/* Resultado esperado: Inserci�n OK */
EXEC [Com2900G10].[venta].[CrearMedioPago] 'TEST1', 'TEST1';

/* Resultado esperado: Error - "Medio de pago ya existente" */
EXEC [Com2900G10].[venta].[CrearMedioPago] 'TEST1', 'TEST1';
EXEC [Com2900G10].[venta].[CrearMedioPago] 'TEST1', 'TEST1';

/*******************************************************************************
						SP: ModificarMedioPago
*******************************************************************************/

/* Resultado esperado: Modificacion OK */
EXEC [Com2900G10].[venta].[ModificarMedioPago] 1, 'TEST2', 'TEST2';

/* Resultado esperado: Error - "El medio de pago no existe" */
EXEC [Com2900G10].[venta].[ModificarMedioPago] 999, 'TEST2', 'TEST2';