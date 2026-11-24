use empresa;


-- ¿Como  se inicia una transaccion?
start transaction;


/* Cuando se esta en una transaccion las tablas de la base de datos no se modifica hasta
 * que se ejecute un commit explicitamente
 */


/* Comprobar si es posible eliminar los telefonos correspondientes a un empleado sin especificar 
 * la (PK) primary key de la tabla telefonos */


table telefonos;


delete from telefonos where empleado_id = 2;

/* En el caso que no haya sido posible ejecutar la sentencia anterior por que la seguridad
 * esta bien configurada por los DBA se procedera de la sgte forma */




/* VARIANTE # 1 
 * 
 * Creando una tabla temporal con todos los id de la tabla telefonos */




create temporary table ids select id from telefonos;




table ids;


 /* Para eliminar los telefonos del empleado cuyo id es 2 es decir que tienen los registros donde el
el campo empleado_id = 2 */


delete from telefonos where id = ANY (table ids) and empleado_id = 2;

/* Recordar que = ANY es lo mismo que IN, pero != ANY no es lo mismo que NOT IN */


delete from telefonos where id IN (table ids) and empleado_id = 2;


/* ¿Por que  hemos utilizado una tabla temporal en lugar de una subconsulta? */


delete from telefonos where id = ANY (select id from telefonos) and empleado_id = 2;






/* VARIANTE # 2 
 * 
 * Utilizando una derive table (tabla derivada) */
delete from telefonos 
   join (select id from telefonos) dt on telefonos.id = dt.id
    where telefonos.empleado;



-- rollback;
-- commit;




Primero utilizaremos la base de datos empresa.
 * 
 * ¿Que vamos hacer? Eliminar los telefonos correspondientes a un empleado,concreto.
 * 
 * No siempre la base de datos es propiedad nuestra y podemos, por ejemplo, configurar 
 * las relaciones para que las actualizaciones el borrado se propague en cascada a los hijos, 
 * por que no somos DBA (Data Base Administrator) y no tenemos los privilegios para hacerlo, 
 * ademas, los DBA acostumbran a exigir el uso de la PK (Primary Key) en operaciones de 
 * borrado y actualizado.
 *
 *Es decir , que vamos a ver como se procede cuando no es posible que se elimine o actualice 
 *un empleado  los cambios se propagen a telefonos y correos.
 *
 *NOTA IMPORTANTE :!!! Hasta el momento las consultas de eleccion no las hemos realizado
 *en el marco de una transaccion, pero el resto de las consultas se sugire hacerlas en el
 *marco de una transaccipon, como es el borrado y las actualizaciones, las sentencias 
 *de insert into, no.
 
 *¿Que es una transaccion? Es un conjunto de operaciones , un conjunto de sentencias SQL en este caso
 *que el seistema ve como se fuera una sola operacion, es una apuesta de todo o nada,
 *es decir que si falla alguna operacion hay que deshacer todas las demas (rollback)
 *y si todas las operaciones han tenido exito, se confirma entonces (commit)
 *
 *Es una muy buena practica de programacion tener las sentencias de rollback y commit entre comentarios
 *y poderlas ejecutar sin descomentarlas.
*/

use empresa;


-- ¿Como  se inicia una transaccion?
start transaction;


/* Cuando se esta en una transaccion las tablas de la base de datos no se modifica hasta
 * que se ejecute un commit explicitamente
 */


/* Comprobar si es posible eliminar los telefonos correspondientes a un empleado sin especificar 
 * la (PK) primary key de la tabla telefonos */


table telefonos;


delete from telefonos where empleado_id = 2;


/* En el caso que no haya sido posible ejecutar la sentencia anterior por que la seguridad
 * esta bien configurada por los DBA se procedera de la sgte forma */




/* VARIANTE # 1 
 * 
 * Creando una tabla temporal con todos los id de la tabla telefonos */

create temporary table ids select id from telefonos;


table ids;


 /* Para eliminar los telefonos del empleado cuyo id es 2 es decir que tienen los registros donde el
el campo empleado_id = 2 */


delete from telefonos where id = ANY (table ids) and empleado_id = 2;


-- VARIANTE #2
from telefonos
join (select id from telefonos) dt on telefonos.id = dt.id
where telefonos.empleado_id = 7;

delete telefonos


-- Clausula WHERE
/*
 * Si utilizamos mysql Workbench, la consulat anterior no da ninguna advertencia, por no utilizar la calususla WHERE
 * y utilizar la clausula WHERE y utilizar el operador AND en su lugar
 */




