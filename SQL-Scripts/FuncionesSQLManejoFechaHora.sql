/*
 * En la docu oficial de MySQL 9.7:
 * https://dev.mysql.com/doc/refman/9.7/en/date-and-time-functions.html 
 */

use jardineria;

-- Para seleccionar la fecha actual
select CURDATE();

-- Sumar 31 dias a la fecha actual
select DATE_ADD(CURDATE(), INTERVAL 31 DAY);
select ADDDATE(CURDATE(), 31);

-- Saber el nombre del dia actual
select DAYNAME(CURDATE());

/*
 * Mostrar el nombre de la semana en español o el idioma que queramos
 */
-- Recuperamos el valor de la variable que nos permite hacer el cambio
select @@lc_time_names;

-- Para establecer el idioma a español de Esp
select @@lc_time_names = 'es_ES';


/*
 * Recuperar los pedidos que se han efectuados en los ultimos 5 dias del mes
 */

-- Para todas las variantes de solucion usaremos fecha_pedido

-- Solucion 1:
explain select * 
from pedido 
where fecha_pedido >= DATE_SUB(LAST_DAY(fecha_pedido), interval 5 day);


-- Solucion 2:
-- Usaremos BETWEEN()
explain select * 
from pedido 
where fecha_pedido between DATE_SUB(LAST_DAY(fecha_pedido), interval 5 day) and last_day(fecha_pedido);


-- Solucion 3:
-- Utilizando la funcion DATEDIFF()
select *
from pedido
where DATEDIFF(last_day(fecha_pedido ), fecha_pedido ) <= 5; 


-- Solucion 4:
-- Solo si el intervalo es menor a un mes //NO USAR
select *
from pedido
where fecha_pedido >= last_day(fecha_pedido) - 5;






