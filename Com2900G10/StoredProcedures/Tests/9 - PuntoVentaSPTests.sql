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
						SP: CrearPuntoVenta
*******************************************************************************/

/* Resultado Esperado: Insercion OK. */
EXEC CrearPuntoVenta 3,1

/* Resultado Esperado: 'El punto de venta que se esta queriendo crear ya existe'. */
EXEC CrearPuntoVenta 3,1

/* Resultado esperado: 'La sucursal que se esta queriendo asociar al punto de venta no existe'. */
EXEC CrearPuntoVenta 3,2

/*******************************************************************************
						SP: BajaPuntoVenta
*******************************************************************************/

/* Resultado Esperado: 'El punto de venta que se quiere dar de baja no existe' */
EXEC BajaPuntoVenta 2,1

/* Resultado Esperado: 'El punto de venta que se quiere dar de baja no existe' */
EXEC BajaPuntoVenta 3,2

/* Resultado Esperado: 'Punto de venta dado de baja exitosamente.' */
EXEC BajaPuntoVenta 3,1

/*******************************************************************************
						SP: AltaPuntoVenta
*******************************************************************************/
/* Resultado Esperado: 'El punto de venta que se quiere dar de alta no existe' */
EXEC AltaPuntoVenta 2,1

/* Resultado Esperado: 'El punto de venta que se quiere dar de alta no existe' */
EXEC AltaPuntoVenta 3,2

/* Resultado Esperado: 'Punto de venta dado de baja exitosamente.' */
EXEC AltaPuntoVenta 3,1


