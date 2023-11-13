CREATE OR REPLACE PROCEDURE cambiar_estado_partido(IN p_idPartido INT,
    IN p_idTipoEstado INT,
    IN p_fechaInicioEstado DATE,
    IN p_fechaRegistroInicioEstado DATE,
    IN p_fechaFinEstado DATE,
    IN p_fechaRegistroFinEstado DATE)
AS
$$
BEGIN
    UPDATE EstadosPartidos
    SET 
        idTipo = p_idTipoEstado,
        fechaInicioEstado = p_fechaInicioEstado,
        fechaRegistroInicioEstado = p_fechaRegistroInicioEstado,
        fechaFinEstado = p_fechaFinEstado,
        fechaRegistroFinEstado = p_fechaRegistroFinEstado
    WHERE idPartido = p_idPartido;
END;
$$ LANGUAGE plpgsql;



CREATE PROCEDURE obtener_detalles_partido(IN p_idPartido INT)
AS
$$
BEGIN
    SELECT 
        Partidos.idPartido,
        Equipos.nombre AS equipoLocal,
        Equipos.nombre AS equipoVisitante,
        Estadios.nombre AS nombreEstadio,
        Partidos.fecha,
        EstadosPartidos.fechaInicioEstado AS fechaInicioEstadoPartido,
        TiposEstadosPartidos.nombre AS estadoPartido
    FROM 
        Partidos
    JOIN Equipos ON Partidos.idEquipoLocal = Equipos.idEquipo
    JOIN Equipos AS Equipos ON Partidos.idEquipoVisitante = Equipos.idEquipo
    JOIN Estadios ON Partidos.idEstadio = Estadios.idEstadio
    JOIN EstadosPartidos ON Partidos.idPartido = EstadosPartidos.idPartido
    JOIN TiposEstadosPartidos ON EstadosPartidos.idTipo = TiposEstadosPartidos.idTipo
    WHERE Partidos.idPartido = p_idPartido;
END;
$$
LANGUAGE plpgsql;





CREATE PROCEDURE actualizar_estado_cargo(
    IN p_idRolDesempeñado INT,
    IN p_idTipo INT,
    IN p_fechaInicioEstado DATE,
    IN p_fechaRegistroInicioEstado DATE,
    IN p_fechaFinEstado DATE,
    IN p_fechaRegistroFinEstado DATE
)
AS
$$
BEGIN
    UPDATE EstadoCargos
    SET 
        idTipo = p_idTipo,
        fechaInicioEstado = p_fechaInicioEstado,
        fechaRegistroInicioEstado = p_fechaRegistroInicioEstado,
        fechaFinEstado = p_fechaFinEstado,
        fechaRegistroFinEstado = p_fechaRegistroFinEstado
    WHERE idCargo = p_idRolDesempeñado;
END;
$$
LANGUAGE plpgsql;










