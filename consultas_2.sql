-- Número de polideportivos hay en cada ciudad (3 filas)

SELECT ciudad, COUNT(*) AS cantidad
FROM polideportivos
GROUP BY ciudad;

-- Número de usuarios en cada ciudad (4 filas)

SELECT ciudad, COUNT(*) AS cantidad
FROM usuarios
GROUP BY ciudad;

-- Número de polideportivos hay en cada ciudad, solamente de aquellas ciudades donde hay más de 10 (2 filas)

SELECT ciudad, COUNT(*) AS cantidad
FROM polideportivos
GROUP BY ciudad
HAVING COUNT(*) > 10;

-- Cantidad de pistas que hay en cada polideportivo (32 filas)

SELECT PP.id, PP.nombre, COUNT(*) AS numero_pistas
FROM polideportivos PP, pistas P
WHERE PP.id = P.id_polideportivo
GROUP BY PP.id;

-- Precio medio, por tipo de pista (4 filas)

SELECT tipo, AVG(precio) AS precio_medio
FROM pistas
GROUP BY tipo;

-- Cuánto vale la pista más cara (1 fila)

SELECT MAX(precio) AS pista_mas_cara
FROM pistas;

-- Cuánto vale la pista más barata (1 fila)

SELECT MIN(precio) AS pista_mas_barata
FROM pistas;

-- Número de veces que se ha reservado cada pista (131 filas)

SELECT id_pista, COUNT(*) AS numero_reservas
FROM reservas
GROUP BY id_pista;

-- ID de las pistas con más de 2 reservas (13 filas)

SELECT id_pista
FROM reservas
GROUP BY id_pista
HAVING COUNT(*) > 2;

-- Nombre de los tipos de pistas cuyo precio medio es de más de 10 euros (3 filas)

SELECT tipo
FROM pistas
GROUP BY tipo
HAVING AVG(precio) > 10;