USE tienda;
#¿Qué artículos incluyen la palabra Pasta en su nombre?
SELECT nombre
FROM articulo
WHERE nombre LIKE '%pasta%';

#¿Qué artículos incluyen la palabra Cannelloni en su nombre?
SELECT nombre
FROM articulo
WHERE nombre LIKE '%cannelloni%';

#¿Qué nombres están separados por un guión (-) por ejemplo Puree - Kiwi?
SELECT nombre
FROM articulo
WHERE nombre LIKE '%-%';

#¿Qué puestos incluyen la palabra Designer?
SELECT nombre
FROM puesto
WHERE nombre LIKE '%designer%' ;

#¿Qué puestos incluyen la palabra Developer?
SELECT nombre
FROM puesto
WHERE nombre LIKE '%developer%' ;

#¿Cuál es el promedio de salario de los puestos?
SELECT ROUND(AVG(salario),2) as 'Promedio salario' 
FROM puesto;

#¿Cuántos artículos incluyen la palabra Pasta en su nombre?
SELECT COUNT(*) AS 'Art. Pasta'
FROM articulo
WHERE nombre LIKE '%pasta%';

#¿Cuál es el salario mínimo y máximo?
SELECT MIN(salario) AS mínimo, MAX(salario) AS maximo
FROM puesto;

#¿Cuál es la suma del salario de los últimos cinco puestos agregados?
SELECT SUM(salario) AS 'SUM LAST FIVE'
FROM puesto
WHERE id_puesto >
	((SELECT MAX(id_puesto) FROM puesto)-5);
    
#¿Cuántos registros hay por cada uno de los puestos?
SELECT nombre, COUNT(nombre) as conteo
FROM puesto
GROUP BY nombre;

#¿Cuánto dinero se paga en total por puesto?
SELECT nombre, SUM(salario) AS 'Cantidadxpuesto'
FROM puesto
GROUP BY nombre;

#¿Cuál es el número total de ventas por vendedor?
SELECT id_empleado, COUNT(id_empleado) as 'ventaxempleado'
FROM venta
GROUP BY id_empleado;

#¿Cuál es el número total de ventas por artículo?
SELECT id_articulo, COUNT(id_articulo) AS 'N° ventas'
FROM venta
GROUP BY id_articulo;

#------------EJERCICIOS----------------------
# 1 Dentro de la tabla employees, obten el número de empleado, apellido y nombre de todos los empleados cuyo nombre empiece con a.
SELECT id_empleado, apellido_paterno, apellido_materno, nombre
FROM empleado
WHERE nombre LIKE 'a%';

# 2 Dentro de la tabla employees, obten el número de empleado, apellido y nombre de todos los empleados cuyo nombre termina con on.
SELECT id_empleado, apellido_paterno, apellido_materno, nombre
FROM empleado
WHERE nombre LIKE '%on';

# 3 Dentro de la tabla employees, obten el número de empleado, apellido y nombre de todos los empleados cuyo nombre incluye la cadena on.
SELECT id_empleado, apellido_paterno, apellido_materno, nombre
FROM empleado
WHERE nombre LIKE '%on%';

# 4 Dentro de la tabla employees, obten el número de empleado, apellido y nombre de todos los empleados cuyos nombres tienen tres letras e inician con T y finalizan con m.
SELECT id_empleado, apellido_paterno, apellido_materno, nombre
FROM empleado
WHERE nombre LIKE 't_m';

# 5 Dentro de la tabla employees, obten el número de empleado, apellido y nombre de todos los empleados cuyo nombre no inicia con B.
SELECT id_empleado, apellido_paterno, apellido_materno, nombre
FROM empleado
WHERE nombre NOT LIKE 'b%';

# 6 Dentro de la tabla products, obten el código de producto y nombre de los productos cuyo código incluye la cadena _20.
USE classicmodels;
SELECT productCode, productName
FROM products
WHERE productCode LIKE '%_20%';

# 7 Dentro de la tabla orderdetails, obten el total de cada orden.
USE classicmodels;
SELECT orderNumber, SUM(quantityOrdered * priceEach) as Total
FROM orderdetails
GROUP BY orderNumber;

# 8 Dentro de la tabla orders obten el número de órdenes por año.
USE classicmodels;
SELECT YEAR(orderDate) AS AÑO , COUNT(*) AS 'Num x año'
FROM orders
GROUP BY YEAR(orderDate);

# 9 Obten el apellido y nombre de los empleados cuya oficina está ubicada en USA
USE classicmodels;
SELECT lastName, firstName
FROM employees
WHERE officeCode IN
	(SELECT officeCode FROM offices WHERE country = 'USA');
    
# 10 Obten el número de cliente, número de cheque y cantidad del cliente que ha realizado el pago más alto.
USE classicmodels;
SELECT customerNumber, checkNumber, amount
FROM payments
WHERE amount = 
	(SELECT MAX(amount) as max FROM payments);
    
# 11 Obten el número de cliente, número de cheque y cantidad de aquellos clientes cuyo pago es más alto que el promedio.
USE classicmodels;
SELECT customerNumber, checkNumber, amount
FROM payments
WHERE amount >
	(SELECT AVG(amount) as promedio FROM payments);
    
# 12 Obten el nombre de aquellos clientes que no han hecho ninguna orden.
USE classicmodels;
SELECT contactFirstName
FROM customers
WHERE customerNumber NOT IN
	(SELECT customerNumber FROM payments);
    
# 13 Obten el máximo, mínimo y promedio del número de productos en las órdenes de venta.
USE classicmodels;
SELECT orderNumber,MAX(quantityOrdered) as Maximo, MIN(quantityOrdered) as Minimo, AVG(quantityOrdered) as Promedio
FROM orderdetails
GROUP BY orderNumber;

# 14 Dentro de la tabla orders, obten el número de órdenes que hay por cada estado.
USE classicmodels;
SELECT status, COUNT(*) AS conteo
FROM orders
GROUP BY status;
