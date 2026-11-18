-- Recuperar todos lo empleados y sus telefonos
use empresa;
select Emp.nombre, Emp.primerApellido, Emp.segundoApellido, Tel.numero
from empleados Emp inner join telefonos Tel on Emp.id = Tel.empleado_id;

-- recuperar los empleados tengan o no telefono
select Emp.nombre, Emp.primerApellido, Emp.segundoApellido, Tel.numero
from empleados Emp left join telefonos Tel on Emp.id = Tel.empleado_id;

-- Ejercicio 2: Recuperar paises y su idioma siempre que sea su idoma oficial
use world;
select pais.Code, pais.Name, idioma.Language, idioma.IsOfficial
from country pais join countrylanguage idioma on pais.Code = idioma.CountryCode and idioma.IsOfficial = "T";

-- Ejercicio 3: Recuperar la ciudad mas poblada y el nombre del pais donde se encuentra
select city.Name, country.Name, city.Population
from country join city on country.Code = city.CountryCode where city.Population = (select max(Population) from city);

-- Ejercicio 4: modificar ejercicio 2 para que solamente muestre resultados para españa y todos los idiomas, no solo los oficiales
select pais.Code, pais.Name, idioma.Language, idioma.IsOfficial
from country pais join countrylanguage idioma on pais.Code = idioma.CountryCode and pais.Name = "Spain";
