/*
 * comprobar la existencia de la tabla t1 y t2, eliminandolas si existen 
 */

DROP TEMPORARY TABLE IF EXISTS t1;
DROP TEMPORARY TABLE IF EXISTS t2;

create temporary table t1(c1 int not null, c2 int not null, c3 int not null);
create temporary table t2(c1 int not null, c2 int not null, c3 int not null);

insert into t1 values (1,2,3), (2,2,2), (3,3,3);
insert into t2 values (5,5,5), (2,2,2), (4,4,4), (3,3,3);

table t1;
table t2;


select c1, c2, c3
from t1
where row(c1, c2, c3) in (
	select c1, c2, c3
	from t2
);

-- ejemplo con operadores
select c1, c2, c3
from t2
where row(c1, c2, c3) > (
	select c1, c2, c3
	from t1 limit 1
);

/*
 * Creacion de tablas temporales a partir de tablas existentes
 * 
 * Usamos la BBDD world, la tabla country y de ella crer una tabla temporal
 */

use world;
drop table if exists t3;

create temporary table t3 select Code, Name, Continent, Region, SurfaceArea, IndepYear, Population from country;


table t3;
table country ;


/* Ejercicio # 1 del Martes 24 de Noviembre 
* 
* 1- Crear tabla temporal t4 con los campos Code, Name, Continent,
* Region, SurfaceArea, IndepYear, Population. Hacer que el campo Code
* sea PK. 
* 2- Crear una tabla temporal t5 a partir de la tabla countryLanguage 
* 3- Eliminar de la tabla t4 los paises que tengan menos de 4 lenguas 
* oficiales 
* 
* No olvidar hacer la operacion de borrado en el marco de una transacion
* 
* Nota: Previamente, crear una tabla temporal t6 con los paises que tengan
* menos de 4 lenguas oficiales 
*/

drop table if exists t4;

/*1*/
create temporary table t4
select Code, Name, Continent, Region, SurfaceArea, IndepYear, Population from country;

alter table t4 add constraint pk_t4 primary key(Code);
describe t4;
table t4;
/**********************************************/


/*2*/
drop table if exists t5;
create temporary table t5 as select * from countrylanguage;
table t5;
/**********************************************/


/*3*/
start transaction;
delete from t4 where Code in (select Code from t6);
table t4;
rollback;
commit;
/**********************************************/


/*T6*/
drop temporary table if exists t6;

create temporary table t6 
select c.Code, c.Name
from country c
left join countrylanguage cl
on c.Code = cl.CountryCode and cl.IsOfficial = 'T'
group by c.Code, c.Name
having count(cl.Language) < 4;

table t6;
/**********************************************/


table countrylanguage ;
table country  ;
