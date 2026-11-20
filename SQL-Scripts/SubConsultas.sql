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

/*
OPERADORES QUE PODEMOS USAR EN SUBCONSULTAS
1. Operadores básicos de comparacion (>, >=, <, <=, !=, <>, =)
2. Predicados (Predicate (Condicion que se evalúa)) ANY, SOME y ALL
3. Predicados IN y NOT
4. Predicados EXISTS y NOT EXISTS
*/

/* Los Operadores basicos de comparacion se utilizan cuando queremos comparar una expresion
con el valor que devuelve una subconsulta 
Subconsulta para el uso del los operadore basicos de comparacion:

Recuperar todos los productos que tienen un precio mayor o igual al producto mas caro al fabricante Asus
*/
select producto.* 
from producto
where producto.precio >= (
	select max(producto.precio)
    from producto
    join fabricante on fabricante.id = producto.id_fabricante
    where fabricante.nombre = 'Asus'
)
order by precio desc;

-- Version VRMA
select *
from producto
where precio >= (
	select max(precio)
    from producto
    join fabricante on producto.id_fabricante = fabricante.id
    and fabricante.nombre = 'Asus'
);

-- La consulta anterior no se puede realizar usando USING, esta clausula solo admite conexiones con el mismo nombre

/*Uso de los operadores ANY y ALL en subconsultas
Estos operadores se utilizan conjuntamente con los operadores relacionales, y el operador ANY es equivalente al operador SOME
*/

-- Vamos a reescribir la misma consulta que recupera todos losmproductos que tienen un precio mayor o igual que todos los productos del fab. Asus
select *
from producto
where precio >= all (
	select precio
    from fabricante
    join producto on producto.id_fabricante = fabricante.id
    and fabricante.nombre = 'Asus'
);

-- Uso del operador Any
-- Recuperar el nombre de los fabricantes que tienen productos asociados
select nombre
from fabricante
where id = any (
	select id_fabricante
    from producto
)
order by nombre asc;

-- Recuperar el nombre de los fabricantes que no tienen productos asociados
select nombre
from fabricante
where id != all (
	select id_fabricante
    from producto
)
order by nombre asc;

/*
USO OPERADORES IN Y NOT IN
Tened en cuenta lo siguiebnte :

IN es equivalente a "= ANY" pero NOT IN no es equivalente a "!= ANY" pero si a "!= ALL"
IN = (= ANY)
NOT IN = (!= ALL)
*/

-- Recuperar un listado de todos los clientes que no han realizado ningun pedido, utilizando los operadores IN y NOT IN
use jardineria;

select nombre_cliente
from cliente
where codigo_cliente not in (
	select codigo_cliente
    from pedido
    )
order by nombre_cliente asc;

-- La consuta siguiente no lleva subconsulta, es solo para puntualizar alginos aspectos a la hora de recuperar registros de mas de una tabla
-- Recuperar: Clientes con sus pedidos y el nombre del empleado responsable de la venta

select 
	cl.nombre_cliente `Nombre Cliente`, 
    pe.codigo_pedido `Código Pedido`, 
    emp.nombre `Representante Ventas`
from cliente cl 
natural join pedido pe 
join empleado emp 
on cl.codigo_empleado_rep_ventas = emp.codigo_empleado
order by cl.nombre_cliente asc;

/*
USO OPERADORES EXISTS Y NOT EXISTS
Este tipo de operadores se implementan con subconsulta correlacionada, es decir que hacen referencia a una o varias tablas de la consulta que la contiene
o cualquier consulta mas exterior
A modo de ejemplo devolver un listado de clientes que no han relaizado ningun pedido
*/

select *
from cliente
where not exists (
	select codigo_cliente
    from pedido
    where cliente.codigo_cliente = pedido.codigo_cliente
);

/*En la consulta anterior, concretamente en la subconsulta, inicialmente en la select
especificamos el campo codigo_cliente, pero finalmente lo cambiamos por * y el resultado es exactamente el mismo*/

/* Recuperar un listado de todos los productos que tienen una precio mayor o igual 
a la media de todos los productos de su mismo fabricante*/
-- Para la solucion usar la base de datos tienda

use tienda;

select *
from producto prod1
where prod1.precio >= (
	select avg(prod2.precio)
    from producto prod2
    where prod1.id_fabricante = prod2.id_fabricante
)
order by prod1.precio asc;




 