/*******************************************************************************
*                                                                             *
*                           Entrega 3 - Grupo 10                              *
*																			  *
*                           Integrantes:                                      *
*                           43.988.577 Juan Pi�an                             *
*                           43.049.457 Matias Matter                          *
*                           42.394.230 Lucas Natario                          *
*                           Pablo Monardo                                     *
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

--Testeo Stored Procedures sucursal--

USE Com2900G10
GO

--Dar de baja una sucursal inexistente.
PRINT 'Intentar dar de baja una sucursal que no existe:'
EXEC BajaSucursal 1

--Insertar sucursal
EXEC CrearSucursal 'Haedo','Ramos Mejia','Calle Falsa 123','Tarde','1234-5678'
Select * from sucursal.sucursal

--Insertar sucursal ya insertada
EXEC CrearSucursal 'Haedo','Ramos Mejia','Calle Falsa 123','Tarde','1234-5678'

--Dar alta sucursal ya de alta o inexistente.
EXEC AltaSucursal 1
EXEC AltaSucursal 999

--Dar de baja sucursal.
EXEC BajaSucursal 1
select * from sucursal.sucursal

--Dar de baja sucursal inexistente o dada de baja previamente.
EXEC BajaSucursal 1
EXEC BajaSucursal 999

--Cambiar ubicacion de sucursal dada de baja o inexistente.
EXEC CambiarUbicacion 1, 'Ramos Mejia', 'Haedo', 'Calle False 456'
EXEC CambiarUbicacion 999, 'Ramos Mejia', 'Haedo', 'Calle False 456'

--Cambiar telefono de sucursal dada de baja o inexistente.
EXEC CambiarTelefono 1,'9089-7654'
EXEC CambiarTelefono 999,'9089-7654'

--Dar de alta la sucursal nuevamente
EXEC AltaSucursal 1

--Cambiar ubicacion sucursal
EXEC CambiarUbicacion 1, 'Ramos Mejia', 'Haedo', 'Calle False 456'

--Cambiar telefono sucursal
EXEC CambiarTelefono 1,'9089-7654'