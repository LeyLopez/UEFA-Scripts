CREATE VIEW vista_detalles_jugadores 
AS
SELECT
    Jugadores.idJugador,
    Personas.primerNombre,
    Personas.primerApellido,
    Personas.fechaNacimiento,
    Equipos.nombre AS nombreEquipo
FROM
    Jugadores
JOIN Personas ON Jugadores.idJugador = Personas.idPersona
LEFT JOIN Equipos ON Jugadores.idEquipo = Equipos.idEquipo;



CREATE VIEW vista_contrataciones_directores 
AS
SELECT
    DirectoresTécnicos.idDirector,
    Personas.primerNombre,
    Personas.primerApellido,
    ContratacionesTécnicos.salario,
    ContratacionesTécnicos.fechaContratación,
    ContratacionesTécnicos.fechaFinContratación,
    Equipos.nombre AS nombreEquipo
FROM
    DirectoresTécnicos
JOIN Personas ON DirectoresTécnicos.idDirector = Personas.idPersona
JOIN ContratacionesTécnicos ON DirectoresTécnicos.idDirector = ContratacionesTécnicos.idDirectorTécnico
JOIN Equipos ON ContratacionesTécnicos.idEquipo = Equipos.idEquipo;


CREATE VIEW  vista_partidos_árbitros 
AS
SELECT
    Partidos.idPartido,
    Rondas.nombre AS nombreRonda,
    Partidos.fecha,
    ÁrbitrosPartido.idÁrbitro,
    Personas.primerNombre AS nombreÁrbitro,
    TiposÁrbitros.nombre AS tipoÁrbitro
FROM
    Partidos
JOIN Rondas ON Partidos.idRonda = Rondas.idRonda
JOIN ÁrbitrosPartido ON Partidos.idPartido = ÁrbitrosPartido.idPartido
JOIN Árbitros ON ÁrbitrosPartido.idÁrbitro = Árbitros.idÁrbitro
JOIN Personas ON Árbitros.idÁrbitro = Personas.idPersona
JOIN TiposÁrbitros ON ÁrbitrosPartido.idTipoÁrbitro = TiposÁrbitros.idTipoÁrbitro;


