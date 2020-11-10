USE tienda;
#RETO1
#NOTA: EL PRIMER EJERCICIO SE ENCONTRABA DIFERENTE DURANTE LA SESION Y LA HORA DE VOLVERLO A REVISAR, POR ESTA RAZON SE ENCUENTRA DOS VECES CON EL LÍMITE DE SALARIO COMO DIFERENCIADOR
#¿Cuál es el nombre de los empleados cuyo sueldo es menor a $10,000?
SELECT nombre
FROM empleado
WHERE id_puesto IN
	(SELECT id_puesto
	FROM puesto
	WHERE salario < 10000);

#¿Cuál es el nombre de los empleados cuyo sueldo es mayor a $100,000?
USE tienda;
SELECT nombre
FROM empleado
WHERE id_puesto IN
	(SELECT id_puesto
	FROM puesto
	WHERE salario > 100000);
#¿Cuál es la cantidad mínima y máxima de ventas de cada empleado?
USE tienda;
SELECT id_empleado, min(v_empleado) as minimo, max(v_empleado) as maximo
FROM
	(SELECT clave, id_empleado, count(*) v_empleado
	FROM venta
	GROUP BY clave, id_empleado) AS subconsulta
GROUP BY id_empleado
ORDER BY id_empleado;

#¿Cuáles claves de venta incluyen artículos cuyos precios son mayores a $5,000?
USE tienda;
SELECT clave
FROM venta
WHERE id_articulo IN
	(SELECT id_articulo
	FROM articulo
	WHERE precio > 5000);
    
#RETO2
#¿Cuál es el nombre de los empleados que realizaron cada venta?
SELECT e.nombre, v.id_venta, clave
FROM empleado AS e
JOIN venta AS v
	ON e.id_empleado = v.id_empleado;

#¿Cuál es el nombre de los artículos que se han vendido?
SELECT v.id_venta, clave, a.nombre as Articulo
FROM venta AS v
JOIN articulo AS a
	ON v.id_articulo = a.id_articulo
ORDER BY v.id_venta;

#¿Cuál es el total de cada venta?
SELECT clave, round(sum(a.precio), 2) AS total 
FROM venta AS v 
JOIN articulo AS a 
	ON  v.id_articulo = a.id_articulo
GROUP BY clave
ORDER BY clave;

#RETO3
#Obtener el puesto de un empleado.
CREATE VIEW puesto_1_079 AS
(SELECT concat(e.nombre, ' ', e.apellido_paterno) AS nombre , p.nombre AS puesto
FROM empleado AS e
JOIN puesto AS p
	ON e.id_puesto = p.id_puesto);
SELECT* FROM puesto_1_079;

#Saber qué artículos ha vendido cada empleado.
CREATE VIEW articulo_2_079 AS
(SELECT CONCAT(e.nombre, ' ', e.apellido_paterno) AS NomCompleto, a.nombre AS articulo, v.clave
FROM empleado e
JOIN venta v
	ON e.id_empleado = v.id_empleado
JOIN articulo a
	ON v.id_articulo = a.id_articulo
ORDER BY v.clave);
SELECT* FROM articulo_2_079;
#Saber qué puesto ha tenido más ventas.
CREATE VIEW ventas_3_079 AS
(SELECT p.nombre AS Puesto, count(v.clave) AS N°ventas
FROM venta v
JOIN empleado e
	ON v.id_empleado = e.id_empleado
JOIN puesto p
	ON e.id_puesto = p.id_puesto
GROUP BY p.nombre
ORDER BY N°ventas DESC);

SELECT* FROM ventas_3_079 LIMIT 1;

#EJERCICIOS------
USE classicmodels;
#Para estas consultas usa RIGHT JOIN#

# 1. Obten el código de producto, nombre de producto y descripción de todos los productos.
SELECT productCode, productName, productDescription
FROM products;
# 2. Obten el número de orden, estado y costo total de cada orden.
SELECT o.orderNumber, o.status, od.quantityOrdered * od. priceEach AS total
FROM orders o
RIGHT JOIN orderdetails od
	ON o.orderNumber = od.orderNumber;
# 3. Obten el número de orden, fecha de orden, línea de orden, nombre del producto, cantidad ordenada y precio de cada pieza que muestre los detalles de cada orden.
SELECT o.orderNumber, o.orderDate, p.productLine, p.productName, od.quantityOrdered, od.priceEach
FROM orders o
RIGHT JOIN orderdetails od
	ON o.orderNumber = od.orderNumber
RIGHT JOIN products p
	ON od.productCode = p.productCode
ORDER BY o.orderNumber;

# 4. Obtén el número de orden, nombre del producto, el precio sugerido de fábrica (msrp) y precio de cada pieza.
SELECT o.orderNumber, p.productName, p.MSRP , od.priceEach
FROM orders o
RIGHT JOIN orderdetails od
	ON o.orderNumber = od.orderNumber
RIGHT JOIN products p
	ON od.productCode = p.productCode;
#Para estas consultas usa LEFT JOIN

# 5. Obtén el número de cliente, nombre de cliente, número de orden y estado de cada cliente.
SELECT o.customerNumber, c.customerName, o.orderNumber, c.state
FROM orders o
LEFT JOIN customers c
	ON o.customerNumber = c.customerNumber;
# 6. Obtén los clientes que no tienen una orden asociada.
SELECT c.customerName, c.customerNumber
FROM customers c
LEFT JOIN orders o
	ON  c.customerNumber = o.customerNumber
WHERE c.customerNumber NOT IN
	(SELECT customerNumber
	FROM orders);

# 7. Obtén el apellido de empleado, nombre de empleado, nombre de cliente, número de cheque y total, es decir, los clientes asociados a cada empleado.
SELECT e.lastName, e.firstName, c.customerName,  p.checkNumber
FROM customers c
LEFT JOIN employees e
	ON c.SalesRepEmployeeNumber = e.employeeNumber
LEFT JOIN payments p
	ON c.customerNumber = p.customerNumber;

#Para estas consultas usa RIGHT JOIN

# 8. Repite los ejercicios 5 a 7 usando RIGHT JOIN.
#8.1
SELECT o.customerNumber, c.customerName, o.orderNumber, c.state
FROM orders o
RIGHT JOIN customers c
	ON o.customerNumber = c.customerNumber;
#8.2
SELECT c.customerName, c.customerNumber
FROM orders o
RIGHT JOIN customers c
	ON  o.customerNumber = c.customerNumber
WHERE c.customerNumber NOT IN
	(SELECT customerNumber
	FROM orders);
#8.3
SELECT e.lastName, e.firstName, c.customerName,  p.checkNumber
FROM customers c
RIGHT JOIN employees e
	ON c.SalesRepEmployeeNumber = e.employeeNumber
RIGHT JOIN payments p
	ON c.customerNumber = p.customerNumber;
# 10. Escoge 3 consultas de los ejercicios anteriores, crea una vista y escribe una consulta para cada una.
#SIN PERMISOS PARA CREAR VISTAS