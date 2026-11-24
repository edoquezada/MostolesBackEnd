/*
 * ¿Qué es una tabla derivada (derived tabla)?
 * Es una expresion de tabla (combinacion de operadores y operandos, que hay que evaluar
 * para obtener un resultado concreto, es este caso, una experesion de tabla se evalua
 * y da como resultado un conjunto (ResulSet) de filas y columnas) y se utiliza en la clausula FROM
 * de la consulta principal, entre parentesis.
 *
 * Las tablas derivadas se utilizan como alternativa a las tablas temporales y existen consultas
 * que no se pueden implementar si no se utiliza una tabla temporal o mejor una derivada
 */

/*
 * Una tabla temporal, como la que vamos a crear a continuacion, solo exixtira durante la sesion, es decir,
 * durante la conxion que hemos establecido con el motor de BBDD, una vez que cerramos la sesion la tabla se elimina 
 * de forma automática
 */

create database test;

use test;

-- crear un tabla temporal
create temporary table  t1 (s1 int not null, s2 char(5) not null, s3 float not null);
insert into t1 values (1, '2', 3.0), (2, '3', 4.0);

table t1;

/*
 * Creacion de la tabla derivada, a partir de la tabla temporal t1 en todos los casos:
 * Variante #1: Sin crear o definir alias para los campos de la expresion de tabla que aparece en la clausula FROM entre parentesis 
 */
select s1, s2, s3
from (select s1, s2, s3	from t1) dt;

/*
 * Variante #2: Definiendo alias para los campos para la expresion de tabla
 */
select sb1, sb2, sb3
from (select s1 sb1, s2 sb2, s3 sb3 from t1) dt
where sb1 > 1;

/*
 * Variante #3: Agregando una lista entre parentesis con los nombres que le vamos a asignar a los campos de la expresion de tabla
 * es decir, a la tabla derivada.
 */

select sb1, sb2, sb3
from (select * from t1) dt(sb1, sb2, sb3);

/*******************************************/
/*
 * Preparando las condiciones para utilizar una tabla derivada en un tipo de consulta que no se puede efectuar sin la tabla derivada
 */
-- Creamos una tabla temporal con registros repetidos

create temporary table t2 (columna1 int not null);
insert into t2 values (2), (2), (2), (4), (4), (5), (5), (5);
table t2;

/*Queremos obtener el promedio de la suma de los valores que son iguales en la tabla t2*/
-- Solucion en principio
-- Uso no valido de group by y no funciona eliminando group by
select avg(sum(columna1))
from t2
group by columna1;

-- Solucion correcta: implica crear un tabla derivada
SELECT avg(dt.sumatoria_por_columna) `Promedio de las sumas parciales`
from (select sum(columna1) sumatoria_por_columna from t2 group by columna1) dt;






