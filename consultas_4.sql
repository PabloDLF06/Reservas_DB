-- Toda la información de los usuarios que han hecho al menos 5 reservas (11 filas)

SELECT U.*
FROM usuarios U
INNER JOIN usuario_reserva UR ON U.dni = UR.dni_usuario
GROUP BY U.dni, U.nombre, U.apellidos, U.email, U.ciudad, U.fecha_nacimiento, U.descuento, U.fecha_alta
HAVING COUNT(UR.id_reserva) >= 5;

-- DNI y Nombre completo de los usuarios que han hecho reservas en pistas de tenis (46 filas)

SELECT DISTINCT U.dni, CONCAT(U.nombre, ' ', U.apellidos) AS nombre_completo
FROM usuarios U
INNER JOIN usuario_reserva UR ON U.dni = UR.dni_usuario
INNER JOIN reservas R ON UR.id_reserva = R.id
INNER JOIN pistas P ON R.id_pista = P.id
WHERE P.tipo = 'tenis';

-- DNI y nombre completo de los usuarios sin amigos (9 filas)

SELECT U.dni, CONCAT(U.nombre, ' ', U.apellidos) AS nombre_completo
FROM usuarios U
WHERE U.dni NOT IN (
    SELECT DISTINCT dni_usuario
    FROM usuario_usuario
);

-- DNI y nombre completo de los usuarios con amigos en Teruel (72 filas)

SELECT DISTINCT U.dni, CONCAT(U.nombre, ' ', U.apellidos) AS nombre_completo
FROM usuarios U
INNER JOIN usuario_usuario UU ON U.dni = UU.dni_usuario
INNER JOIN usuarios U2 ON UU.dni_amigo = U2.dni
WHERE U2.ciudad = 'Teruel';

-- Toda la información de los polideportivos que tienen pistas de baloncesto que han sido reservadas más de 5 veces (2 filas)

SELECT PP.*
FROM polideportivos PP
INNER JOIN pistas P ON PP.id = P.id_polideportivo
INNER JOIN reservas R ON P.id = R.id_pista
WHERE P.tipo = 'baloncesto'
GROUP BY PP.id, PP.nombre, PP.direccion, PP.ciudad, PP.extension
HAVING COUNT(R.id) > 5;

-- DNI y nombre completo de los usuarios que han hecho más de una reserva en pistas de baloncesto de un polideportivo de Zaragoza (5 filas)

SELECT U.dni, CONCAT(U.nombre, ' ', U.apellidos) AS nombre_completo
FROM usuarios U
INNER JOIN usuario_reserva UR ON U.dni = UR.dni_usuario
INNER JOIN reservas R ON UR.id_reserva = R.id
INNER JOIN pistas P ON R.id_pista = P.id
INNER JOIN polideportivos PP ON P.id_polideportivo = PP.id
WHERE P.tipo = 'baloncesto' AND PP.ciudad = 'Zaragoza'
GROUP BY U.dni, U.nombre, U.apellidos
HAVING COUNT(R.id) > 1;

-- Toda la información de los usuarios que son amigos de otros usuarios que tengan más de 5 amigos (35 filas)

SELECT DISTINCT U.*
FROM usuarios U
INNER JOIN usuario_usuario UU ON U.dni = UU.dni_amigo
WHERE UU.dni_usuario IN (
    SELECT dni_usuario
    FROM usuario_usuario
    GROUP BY dni_usuario
    HAVING COUNT(dni_amigo) > 5
);

-- DNI y nombre completo de los usuarios que han realizado las reservas de las pistas que han sido reservadas una sola vez (73 filas)

SELECT DISTINCT U.dni, CONCAT(U.nombre, ' ', U.apellidos) AS nombre_completo
FROM usuarios U
INNER JOIN usuario_reserva UR ON U.dni = UR.dni_usuario
INNER JOIN reservas R ON UR.id_reserva = R.id
WHERE R.id_pista IN (
    SELECT id_pista
    FROM reservas
    GROUP BY id_pista
    HAVING COUNT(*) = 1
);

-- DNI y nombre completo de los usuarios que tengan amigos que hayan reservado alguna pista en Huesca (66 filas)

