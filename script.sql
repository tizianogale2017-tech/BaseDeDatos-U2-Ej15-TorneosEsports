-- Base de Datos I - Unidad 4 - Ej15: TorneosEsports
-- Script portable (SQLite / MySQL). En SQLite activar antes: PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS ESTADISTICA;
DROP TABLE IF EXISTS jugador_inscripcion;
DROP TABLE IF EXISTS equipo_torneo;
DROP TABLE IF EXISTS JUGADOR;
DROP TABLE IF EXISTS PARTIDO;
DROP TABLE IF EXISTS EQUIPO;
DROP TABLE IF EXISTS TORNEO;
DROP TABLE IF EXISTS VIDEOJUEGO;

CREATE TABLE VIDEOJUEGO (
    id_videojuego INT PRIMARY KEY,
    codigo_juego VARCHAR(50) UNIQUE,
    nombre_juego VARCHAR(50),
    genero VARCHAR(50),
    desarrollador VARCHAR(50),
    anio_lanzamiento INT
);

CREATE TABLE TORNEO (
    id_torneo INT PRIMARY KEY,
    id_videojuego INT,
    nombre_torneo VARCHAR(50),
    fecha_inicio DATE,
    fecha_fin DATE,
    premio_total DECIMAL(12,2),
    estado_torneo VARCHAR(50),
    FOREIGN KEY (id_videojuego) REFERENCES VIDEOJUEGO(id_videojuego)
);

CREATE TABLE EQUIPO (
    id_equipo INT PRIMARY KEY,
    tag_equipo VARCHAR(50),
    razon_social VARCHAR(50),
    pais_origen VARCHAR(50),
    fecha_fundacion DATE,
    sitio_web VARCHAR(100)
);

CREATE TABLE PARTIDO (
    id_partido INT PRIMARY KEY,
    id_torneo INT,
    id_equipo_local INT,
    id_equipo_visitante INT,
    id_equipo_ganador INT,
    fecha_hora_juego DATE,
    sets_local INT,
    sets_visitante INT,
    FOREIGN KEY (id_torneo) REFERENCES TORNEO(id_torneo),
    FOREIGN KEY (id_equipo_local) REFERENCES EQUIPO(id_equipo),
    FOREIGN KEY (id_equipo_visitante) REFERENCES EQUIPO(id_equipo),
    FOREIGN KEY (id_equipo_ganador) REFERENCES EQUIPO(id_equipo)
);

CREATE TABLE JUGADOR (
    id_jugador INT PRIMARY KEY,
    nickname VARCHAR(50) UNIQUE,
    nombre_real VARCHAR(50),
    nacionalidad VARCHAR(50),
    fecha_nacimiento DATE,
    rol_juego VARCHAR(50)
);

CREATE TABLE equipo_torneo (
    id_inscripcion INT PRIMARY KEY,
    id_equipo INT,
    id_torneo INT,
    fecha_inscripcion DATE,
    estado_inscripcion VARCHAR(50),
    FOREIGN KEY (id_equipo) REFERENCES EQUIPO(id_equipo),
    FOREIGN KEY (id_torneo) REFERENCES TORNEO(id_torneo)
);

CREATE TABLE jugador_inscripcion (
    id_jug_insc INT PRIMARY KEY,
    id_jugador INT,
    id_inscripcion INT,
    fecha_alta DATE,
    FOREIGN KEY (id_jugador) REFERENCES JUGADOR(id_jugador),
    FOREIGN KEY (id_inscripcion) REFERENCES equipo_torneo(id_inscripcion)
);

CREATE TABLE ESTADISTICA (
    id_estadistica INT PRIMARY KEY,
    id_jugador INT,
    id_partido INT,
    bajas INT,
    muertes INT,
    asistencias INT,
    danio_total DECIMAL(12,2),
    FOREIGN KEY (id_jugador) REFERENCES JUGADOR(id_jugador),
    FOREIGN KEY (id_partido) REFERENCES PARTIDO(id_partido)
);

-- Datos de VIDEOJUEGO
INSERT INTO VIDEOJUEGO (id_videojuego, codigo_juego, nombre_juego, genero, desarrollador) VALUES (1, 'LOL', 'League of Legends', 'MOBA', 'Riot Games');
INSERT INTO VIDEOJUEGO (id_videojuego, codigo_juego, nombre_juego, genero, desarrollador) VALUES (2, 'CS2', 'Counter-Strike 2', 'FPS', 'Valve');
INSERT INTO VIDEOJUEGO (id_videojuego, codigo_juego, nombre_juego, genero, desarrollador) VALUES (3, 'DOTA', 'Dota 2', 'MOBA', 'Valve');
INSERT INTO VIDEOJUEGO (id_videojuego, codigo_juego, nombre_juego, genero, desarrollador) VALUES (4, 'RL', 'Rocket League', 'Deportivo', 'Psyonix');

