CREATE OR REPLACE PROCEDURE registrar_falta(
    IN p_idPartido INT,
    IN p_idJugadorComete INT,
    IN p_idJugadorSufre INT,
    IN p_tiempo TIME,
    IN p_descripcion VARCHAR(254)
)
AS
$$
BEGIN
    DECLARE idAccion INT;

    INSERT INTO Acciones(tiempo, descripcion, idPartido, idTipo, idEtapa)
    VALUES(p_tiempo, p_descripcion, p_idPartido, 1, 1);

    SELECT idAcción INTO idAccion
    FROM Acciones
    WHERE idPartido = p_idPartido AND tiempo = p_tiempo AND descripcion = p_descripcion;

    INSERT INTO Faltas(idFalta, idJugadorQueComete, idJugadorQueSufre)
    VALUES(idAccion, p_idJugadorComete, p_idJugadorSufre);
END;
$$ LANGUAGE plpgsql;




CREATE OR REPLACE PROCEDURE obtener_equipos_por_ciudad(
    IN p_idCiudad INT
)
AS
$$
BEGIN
    SELECT E.nombre AS NombreEquipo
    FROM Equipos E
    JOIN Ciudades C ON E.idCiudad = C.idCiudad
    WHERE C.idCiudad = p_idCiudad;
END;
$$ LANGUAGE plpgsql;




CREATE OR REPLACE PROCEDURE actualizar_estado_jugador(
    IN p_idJugador INT,
    IN p_idEquipo INT,
    IN p_nuevoEstado VARCHAR(254)
)
AS
$$
BEGIN
    UPDATE JugadoresEnPartido
    SET estado = p_nuevoEstado
    WHERE idJugador = p_idJugador AND idEquipo = p_idEquipo;
END;
$$ LANGUAGE plpgsql;