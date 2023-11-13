CREATE OR REPLACE PROCEDURE procedimiento_obtener_arbitros_final_temporada(IN nombreTemporada VARCHAR(254))
AS
$$
BEGIN
    SELECT Árbitros.idÁrbitro, Personas.primerNombre AS nombreÁrbitro, Personas.primerApellido AS apellidoÁrbitro
    FROM Árbitros
    JOIN ÁrbitrosPartido ON Árbitros.idÁrbitro = ÁrbitrosPartido.idÁrbitro
    JOIN Partidos ON ÁrbitrosPartido.idPartido = Partidos.idPartido
    JOIN Rondas ON Partidos.idRonda = Rondas.idRonda
    JOIN Fases ON Rondas.idFase = Fases.idFase
    JOIN Temporadas ON Fases.idTemporada = Temporadas.idTemporada
    JOIN Personas ON Árbitros.idÁrbitro = Personas.idPersona
    WHERE Fases.nombre = 'Final' AND Temporadas.nombre = nombreTemporada;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE PROCEDURE procedimiento_obtener_top_goleador_temporada(IN nombreTemporada VARCHAR(254))
AS
$$
BEGIN
    SELECT Jugadores.idJugador, Personas.primerNombre AS nombreJugador, Personas.primerApellido AS apellidoJugador, 
           COUNT(Goles.idGol) AS cantidadGoles
    FROM Jugadores
    JOIN Goles ON Jugadores.idJugador = Goles.idJugador
    JOIN Acciones ON Goles.idAcción = Acciones.idAcción
    JOIN Partidos ON Acciones.idPartido = Partidos.idPartido
    JOIN Temporadas ON Partidos.idTemporada = Temporadas.idTemporada
    JOIN Personas ON Jugadores.idJugador = Personas.idPersona
    WHERE Temporadas.nombre = nombreTemporada
    GROUP BY Jugadores.idJugador, Personas.primerNombre, Personas.primerApellido
    ORDER BY cantidadGoles DESC
    LIMIT 1;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE PROCEDURE procedimiento_cantidad_directores_equipo(IN idEquipoEspecifico INT)
AS
$$
DECLARE
    cantidadDirectores INT;
BEGIN
    SELECT COUNT(DISTINCT ContratacionesTécnicos.idDirectorTécnico)
    INTO cantidadDirectores
    FROM ContratacionesTécnicos
    WHERE ContratacionesTécnicos.idEquipo = idEquipoEspecifico;

    CONCAT('El equipo ', idEquipoEspecifico, ' ha contradado a ', cantidadDirectores, ' directores técnicos');
END;
$$ LANGUAGE plpgsql;