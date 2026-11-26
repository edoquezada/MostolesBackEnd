/*
Objetos Almacenados:
cada vez que se va aejecutar una consulta entra en accion un componente del RDBMS (Sistema de gestión de BBDD) 
denominado analizador u optimizador de consulta, que estudia el plan de ejecucion de la consulta, es decir, lo que
tiene que hacer para devolvernos lo que se pide, unas veces con solo ir al indice sera suficiente,
otras habra que unir tablas pero, en cualquier caso, es tiempo que se emplea que puede ralentizar el sistema.

Los objetos almacenados son un conjunto de sentencias de SQL que ya se guardan compiladas, es decir en el 
lenguaje que entiende el motor de la BBDD, de forma tal que el analizador de consultas no tiene que pensar como
ejecutar esa sentencia, porque el plan de ejecucion ya esta guardado, compilado, conjuntmanete con todas las demas sentencias.

Tipos de objetos almacenados:
1. Funciones
2. Porcedimientos almacenados

3. Triggers o disparadores (Son creados por los DBA y odiados por los programadores). Realmente las reglas del negocio se implementan en los trigger
4. Eventos
*/

/*
¿Qué es una funcion almacenada o funcion definida por el usuario UDF?, en adelante simplemente función.
Es un objeto que se crea con la sentencia CREATE FUNCTION y se invoca con SELECT o dentro de una expresion.
Una funcion ouede tener cero o muchas parametrois de entrada y siempre tiene que devoiover un valor,
asociado al nmombre de la función
*/

/*
¿Qué es un procedimiento almacenado (Stored Procedure)?, en adelante SP.
Es un objeto que se crea con la sentencia CREATE PROCEDURE y se invoca con la sentencia CALL. Un SP puede tener 
cero o muchos parametros de entrada y cero o muchos valores de salida.
*/

/*CREACIÓN DE OBJETOS ALMACENADOS*/
/*Los SP se guardan a nivel de BBDD no a nivel de tabla*/
-- Creación de nuestro primer SP

-- 1.SP. Listar productos de una gama completa
/*
DELIMITER: Para defirnir un SP es necesario modificar temporalmente el caracter separador qeu se utiliza para dleimitar 
las sentencias de SQL el ";" en este caso
*/
use jardineria;
-- Invocar SP Listar_productos
set @x = 'herramientas';
call Listar_productos (@x);

CALL `jardineria`.`Listar_productos`(<{in gama_producto varchar(50)}>);


-- 2.SP. Crear otro SP:
-- Contar los productos de una gama que se recibe como parametro y devolver el resultado
CALL `jardineria`.`Contar_Productos`(<{in gama varchar(50)}>, <{out total int}>);

set @resultado = 0;
call Contar_Productos(@x, @resultado);
select @resultado `Total de productos`;

SELECT CONCAT('El total del producto de la gama ', @x, ' es: ', @resultado) Mensaje;





















