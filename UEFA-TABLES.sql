CREATE TABLE Personas(
	idPersona SERIAL PRIMARY KEY,
	primerNombre VARCHAR(50) NOT NULL,
	otrosNombres VARCHAR(100) NULL,
	primerApellido VARCHAR(50) NOT NULL,
	otrosApellidos VARCHAR(100) NULL,
	fechaNacimiento DATE NOT NULL
	
);

CREATE TABLE Árbitros(
	idÁrbitro INT NOT NULL PRIMARY KEY,
	FOREIGN KEY(idÁrbitro) REFERENCES Personas(idPersona)
);

CREATE TABLE Jugadores(
	idJugador INT NOT NULL PRIMARY KEY,
	FOREIGN KEY(idJugador) REFERENCES Personas(idPersona)
);

CREATE TABLE DirectoresTécnicos(
	idDirector INT NOT NULL PRIMARY KEY,
	FOREIGN KEY(idDirector) REFERENCES Personas(idPersona)
);

CREATE TABLE Roles(
	idRol SERIAL PRIMARY KEY,
	nombre VARCHAR(254) NOT NULL,
	descripción VARCHAR(254) NULL
);

CREATE TABLE Cargos(
	idRolDesempeñado SERIAL PRIMARY KEY,
	idPersona INT NOT NULL,
	idRol INT NOT NULL,
	FOREIGN KEY(idPersona) REFERENCES Personas(idPersona),
	FOREIGN KEY(idRol) REFERENCES Roles(idRol)
);

CREATE TABLE TiposEstadoCargos(
	idTipo SERIAL PRIMARY KEY,
	nombre VARCHAR(254) NOT NULL
);

CREATE TABLE EstadoCargos(
	idEstadoCargo SERIAL PRIMARY KEY,
	idTipo INT NOT NULL,
	idCargo INT NOT NULL,
	fechaInicioEstado DATE NOT NULL,
	fechaRegistroInicioEstado DATE NOT NULL,
	fechaFinEstado DATE NULL,
	fechaRegistroFinEstado DATE NULL,
	FOREIGN KEY(idTipo) REFERENCES TiposEstadoCargos(idTipo),
	FOREIGN KEY(idCargo) REFERENCES Cargos(idRolDesempeñado)
);

CREATE TABLE Países(
	idPaís SERIAL PRIMARY KEY,
	nombre VARCHAR(254) NOT NULL,
	idCiudadCapital INT NULL
);

CREATE TABLE Nacionalidades(
	idNacionalidad SERIAL PRIMARY KEY,
	idPersona INT NOT NULL,
	idPaís INT NOT NULL,
	FOREIGN KEY(idPersona) REFERENCES Personas(idPersona),
	FOREIGN KEY(idPaís) REFERENCES Países(idPaís)
);

CREATE TABLE Ciudades(
	idCiudad SERIAL PRIMARY KEY,
	nombre VARCHAR(254) NOT NULL,
	altitud INT NOT NULL,
	temperaturaPromedio DECIMAL(5,2) NOT NULL,
	idPaís INT NOT NULL,
	FOREIGN KEY(idPaís) REFERENCES Países(idPaís)
);

ALTER TABLE Países
ADD FOREIGN KEY(idCiudadCapital) REFERENCES Ciudades(idCiudad);

CREATE TABLE Ligas(
	idLiga SERIAL PRIMARY KEY,
	nombre VARCHAR(254) NOT NULL
);

CREATE TABLE Equipos(
	idEquipo SERIAL PRIMARY KEY,
	nombre VARCHAR(254) NOT NULL,
	fechaFundación DATE NOT NULL,
	idCiudad INT NULL, 
	FOREIGN KEY(idCiudad) REFERENCES Ciudades(idCiudad)
);

CREATE TABLE Participaciones(
	idParticipación SERIAL PRIMARY KEY,
	añoParticipación INT NOT NULL,
	idEquipo INT NOT NULL,
	idLiga INT NOT NULL,
	FOREIGN KEY(idEquipo) REFERENCES Equipos(idEquipo),
	FOREIGN KEY(idLiga) REFERENCES Ligas(idLiga)
);