SELECT DISTINCT U.dni, CONCAT(U.nombre, ' ', U.apellidos) AS nombre_completo
FROM usuarios U
INNER JOIN usuario_usuario UU ON U.dni = UU.dni_usuario
WHERE UU.dni_amigo IN (
    SELECT DISTINCT UR.dni_usuario
    FROM usuario_reserva UR
    INNER JOIN reservas R ON UR.id_reserva = R.id
    INNER JOIN pistas P ON R.id_pista = P.id
    INNER JOIN polideportivos PP ON P.id_polideportivo = PP.id
    WHERE PP.ciudad = 'Huesca'
);

-- Tipo de pista y polideportivo de las pistas que han sido reservadas por algún usuario con más de 5 reservas realizadas (25 filas)

SELECT DISTINCT P.tipo, PP.nombre
FROM pistas P
INNER JOIN reservas R ON P.id = R.id_pista
INNER JOIN usuario_reserva UR ON R.id = UR.id_reserva
INNER JOIN polideportivos PP ON P.id_polideportivo = PP.id
WHERE UR.dni_usuario IN (
    SELECT dni_usuario
    FROM usuario_reserva
    GROUP BY dni_usuario
    HAVING COUNT(id_reserva) > 5
);

-- Tipo de pista y nombre de los polideportivos que tienen pistas que han sido reservadas por usuarios que han realizado una sola reserva (12 filas)

SELECT DISTINCT P.tipo, PP.nombre
FROM pistas P
INNER JOIN reservas R ON P.id = R.id_pista
INNER JOIN usuario_reserva UR ON R.id = UR.id_reserva
INNER JOIN polideportivos PP ON P.id_polideportivo = PP.id
WHERE UR.dni_usuario IN (
    SELECT dni_usuario
    FROM usuario_reserva
    GROUP BY dni_usuario
    HAVING COUNT(id_reserva) = 1
);

-- DNI y nombre completo de los usuarios que tienen algún amigo que no ha hecho ninguna reserva (55 filas)

SELECT DISTINCT U.dni, CONCAT(U.nombre, ' ', U.apellidos) AS nombre_completo
FROM usuarios U
INNER JOIN usuario_usuario UU ON U.dni = UU.dni_usuario
WHERE UU.dni_amigo NOT IN (
    SELECT dni_usuario
    FROM usuario_reserva
);

-- Consulta extra de práctica del INNER JOIN: Usuarios que han hecho reservas

SELECT U.dni, U.nombre, U.apellidos, R.id AS id_reserva, R.fecha_uso
FROM usuarios U
INNER JOIN usuario_reserva UR ON U.dni = UR.dni_usuario
INNER JOIN reservas R ON UR.id_reserva = R.id;

-- Consulta extra de práctica del INNER JOIN: Información de pistas en polideportivos de Zaragoza

SELECT P.id, P.tipo, P.precio, PP.nombre AS nombre_polideportivo
FROM pistas P
INNER JOIN polideportivos PP ON P.id_polideportivo = PP.id
WHERE PP.ciudad = 'Zaragoza';

-- Consulta extra de práctica del INNER JOIN: Múltiples JOIN encadenados

SELECT U.nombre, U.apellidos, P.tipo, PP.nombre AS polideportivo
FROM usuarios U
INNER JOIN usuario_reserva UR ON U.dni = UR.dni_usuario
INNER JOIN reservas R ON UR.id_reserva = R.id
INNER JOIN pistas P ON R.id_pista = P.id
INNER JOIN polideportivos PP ON P.id_polideportivo = PP.id;

-- Nombre completo, tipo de pista que reservaron, nombre del polideportivo y fechas de reservas hechas en 2014 (14 filas)

SELECT U.nombre, U.apellidos, P.tipo, PP.nombre as polideportivo
FROM usuarios U
INNER JOIN usuario_reserva UR ON U.dni = UR.dni_usuario
INNER JOIN reservas R ON UR.id_reserva = R.id
INNER JOIN pistas P ON R.id_pista = P.id
INNER JOIN polideportivos PP ON P.id_polideportivo = PP.id
WHERE YEAR(R.fecha_uso) = 2014;

-- Ejemplos prácticos de relación entre tablas.
-- Relación entre pistas y polideportivos

SELECT P.tipo, P.precio, PP.nombre
FROM pistas P
INNER JOIN polideportivos PP ON P.id_polideportivo = PP.id;

-- Relación entre usuarios y sus reservas

SELECT U.nombre, U.apellidos, R.fecha_reserva
FROM usuarios U
INNER JOIN usuario_reserva UR ON U.dni = UR.dni_usuario
INNER JOIN reservas R ON UR.id_reserva = R.id;