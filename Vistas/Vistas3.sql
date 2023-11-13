CREATE VIEW vista_jugadores_nacionalidad 
AS
SELECT
    J.idJugador,
    P.primerNombre,
    P.primerApellido,
    N.nombre AS Nacionalidad
FROM Jugadores J
JOIN Personas P ON J.idJugador = P.idPersona
JOIN Nacionalidades N ON P.idPersona = N.idPersona;



CREATE VIEW vista_equipos_estadios 
AS
SELECT
    E.idEquipo,
    E.nombre AS NombreEquipo,
    Es.nombre AS NombreEstadio,
    Es.capacidad
FROM
    Equipos E
JOIN Estadios Es ON E.idEquipo = Es.idEquipo;





CREATE VIEW vista_partidos_detalles 
AS
SELECT
    P.idPartido,
    R.nombre AS Ronda,
    E.nombre AS EquipoLocal,
    E2.nombre AS EquipoVisitante,
    Est.nombre AS Estadio,
    AP.nombre AS ArbitroPrincipal,
    AA.nombre AS ArbitroAsistente
FROM
    Partidos P
JOIN Rondas R ON P.idRonda = R.idRonda
JOIN Equipos E ON P.idEquipoLocal = E.idEquipo
JOIN Equipos E2 ON P.idEquipoVisitante = E2.idEquipo
JOIN Estadios Est ON P.idEstadio = Est.idEstadio
JOIN ÁrbitrosPartido AP ON P.idPartido = AP.idPartido AND AP.idTipoÁrbitro = 1
JOIN ÁrbitrosPartido AA ON P.idPartido = AA.idPartido AND AA.idTipoÁrbitro = 2;