CREATE TABLE Estadios(
	idEstadio SERIAL PRIMARY KEY,
	nombre VARCHAR(254) NOT NULL,
	capacidad INT NOT NULL,
	tipoDeSuperficie VARCHAR(254) NOT NULL,
	idCiudad INT NOT NULL,
	idEquipo INT NULL,
	FOREIGN KEY(idCiudad) REFERENCES Ciudades(idCiudad),
	FOREIGN KEY(idEquipo) REFERENCES Equipos(idEquipo)
);

CREATE TABLE ContratacionesTécnicos(
	idContratación SERIAL PRIMARY KEY,
	salario INT NOT NULL,
	fechaContratación DATE NOT NULL,
	fechaFinContratación DATE NULL,
	idDirectorTécnico INT NOT NULL,
	idEquipo INT NOT NULL,
	FOREIGN KEY(idDirectorTécnico) REFERENCES DirectoresTécnicos(idDirector),
	FOREIGN KEY(idEquipo) REFERENCES Equipos(idEquipo)
);

CREATE TABLE ContratacionesJugadores(
	idContrataciónJugador SERIAL PRIMARY KEY,
	salario INT NOT NULL,
	fechaContratación DATE NOT NULL,
	fechaFinContratación DATE NULL,
	idJugador INT NOT NULL,
	idEquipo INT NOT NULL,
	FOREIGN KEY(idJugador) REFERENCES Jugadores(idJugador),
	FOREIGN KEY(idEquipo) REFERENCES Equipos(idEquipo)
);


CREATE TABLE Temporadas(
	idTemporada SERIAL PRIMARY KEY,
	nombre VARCHAR(254) NOT NULL
);


CREATE TABLE TiposEstadosTemporadas(
	idTipo SERIAL PRIMARY KEY,
	nombre VARCHAR(254) NOT NULL
);

CREATE TABLE EstadosTemporadas(
	idTemporada INT NOT NULL,
	idTipo INT NOT NULL,
	fechaInicioEstado DATE NOT NULL,
	fechaRegistroInicioEstado DATE NOT NULL,
	fechaFinEstado DATE NULL,
	fechaRegistroFinEstado DATE NULL,
	PRIMARY KEY(idTemporada, idTipo),
	FOREIGN KEY(idTemporada) REFERENCES Temporadas(idTemporada),
	FOREIGN KEY(idTipo) REFERENCES TiposEstadosTemporadas(idTipo)
);

CREATE TABLE Fases(
	idFase SERIAL NOT NULL PRIMARY KEY,
	nombre VARCHAR(254) NOT NULL,
	idTemporada INT NOT NULL,
	FOREIGN KEY(idTemporada) REFERENCES Temporadas(idTemporada)
);

CREATE TABLE Rondas(
	idRonda SERIAL PRIMARY KEY,
	nombre VARCHAR(254) NOT NULL,
	idFase INT NOT NULL,
	FOREIGN KEY(idFase) REFERENCES Fases(idFase)
);

CREATE TABLE Partidos(
	idPartido SERIAL PRIMARY KEY,
	idRonda INT NOT NULL,
	idEquipoLocal INT NOT NULL,
	idEquipoVisitante INT NOT NULL,
	idEstadio INT NOT NULL,
	FOREIGN KEY(idRonda) REFERENCES Rondas(idRonda),
	FOREIGN KEY(idEstadio) REFERENCES Estadios(idEstadio),
	FOREIGN KEY(idEquipoLocal) REFERENCES Equipos(idEquipo),
	FOREIGN KEY(idEquipoVisitante) REFERENCES Equipos(idEquipo),
	CONSTRAINT equipos_validos CHECK(idEquipoVisitante!=idEquipoLocal)
);

CREATE TABLE TiposEstadosPartidos(
	idTipo SERIAL PRIMARY KEY,
	nombre VARCHAR(254) NOT NULL
);

CREATE TABLE EstadosPartidos(
	idTipo INT NOT NULL,
	idPartido INT NOT NULL,
	fechaInicioEstado DATE NOT NULL,
	fechaRegistroInicioEstado DATE NOT NULL,
	fechaFinEstado DATE NULL,
	fechaRegistroFinEstado DATE NULL,
	PRIMARY KEY(idTipo, idPartido),
	FOREIGN KEY(idTipo) REFERENCES TiposEstadosPartidos(idTipo),
	FOREIGN KEY(idPartido) REFERENCES Partidos(idPartido)
);

