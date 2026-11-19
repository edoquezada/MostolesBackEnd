/* Las funciones de agregado, tambien llamadas operaciones de agregado, 
agrupan registros para obtener un resultado */

/* ¿Que es una variable? 

Es un identificador, un nombre, que se le asigna a una ubicacion en la memoria
RAM del equipo y que, en principio, solamente puede almacenar un valor de un tipo 
de datos concreto, por ejemplo un entero (INT), una cadena de caracteres (VARCHAR) */

/* ¿Que es una funcion? 

Tambien llamada en los inicios de la programacion Rutina o Subrutina, es un conjunto de
sentencias o instrucciones de un lenguaje de programacion (Basic, Ensamblador, Fortran, 
Pascal, FoxPro, Java, Python, PHP, JavaScript, TypeScript, C, C++, Rust), que se declara
una sola vez, ya sea en el propio programa o en una biblioteca (library) aparte, y se le
un nombre, y posteriormente puede ser invocado o llamada todas las veces que hagan falta
desde cualquier parte del programa que estemos desarrollando */

use world;

-- Contar el total de paises que hay en la tabla country
select count(Name) `Total de Paises`
from country;

-- Cuando tenemos un poco experiencia, la sentencia anterior la escribimos como:
select count(*) `Total de Paises`
from country;

-- Contar cuantos paises hay por Region
select Region, count(*) `Total de Paises`
from country
group by Region
order by `Total de Paises`  desc;

-- De la consulta anterior mostrar solamente los resultados para las regiones que 
-- tienen mas de 10 paises.
select Region, count(*) `Total de Paises`
from country
group by Region
having `Total de Paises` > 10
order by `Total de Paises`  desc;

/* NOTA IMPOTANTE: 

En una sentencia de SQL donde se utilicen funciones de agregado (COUNT(), MAX(),
MIN(), AVG(), SUM(), ETC.), los campos que no esten afectados por una funcion 
de agregado, hay que incluirlos en la clausula GROUP BY

Y, si no se utilizan funciones de agregado, o se agrupa, las clausula WHERE y HAVING
se pueden utilizar indistintamente, es decir, con intercambiables, pero si se agrupa
para filtrar o evaluar condiciones antes de agrupar, antes de GROUP BY, se utiliza 
la clausula WHERE, y para operar sobre los registros agrupados se utiliza la clausula
HAVING
*/
-- La misma consulta anterior, pero excluyendo los paises que todavia no han obtenido
-- su independencia
select Region, count(*) `Total de Paises`
from country
where IndepYear is not null
group by Region
having `Total de Paises` > 10
order by `Total de Paises`  desc;

-- Ejercicio # 1 del Miercoles 18 de Noviembre
-- Recuperar el total de habitantes que hay por Continente y Region
-- excluir del resultado aquellos paises que tengan una Poblacion inferior al millon 
-- de habitantes o que no hayan obtenido su independencia todavia,
-- ordenar el resultado por el total de poblacion, mostrando las Regiones que tienen menos
-- habitantes primero, y solo mostrar los registros con mas de 5 millones de habitantes. 
-- Solucion aportada por Belen
select Continent, Region, sum(Population) `Total población`
from country
where Population >= 1000000 and IndepYear is not null
group by Continent,Region
having `Total población` > 5000000
order by `Total población` asc;






-- Sentencias SQL auxiliares
table country;