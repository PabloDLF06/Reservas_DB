# Sistema de Gestión de Reservas de Polideportivos

Este repositorio contiene un sistema completo de gestión de reservas para polideportivos implementado en MySQL. Incluye la estructura de la base de datos, scripts para la creación de tablas, datos de muestra y una colección de consultas SQL organizadas por nivel de complejidad.

## Estructura del Repositorio

El repositorio se organiza de la siguiente manera:

- `Reservas_MySQL.sql`: Script principal que contiene la creación de la base de datos, tablas, relaciones y datos iniciales.
- `consultas_1.sql`: Consultas SQL básicas (selección, filtrado y ordenación).
- `consultas_2.sql`: Consultas SQL con funciones de agregación y agrupación.
- `consultas_3.sql`: Consultas SQL con JOINs y subconsultas.
- `consultas_4.sql`: Consultas SQL avanzadas con múltiples JOINs, subconsultas anidadas y casos complejos.


## Descripción del Sistema

El sistema modela una red de polideportivos donde los usuarios pueden realizar reservas de distintos tipos de pistas deportivas. A continuación se detallan las principales entidades:

### Entidades Principales

- **Polideportivos**: Instalaciones deportivas con ubicación y características.
- **Pistas**: Espacios deportivos clasificados por tipo (tenis, fútbol, baloncesto, ping-pong).
- **Usuarios**: Personas registradas que pueden realizar reservas.
- **Reservas**: Solicitudes de uso de pistas en fechas y horas específicas.


### Relaciones

- Los polideportivos contienen múltiples pistas
- Los usuarios realizan reservas de pistas
- Los usuarios pueden establecer relaciones de amistad entre ellos
- Las pistas pueden estar en estado abierto o cerrado


## Modelo de Datos

La base de datos consta de las siguientes tablas:

- `polideportivos`: Almacena información sobre las instalaciones deportivas.
- `pistas`: Contiene datos sobre los espacios deportivos disponibles.
- `pistas_abiertas`: Gestiona las pistas en estado operativo.
- `pistas_cerradas`: Registra las pistas clausuradas y el motivo.
- `usuarios`: Almacena la información de los usuarios registrados.
- `reservas`: Guarda los datos de las reservas realizadas.
- `usuario_reserva`: Tabla de relación entre usuarios y reservas.
- `usuario_usuario`: Tabla de relación que representa amistades entre usuarios.


## Instalación y Uso

### Requisitos Previos

- MySQL Server 5.7 o superior
- Cliente MySQL o herramienta de administración (MySQL Workbench, phpMyAdmin, etc.)


### Pasos para la Instalación

1. Clone este repositorio:

```bash
git clone https://github.com/PabloDLF06/Reservas_DB.git
```

2. Acceda a su servidor MySQL:

```bash
mysql -u [usuario] -p
```

3. Ejecute el script principal para crear la base de datos:

```bash
source Reservas_MySQL.sql
```

4. Verifique que la base de datos se ha creado correctamente:

```sql
SHOW DATABASES;
USE reservas;
SHOW TABLES;
```


## Ejemplos de Consultas

El repositorio incluye diversos ejemplos de consultas SQL organizados por nivel de complejidad:

### Consultas Básicas (consultas_1.sql)

Ejemplos de selección, filtrado y ordenación:

```sql
-- Nombre y apellidos de todos los usuarios
SELECT nombre, apellidos FROM usuarios;

-- Toda la información de los usuarios ordenados alfabéticamente por apellidos
SELECT * FROM usuarios ORDER BY apellidos;

-- Toda la información de los polideportivos de Zaragoza ordenados alfabéticamente por nombre
SELECT * FROM polideportivos
WHERE ciudad = 'Zaragoza'
ORDER BY nombre;
```


### Consultas con Agregación (consultas_2.sql)

Ejemplos con funciones de agregación y agrupación:

```sql
-- Número de polideportivos hay en cada ciudad
SELECT ciudad, COUNT(*) AS cantidad
FROM polideportivos
GROUP BY ciudad;

-- Precio medio, por tipo de pista
SELECT tipo, AVG(precio) AS precio_medio
FROM pistas
GROUP BY tipo;
```


### Consultas con JOINs (consultas_3.sql)

Ejemplos de uniones entre tablas:

```sql
-- Tipo de pista, precio y nombre del polideportivo de las pistas que pertenezcan a polideportivos de Zaragoza
SELECT P.tipo, P.precio, PP.nombre
FROM pistas P
INNER JOIN polideportivos PP ON P.id_polideportivo = pp.id
WHERE PP.ciudad = 'Zaragoza';
```


### Consultas Avanzadas (consultas_4.sql)

Ejemplos de consultas complejas con múltiples JOINs y subconsultas:

```sql
-- DNI y nombre completo de los usuarios que han hecho reservas en pistas de tenis
SELECT DISTINCT U.dni, CONCAT(U.nombre, ' ', U.apellidos) AS nombre_completo
FROM usuarios U
INNER JOIN usuario_reserva UR ON U.dni = UR.dni_usuario
INNER JOIN reservas R ON UR.id_reserva = R.id
INNER JOIN pistas P ON R.id_pista = P.id
WHERE P.tipo = 'tenis';
```


## Valor Educativo

Este repositorio está diseñado como recurso educativo para:

1. **Aprender diseño de bases de datos relacionales**:
    - Modelado de entidades y relaciones
    - Implementación de claves primarias y foráneas
    - Restricciones de integridad referencial
2. **Desarrollar habilidades en SQL**:
    - Consultas básicas y avanzadas
    - Funciones de agregación
    - Subconsultas y JOINs complejos
3. **Comprender casos de uso reales**:
    - Gestión de reservas
    - Relaciones muchos a muchos
    - Estados de entidades

## Contribuciones

Las contribuciones son bienvenidas. Si desea mejorar este proyecto, puede:

1. Hacer fork del repositorio
2. Crear una rama para su nueva funcionalidad
3. Enviar un pull request con sus cambios

## Contacto

Para consultas o sugerencias, puede contactar al autor a través de GitHub: [PabloDLF06](https://github.com/PabloDLF06)

<img src="https://user-images.githubusercontent.com/73097560/115834477-dbab4500-a447-11eb-908a-139a6edaec5c.gif">

Desarrollado con ❤️ como material educativo para la enseñanza de bases de datos relacionales y SQL.
