CREATE VIEW vista_participaciones_equipo
AS
SELECT Equipos.idEquipo, Equipos.nombre AS nombreEquipo, Temporadas.nombre AS temporada, COUNT(Partidos.idPartido) AS cantidadPartidos
FROM Equipos
LEFT JOIN Partidos ON Equipos.idEquipo = Partidos.idEquipoLocal OR Equipos.idEquipo = Partidos.idEquipoVisitante
JOIN Participaciones ON Equipos.idEquipo = Participaciones.idEquipo
JOIN Temporadas ON Participaciones.idTemporada = Temporadas.idTemporada
GROUP BY Equipos.idEquipo, Temporadas.nombre;



CREATE VIEW vista_equipos_ciudades_estadios AS
SELECT Equipos.idEquipo, Equipos.nombre AS nombreEquipo, Ciudades.nombre AS nombreCiudad, Estadios.nombre AS nombreEstadio
FROM Equipos
LEFT JOIN Ciudades ON Equipos.idCiudad = Ciudades.idCiudad
LEFT JOIN Estadios ON Equipos.idEquipo = Estadios.idEquipo;



CREATE VIEW vista_top_goleadores_temporada AS
SELECT Jugadores.idJugador, Personas.primerNombre AS nombreJugador, Personas.primerApellido AS apellidoJugador, 
       COUNT(Goles.idGol) AS cantidadGoles, Temporadas.nombre AS temporada
FROM Jugadores
JOIN Goles ON Jugadores.idJugador = Goles.idJugador
JOIN Acciones ON Goles.idAcción = Acciones.idAcción
JOIN Partidos ON Acciones.idPartido = Partidos.idPartido
JOIN Temporadas ON Partidos.idTemporada = Temporadas.idTemporada
JOIN Personas ON Jugadores.idJugador = Personas.idPersona
GROUP BY Temporadas.nombre, Jugadores.idJugador
ORDER BY cantidadGoles DESC;