/*La sentencia u orden siguiente pone en uso la base de datos o esquema world
para realizar consultas a sus tablas*/
-- Esto es un comentario de linea
use world;

-- La sintaxis de la sentencia de SQL mas pequeña q se puede ejecutar
-- para recueperar los registros de la tabla country
select * from country;
table country;

-- Recuperar el campo region de la tabla
SELECT Region `La Región xdfgsdf` FROM country;    
-- no es necesaria la palabra "as" para establecer un alias
-- para el alias usa backtip, tecla pegada a P

-- se pueden recuperar varios campos separados por comas
select Name, SurfaceArea, Population, IndepYear from country;

-- Uso de clausula DISTINCT, por ejemplo para ver cuantas regiones diferentes existen en la tabla country
select distinct Region from country order by Region asc;

-- para limitar la cantidad de registros devueltos por la consultase utiliza la clausula LIMIT
select distinct Region from country order by Region asc limit 5;

-- pasar por alto los x primeros registros y recuperar los x restantes la clausula seria LIMIT X,X
select distinct Region from country order by Region asc limit 3,5;

-- devuelva un solo registro con la mayor poblacion del mundo
select Name, Population from country order by Population desc limit 1;
-- version pro:
select Name, Population from country where Population = (select max(Population) from country);

-- La clausula WHERE
-- evalua una expresion en booleano
-- Ejemplo:recuperar los paises que tienen una poblacion supoerior a los 10.000.000 de habitantes
select * from country where Population > 10000000 order by Population asc;

-- agregar condicion que el pais haya obtenido su independencia (juega con is null y is not null)
select * from country where Population > 10000000 and IndepYear is null order by Population asc;

-- agregar condicion OR que la region sea del caribe
select * from country where Population > 10000 and IndepYear is null or Region = "Caribbean" order by Population asc;

-- LIKE. Para busquedas exactas se utiliza el operador de asignacion =, pero para busquedas mas relajadas se utiliza LIKE
-- Ejemplo: recuperar todos los paises donde el campo continente contenga "America"
select Name `País`, Continent `Continente` from country where Continent like '%America%';

-- recuperar todos los paises donde el continente empiece con la letra "A"
select Name `País`, Continent `Continente` from country where Continent like 'Af%';







