-- Tipo de pista, precio y nombre del polideportivo de las pistas que pertenezcan a polideportivos de Zaragoza (63 filas)

SELECT  P.tipo, P.precio, PP.nombre
FROM pistas P
INNER JOIN polideportivos PP ON P.id_polideportivo = pp.id
WHERE PP.ciudad = 'Zaragoza';

-- Toda la información de las reservas realizadas por el usuario con DNI 'MUUCLKSD8' (2 filas)

SELECT R.*
FROM reservas R
INNER JOIN usuario_reserva UR ON R.id = UR.id_reserva
WHERE UR.dni_usuario = 'MUUCLKSD8';

-- Número de pistas que hay de cada tipo en el polideportivo 'Nova Scotia' (4 filas)

SELECT P.tipo, COUNT(*) AS cantidad
FROM pistas P
INNER JOIN polideportivos PP ON P.id_polideportivo = PP.id
WHERE PP.nombre = 'Nova Scotia'
GROUP BY P.tipo;

-- Total de dinero generado por cada tipo de pista ordenado por recaudación (4 filas)

SELECT P.tipo, SUM(R.precio) AS recaudacion_total
FROM reservas R
INNER JOIN pistas P ON R.id_pista = P.id
GROUP BY P.tipo
ORDER BY recaudacion_total DESC;

-- Número de reservas que ha hecho cada usuario ordenados por apellidos (89 filas)

SELECT U.dni, U.nombre, U.apellidos, COUNT(UR.id_reserva) AS total_reservas
FROM usuarios U
LEFT JOIN usuario_reserva UR ON U.dni = UR.dni_usuario
GROUP BY U.dni, U.nombre, U.apellidos
ORDER BY U.apellidos;

-- DNI y nombre completo de todos los amigos del usuario con dni 'HKOWKLQF9' (4 filas)

SELECT U.dni, CONCAT(U.nombre, ' ', U.apellidos) AS nombre_completo
FROM usuario_usuario UU
INNER JOIN usuarios U ON UU.dni_amigo = U.dni
WHERE UU.dni_usuario = 'HKOWKLQF9';

-- Toda la información de los usuarios que tengan al menos 5 amigos (9 filas)

SELECT U.*
FROM usuarios U
WHERE U.dni IN (
    SELECT UU.dni_usuario
    FROM usuario_usuario UU
    GROUP BY UU.dni_usuario
    HAVING COUNT(UU.dni_amigo) >= 5
);

-- Toda la información de los usuarios que han hecho al menos una reserva en agosto de 2014 (14 filas)

SELECT DISTINCT U.*
FROM usuarios U
INNER JOIN usuario_reserva UR ON U.dni = UR.dni_usuario
INNER JOIN reservas R ON UR.id_reserva = R.id
WHERE MONTH(R.fecha_uso) = 8 AND YEAR(R.fecha_uso) = 2014;

-- Toda la información de los usuarios que han reservado una pista de tenis (46 filas)

SELECT DISTINCT U.*
FROM usuarios U
INNER JOIN usuario_reserva UR ON U.dni = UR.dni_usuario
INNER JOIN reservas R ON UR.id_reserva = R.id
INNER JOIN pistas P ON R.id_pista = P.id
WHERE P.tipo = 'tenis';

-- DNI, nombre, apellidos y fecha de reserva más reciente de todos los usuarios (100 filas)

SELECT U.dni, U.nombre, U.apellidos, MAX(R.fecha_reserva) AS ultima_reserva
FROM usuarios U
LEFT JOIN usuario_reserva UR ON U.dni = UR.dni_usuario
LEFT JOIN reservas R ON UR.id_reserva = R.id
GROUP BY U.dni, U.nombre, U.apellidos;