CREATE TABLE TiposÁrbitros(
	idTipoÁrbitro SERIAL PRIMARY KEY,
	nombre VARCHAR(254) NOT NULL,
	descripción VARCHAR(254) NULL
);

CREATE TABLE ÁrbitrosPartido(
	idÁrbitraje SERIAL PRIMARY KEY,
	idÁrbitro INT NOT NULL,
	idTipoÁrbitro INT NOT NULL,
	idPartido INT NOT NULL,
	FOREIGN KEY(idÁrbitro) REFERENCES Árbitros(idÁrbitro),
	FOREIGN KEY(idPartido) REFERENCES Partidos(idPartido),
	FOREIGN KEY(idTipoÁrbitro) REFERENCES TiposÁrbitros(idTipoÁrbitro)
);

CREATE TABLE Posiciones(
	idPosición SERIAL PRIMARY KEY,
	nombre VARCHAR(254) NOT NULL,
	descripción VARCHAR(254) NULL
);

CREATE TABLE JugadoresEnPartido(
	idJugador INT NOT NULL,
	idPartido INT NOT NULL,
	idPosición INT NOT NULL,
	PRIMARY KEY(idJugador, idPartido, idPosición),
	FOREIGN KEY(idJugador) REFERENCES Jugadores(idJugador),
	FOREIGN KEY(idPartido) REFERENCES Partidos(idPartido),
	FOREIGN KEY(idPosición) REFERENCES Posiciones(idPosición)
);

CREATE TABLE TiposDeAcción(
	idTipo SERIAL PRIMARY KEY,
	nombre VARCHAR(254) NOT NULL,
	descripción VARCHAR(254) NULL
);

CREATE TABLE EtapasDelPartido(
	idEtapa SERIAL PRIMARY KEY,
	nombre VARCHAR(254) NOT NULL, 
	duración TIME NOT NULL
);

CREATE TABLE Acciones(
	idAcción SERIAL PRIMARY KEY,
	tiempo TIME NOT NULL,
	descripción VARCHAR(254) NULL,
	idTipo INT NOT NULL,
	idEtapa INT NOT NULL,
	idPartido INT NOT NULL,
	FOREIGN KEY(idTipo) REFERENCES TiposDeAcción(idTipo),
	FOREIGN KEY(idEtapa) REFERENCES EtapasDelPartido(idEtapa),
	FOREIGN KEY(idPartido) REFERENCES Partidos(idPartido)
);

CREATE TABLE Asistencias(
	idAsistencia INT NOT NULL PRIMARY KEY,
	idJugador INT NOT NULL,
	FOREIGN KEY(idAsistencia) REFERENCES Acciones(idAcción),
	FOREIGN KEY(idJugador) REFERENCES Jugadores(idJugador)
);

CREATE TABLE Goles(
	idGol INT NOT NULL PRIMARY KEY,
	idJugador INT NOT NULL,
	idAsistencia INT NULL,
	FOREIGN KEY(idGol) REFERENCES Acciones(idAcción),
	FOREIGN KEY(idJugador) REFERENCES Jugadores(idJugador),
	FOREIGN KEY(idAsistencia) REFERENCES Asistencias(idAsistencia)
);

CREATE TABLE Faltas(
	idFalta INT NOT NULL PRIMARY KEY,
	idJugadorQueComete INT NOT NULL,
	idJugadorQueSufre INT NOT NULL,
	FOREIGN KEY(idFalta) REFERENCES Acciones(idAcción),
	FOREIGN KEY(idJugadorQueComete) REFERENCES Jugadores(idJugador),
	FOREIGN KEY(idJugadorQueSufre) REFERENCES Jugadores(idJugador),
	CONSTRAINT jugadores_validos CHECK(idJugadorQueComete!=idJugadorQueSufre)
);

CREATE TABLE Cambios(
	idCambio INT NOT NULL PRIMARY KEY,
	idJugadorQueSale INT NOT NULL,
	idJugadorQueEntra INT NOT NULL,
	FOREIGN KEY(idCambio) REFERENCES Acciones(idAcción),
	FOREIGN KEY(idJugadorQueEntra) REFERENCES Jugadores(idJugador),
	FOREIGN KEY(idJugadorQueSale) REFERENCES Jugadores(idJugador),
	CONSTRAINT jugadores_validos_cambio CHECK(idJugadorQueEntra!=idJugadorQueSale)
);