-- Datos de TORNEO
INSERT INTO TORNEO (id_torneo, id_videojuego, nombre_torneo, estado_torneo, fecha_inicio) VALUES (1, 1, 'Copa Sudamericana LoL', 'Finalizado', '2026-01-15');
INSERT INTO TORNEO (id_torneo, id_videojuego, nombre_torneo, estado_torneo, fecha_inicio) VALUES (2, 2, 'Liga CS Cuyo', 'En curso', '2026-09-01');
INSERT INTO TORNEO (id_torneo, id_videojuego, nombre_torneo, estado_torneo, fecha_inicio) VALUES (3, 1, 'Torneo Apertura LoL', 'Programado', '2026-12-01');
INSERT INTO TORNEO (id_torneo, id_videojuego, nombre_torneo, estado_torneo, fecha_inicio) VALUES (4, 4, 'Rocket Cup', 'Finalizado', '2026-05-05');

-- Datos de EQUIPO
INSERT INTO EQUIPO (id_equipo, tag_equipo, razon_social, pais_origen, fecha_fundacion) VALUES (1, 'KRU', 'Kru Esports SA', 'Argentina', '2015-03-10');
INSERT INTO EQUIPO (id_equipo, tag_equipo, razon_social, pais_origen, fecha_fundacion) VALUES (2, 'ISU', 'Isurus Gaming SRL', 'Argentina', '2016-07-22');
INSERT INTO EQUIPO (id_equipo, tag_equipo, razon_social, pais_origen, fecha_fundacion) VALUES (3, 'LEV', 'Leviatán Esports', 'Chile', '2018-05-14');
INSERT INTO EQUIPO (id_equipo, tag_equipo, razon_social, pais_origen, fecha_fundacion) VALUES (4, 'INF', 'Infinity Esports', 'Argentina', '2019-11-02');

-- Datos de PARTIDO
INSERT INTO PARTIDO (id_partido, id_torneo, id_equipo_local, id_equipo_visitante, id_equipo_ganador) VALUES (1, 1, 1, 2, 1);
INSERT INTO PARTIDO (id_partido, id_torneo, id_equipo_local, id_equipo_visitante, id_equipo_ganador) VALUES (2, 2, 3, 4, 4);
INSERT INTO PARTIDO (id_partido, id_torneo, id_equipo_local, id_equipo_visitante, id_equipo_ganador) VALUES (3, 2, 1, 3, 1);
INSERT INTO PARTIDO (id_partido, id_torneo, id_equipo_local, id_equipo_visitante, id_equipo_ganador) VALUES (4, 1, 2, 1, 2);

-- Datos de JUGADOR
INSERT INTO JUGADOR (id_jugador, nickname, nombre_real, rol_juego, nacionalidad) VALUES (1, 'Maki', 'Maite López', 'Entry', 'Argentina');
INSERT INTO JUGADOR (id_jugador, nickname, nombre_real, rol_juego, nacionalidad) VALUES (2, 'Tigre', 'Tomás Aguirre', 'Support', 'Chile');
INSERT INTO JUGADOR (id_jugador, nickname, nombre_real, rol_juego, nacionalidad) VALUES (3, 'Luna', 'Lucía Ferrari', 'AD Carry', 'Argentina');
INSERT INTO JUGADOR (id_jugador, nickname, nombre_real, rol_juego, nacionalidad) VALUES (4, 'Rayo', 'Rodrigo Mena', 'Flex', 'Uruguay');

-- Datos de equipo_torneo
INSERT INTO equipo_torneo (id_inscripcion, id_equipo, id_torneo, estado_inscripcion, fecha_inscripcion) VALUES (1, 2, 1, 'Confirmada', '2026-01-03');
INSERT INTO equipo_torneo (id_inscripcion, id_equipo, id_torneo, estado_inscripcion, fecha_inscripcion) VALUES (2, 3, 2, 'Confirmada', '2026-08-10');
INSERT INTO equipo_torneo (id_inscripcion, id_equipo, id_torneo, estado_inscripcion, fecha_inscripcion) VALUES (3, 4, 2, 'Confirmada', '2026-08-12');
INSERT INTO equipo_torneo (id_inscripcion, id_equipo, id_torneo, estado_inscripcion, fecha_inscripcion) VALUES (4, 1, 2, 'Pendiente', '2026-08-14');

-- Datos de jugador_inscripcion
INSERT INTO jugador_inscripcion (id_jug_insc, id_jugador, id_inscripcion, fecha_alta) VALUES (1, 1, 1, '2026-03-10');
INSERT INTO jugador_inscripcion (id_jug_insc, id_jugador, id_inscripcion, fecha_alta) VALUES (2, 2, 2, '2026-03-15');
INSERT INTO jugador_inscripcion (id_jug_insc, id_jugador, id_inscripcion, fecha_alta) VALUES (3, 3, 3, '2026-04-01');
INSERT INTO jugador_inscripcion (id_jug_insc, id_jugador, id_inscripcion, fecha_alta) VALUES (4, 4, 4, '2026-03-12');

-- Datos de ESTADISTICA
INSERT INTO ESTADISTICA (id_estadistica, id_jugador, id_partido, bajas, asistencias) VALUES (1, 1, 1, 8, 9);
INSERT INTO ESTADISTICA (id_estadistica, id_jugador, id_partido, bajas, asistencias) VALUES (2, 2, 2, 5, 14);
INSERT INTO ESTADISTICA (id_estadistica, id_jugador, id_partido, bajas, asistencias) VALUES (3, 3, 2, 15, 6);
INSERT INTO ESTADISTICA (id_estadistica, id_jugador, id_partido, bajas, asistencias) VALUES (4, 4, 3, 10, 11);
