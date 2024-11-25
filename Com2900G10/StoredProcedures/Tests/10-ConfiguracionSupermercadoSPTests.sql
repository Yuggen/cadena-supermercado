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
						SP: AgregarConfiguracion
*******************************************************************************/

/*Resultado esperado: OK Agregado*/
EXEC config.AgregarConfiguracion 'Valor Dolar', '1125'

/*Resultado esperado: 'La configuracion que se esta queriendo insertar ya existe.'*/
EXEC config.AgregarConfiguracion 'Valor Dolar', '1125'


/*******************************************************************************
						SP: ModificarConfiguracion
*******************************************************************************/

/*Resultado esperado: 'La configuracion que se esta queriendo modificar no existe.'*/
EXEC config.ModificarConfiguracion 'Hola', 'Pepe'

/*Resultado esperado: OK Modificado.*/
EXEC config.ModificarConfiguracion 'Valor Dolar', '1200'

/*******************************************************************************
						SP: EliminarConfiguracionPorID
*******************************************************************************/

/*Resultado esperado: 'La configuracion que se esta queriendo eliminar no existe.'*/
EXEC config.EliminarConfiguracionPorID 2

/*Resultado esperado: OK Eliminado'*/
EXEC config.EliminarConfiguracionPorID 1

/*******************************************************************************
						SP: EliminarConfiguracionPorDescripcion
*******************************************************************************/

/*Resultado esperado: No se puede eliminar la configuracion debido a que no existe.*/
EXEC config.EliminarConfiguracionPorDescripcion 'Valor Dolar'

/*Resultado esperado: Eliminado OK*/
EXEC config.AgregarConfiguracion 'Valor Dolar', '1125'
EXEC config.EliminarConfiguracionPorDescripcion 'Valor Dolar'

