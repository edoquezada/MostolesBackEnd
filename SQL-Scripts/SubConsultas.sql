use world;
/*
Recuperar el pais y la poblacion del pais que tiene mas habitantes, consulta que ya habiamos 
implementado pero de una forma nada eficiente utilizando ORDER BY y LIMIT
*/
select Name `País`, Population `Población`
from country
where Population = (select max(Population) from country);

-- Ejercicio 1 19/11/2026: Recuoperar la ciudad que tiene mas habitantes y el pais donde se encuentra utilizando subconsulta
select city.Name, country.Name, city.Population
from country join city on country.Code = city.CountryCode 
where city.Population = (select max(Population) from city);

--

use jardineria;
/*
Tipos de subconsulta:

1.Subconsultas de fila: Devuelven multiples columnas (campos) y una sola fila
2.Subconsultas de tabla: Devuelven una o varias columnas y entre 0 y varias filas
3.Subconsultas escalares: Devuelven una columna y una fila (una celda), es decir un valor
*/
-- Subconsultas en la clausula WHERE:
-- Ejercicio: Suponga que queremos conocer el nombre del producto que tiene mayor precio.
select prd.nombre `Nombre`, prd.precio_venta `Precio de Venta`, prd.precio_proveedor `Precio Proveedor`
from producto prd 
where precio_venta = (select max(precio_venta) from producto);

use tienda;
select nombre, precio
from producto
where precio = (select max(precio) from producto);

/*Subconsulta en la clausula HAVING
Recuperar un listado con todos los nombres de los fabricantes que tienen el mismo numero de productos que el fabricante asus*/
select fabricante.nombre, count(producto.id_fabricante) `Total de Productos`
from fabricante join producto on fabricante.id = producto.id_fabricante
group by fabricante.nombre
having `Total de Productos` = (
	select count(producto.id_fabricante)
    from fabricante join producto on fabricante.id = producto.id_fabricante
    and fabricante.nombre = 'Asus'
);

-- Ejercicio 2 19/11/2026: Eliminar del resultado anterior el fabricante Asus
select fabricante.nombre, count(producto.id_fabricante) `Total de Productos`
from fabricante join producto on fabricante.id = producto.id_fabricante
where fabricante.nombre != 'Asus'
group by fabricante.nombre
having `Total de Productos` = (
	select count(producto.id_fabricante)
    from fabricante join producto on fabricante.id = producto.id_fabricante
    and fabricante.nombre = 'Asus'
);

-- Subconsulta en clausula FROM
-- Recuperar todos los productos que tiene un precio mayor o igual al precio promedio de todos los productos de su mismo fabricante
select producto.* 
from producto join (
	select id_fabricante, avg(precio) PrecioPromedio
    from producto
    group by id_fabricante
) t 
on producto.id_fabricante = t.id_fabricante
and producto.precio >= PrecioPromedio
order by precio desc;

/*Por cortesia de Elias la consulta anterior es mejor implementarla utilizando NATURAL JOIN en lugar de INNER JOIN
porque es perfecto cuando hay campos en las dos tablas que tienen el mismo nombre y nos evita utilizar la clausula ON o USING
*/

-- Clausula USING
select producto.* 
from producto join (
	select id_fabricante, avg(precio) PrecioPromedio
    from producto
    group by id_fabricante
) t 
using (id_fabricante)
where producto.precio >= PrecioPromedio
order by precio desc;

-- Clausula NATURAL JOIN
select producto.* 
from producto natural join (
	select id_fabricante, avg(precio) PrecioPromedio
    from producto
    group by id_fabricante
) t 
where producto.precio >= PrecioPromedio
order by precio desc;

-- Consultas auxiliares
table fabricante;
table producto;

/*OPERADORES QUE PODEMOS USAR EN SUBCONSULTAS*/





 