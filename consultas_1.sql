-- Nombre y apellidos de todos los usuarios (100 filas)

SELECT nombre, apellidos FROM usuarios;

-- Toda la información de todos los usuarios (100 filas)

SELECT * FROM usuarios;

-- Toda la información de los usuarios ordenados alfabéticamente por apellidos (100 filas)

SELECT * FROM usuarios ORDER BY apellidos;

-- Toda la information de los polideportivos de Teruel (11 filas)

SELECT * FROM polideportivos WHERE ciudad = 'Teruel';

-- Nombre, dirección y ciudad de los polideportivos cuya extension sea de más de 200 (25 filas)

SELECT nombre, direccion, ciudad FROM polideportivos WHERE extension > 200;

-- Toda la información de los polideportivos de Zaragoza ordenados alfabéticamente por nombre (9 filas)

SELECT * FROM polideportivos
WHERE ciudad = 'Zaragoza'
ORDER BY nombre;

-- ID, tipo y precio de las pistas que cuesten menos de 10 euros (27 filas)

SELECT id, tipo, precio FROM pistas
WHERE precio < 10;

-- Toda la información de las pistas que cuestan entre 10 y 20 euros (166 filas)

SELECT * FROM pistas WHERE precio >= 10 AND precio <= 20;

SELECT * FROM pistas WHERE precio BETWEEN 10 AND 20;

-- Toda la información de los usuarios cuyo nombre empiece por 'A' (13 filas)

SELECT * FROM usuarios WHERE nombre LIKE 'A%';

-- Toda la información de los usuarios cuyo nombre acabe por 'a' ordenados por apellido (14 filas)

SELECT * FROM usuarios WHERE nombre LIKE '%a' ORDER BY apellidos;

-- Toda la información de los polideportivos cuya extension sea de 152, 259 o 399 (3 filas)

SELECT * FROM polideportivos WHERE extension IN (152, 259, 399);

-- Toda la información de los polideportivos cuyo nombre no empiece por 'Z' (32 filas)

SELECT * FROM polideportivos WHERE nombre NOT LIKE 'Z%';

-- Nombre completo de los usuarios cuyo nombre no empiece por 'A' (87 filas)

SELECT CONCAT(nombre, ' ', apellidos) AS nombre_completo
FROM usuarios
WHERE nombre NOT LIKE 'A%';

-- Nombre completo de los usuarios nacidos en 2014 y que sean de Zaragoza (12 filas)

SELECT CONCAT(nombre, ' ', apellidos) AS nombre_completo
FROM usuarios
WHERE YEAR(fecha_nacimiento) = 2014 AND ciudad = 'Zaragoza';

-- Nombre completo y fecha de nacimiento completa en castellano de los usuarios nacidos en 2013 (53 filas)

SELECT CONCAT(nombre, ' ', apellidos) AS nombre_completo,
DATE_FORMAT(fecha_nacimiento, '%d de %M de %Y') AS fecha_nacimiento_es
FROM usuarios
WHERE YEAR(fecha_nacimiento) = 2013;