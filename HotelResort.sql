--CREO LAS TABLAS--

IF DB_ID(N'HotelResort') IS NULL
    CREATE DATABASE HotelResort;

GO
USE HotelResort;
GO

-- CHEQUEO QUE NO ESTÉN EN LA BDD ANTES DE CREARLAS --

IF OBJECT_ID('Clientes', 'U') IS NOT NULL DROP TABLE Clientes;
IF OBJECT_ID('Habitaciones', 'U') IS NOT NULL DROP TABLE Habitaciones;
IF OBJECT_ID('Temporadas', 'U') IS NOT NULL DROP TABLE Temporadas;
IF OBJECT_ID('Tarifas', 'U') IS NOT NULL DROP TABLE Tarifas;
IF OBJECT_ID('Reservas', 'U') IS NOT NULL DROP TABLE Reservas;
IF OBJECT_ID('DetalleReserva', 'U') IS NOT NULL DROP TABLE DetalleReserva;
IF OBJECT_ID('Servicios', 'U') IS NOT NULL DROP TABLE Servicios;
IF OBJECT_ID('Alertas', 'U') IS NOT NULL DROP TABLE Alertas;
GO


CREATE TABLE Clientes (
    id_cliente INT IDENTITY(1,1) PRIMARY KEY,
    nombre NVARCHAR(100),
    estado NVARCHAR(10) CHECK (estado IN ('Activo', 'Inactivo'))
);

CREATE TABLE Habitaciones (
    id_habitacion INT IDENTITY(1,1) PRIMARY KEY,
    tipo NVARCHAR(20),
    piso INT,
    vista NVARCHAR(20),
    capacidad INT,
    estado NVARCHAR(20) CHECK (estado IN ('Disponible', 'FueraServicio', 'Inactiva'))
);

CREATE TABLE Temporadas (
    id_temporada INT IDENTITY(1,1) PRIMARY KEY,
    tipo NVARCHAR(20) CHECK (tipo IN ('Alta', 'Media', 'Baja')),
    fecha_inicio DATE,
    fecha_fin DATE
);

CREATE TABLE Tarifas (
    id_tarifa INT IDENTITY(1,1) PRIMARY KEY,
    id_temporada INT FOREIGN KEY REFERENCES Temporadas(id_temporada),
    tipo_habitacion NVARCHAR(20),
    precio DECIMAL(10,2)
);

CREATE TABLE Reservas (
    id_reserva INT IDENTITY(1,1) PRIMARY KEY,
    id_cliente INT FOREIGN KEY REFERENCES Clientes(id_cliente),
    check_in DATE,
    check_out DATE,
    total DECIMAL(10,2)
);

CREATE TABLE DetalleReserva (
    id_detalle INT IDENTITY(1,1) PRIMARY KEY,
    id_reserva INT FOREIGN KEY REFERENCES Reservas(id_reserva),
    id_habitacion INT FOREIGN KEY REFERENCES Habitaciones(id_habitacion),
    subtotal DECIMAL(10,2)
);

CREATE TABLE Servicios (
    id_servicio INT IDENTITY(1,1) PRIMARY KEY,
    descripcion NVARCHAR(100),
    costo DECIMAL(10,2),
    precio DECIMAL(10,2),
    cupo_diario INT
);

CREATE TABLE Alertas (
    id_alerta INT IDENTITY(1,1) PRIMARY KEY,
    tipo NVARCHAR(20),
    descripcion NVARCHAR(255),
    fecha DATETIME DEFAULT GETDATE()
);
GO

-- FUNCIÓN (PRECIO-COSTO) --
CREATE OR ALTER FUNCTION fn_margen_servicio(@id_serv INT)
RETURNS DECIMAL(10,2)
AS
BEGIN
    DECLARE @costo DECIMAL(10,2);
    DECLARE @precio DECIMAL(10,2);
    DECLARE @margen DECIMAL(10,2);

    SELECT @costo = costo, @precio = precio
    FROM Servicios
    WHERE id_servicio = @id_serv;

    SET @margen = @precio - @costo;

    RETURN @margen;
END;
GO


-- VISTA (HABITACIONES REPETIDAS) --
CREATE OR ALTER VIEW vw_habitaciones_repetidas AS
SELECT
    r.id_cliente,
    dr.id_habitacion,
    r.check_in,
    COUNT(*) AS cantidad
FROM Reservas r
JOIN DetalleReserva dr ON r.id_reserva = dr.id_reserva
GROUP BY r.id_cliente, dr.id_habitacion, r.check_in
HAVING COUNT(*) > 1;
GO

-- PROCEDIMIENTO (REGISTRA RESERVAS) --
CREATE OR ALTER PROCEDURE sp_registrar_reserva
    @id_cliente INT,
    @id_habitacion INT,
    @check_in DATE,
    @check_out DATE
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @estado_cliente NVARCHAR(10),
            @estado_habitacion NVARCHAR(20),
            @precio DECIMAL(10,2),
            @total DECIMAL(10,2),
            @id_temporada INT,
            @dias INT;

    -- Validar cliente activo
    SELECT @estado_cliente = estado FROM Clientes WHERE id_cliente = @id_cliente;
    IF @estado_cliente <> 'Activo'
    BEGIN
        INSERT INTO Alertas(tipo, descripcion) VALUES ('Error', CONCAT('Cliente inactivo: ', @id_cliente));
        THROW 50000, 'Cliente inactivo', 1;
    END;

    -- Validar habitación disponible
    SELECT @estado_habitacion = estado FROM Habitaciones WHERE id_habitacion = @id_habitacion;
    IF @estado_habitacion <> 'Disponible'
    BEGIN
        INSERT INTO Alertas(tipo, descripcion) VALUES ('Error', CONCAT('Habitación no disponible: ', @id_habitacion));
        THROW 50001, 'Habitación no disponible', 1;
    END;

    -- Determinar temporada
    SELECT TOP 1 @id_temporada = id_temporada
    FROM Temporadas
    WHERE @check_in BETWEEN fecha_inicio AND fecha_fin;

    IF @id_temporada IS NULL
    BEGIN
        INSERT INTO Alertas(tipo, descripcion) VALUES ('Error', 'No existe tarifa vigente para la fecha');
        THROW 50002, 'No existe tarifa vigente', 1;
    END;

    -- Obtener tarifa
    SELECT TOP 1 @precio = precio
    FROM Tarifas
    WHERE id_temporada = @id_temporada
      AND tipo_habitacion = (SELECT tipo FROM Habitaciones WHERE id_habitacion = @id_habitacion);

    SET @dias = DATEDIFF(DAY, @check_in, @check_out);
    SET @total = @dias * @precio;

    INSERT INTO Reservas(id_cliente, check_in, check_out, total)
    VALUES (@id_cliente, @check_in, @check_out, @total);

    DECLARE @id_reserva INT = SCOPE_IDENTITY();

    INSERT INTO DetalleReserva(id_reserva, id_habitacion, subtotal)
    VALUES (@id_reserva, @id_habitacion, @total);
END;

--Alerta de habitacion
CREATE OR ALTER TRIGGER trg_alerta_repeticion_reserva
ON DetalleReserva
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @id_cliente INT,
            @id_habitacion INT,
            @check_in DATE,
            @cantidad INT;

    -- Obtener los datos de la reserva recién insertada
SELECT @id_cliente = r.id_cliente,
       @id_habitacion = i.id_habitacion,
       @check_in = r.check_in
FROM inserted i
         JOIN Reservas r ON i.id_reserva = r.id_reserva;

-- Contar cuántas veces aparece esa combinación
SELECT @cantidad = COUNT(*)
FROM Reservas r
         JOIN DetalleReserva dr ON r.id_reserva = dr.id_reserva
WHERE r.id_cliente = @id_cliente
  AND dr.id_habitacion = @id_habitacion
  AND r.check_in = @check_in;

-- Si hay más de una => alerta
IF @cantidad > 1
BEGIN
INSERT INTO Alertas(tipo, descripcion)
VALUES ('Repetition', CONCAT('Cliente ', @id_cliente,
                             ' repitió la reserva de la habitación ', @id_habitacion,
                             ' para la fecha ', CONVERT(VARCHAR(10), @check_in, 120)));

-- Bloquea la segunda carga
RAISERROR('La habitación ya fue cargada para este cliente y fecha. Alerta generada.', 16, 1);
ROLLBACK TRANSACTION;
END
END;

--Alerta de mantenimiento
CREATE OR ALTER TRIGGER trg_alerta_mantenimiento
ON Habitaciones
AFTER UPDATE
                          AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @id_habitacion INT,
            @nuevo_estado NVARCHAR(20);

SELECT @id_habitacion = i.id_habitacion,
       @nuevo_estado = i.estado
FROM inserted i
         JOIN deleted d ON i.id_habitacion = d.id_habitacion;

-- Si el estado se cambió a FueraServicio
IF @nuevo_estado = 'FueraServicio'
BEGIN
        -- Inactivar la habitación automáticamente
UPDATE Habitaciones
SET estado = 'Inactiva'
WHERE id_habitacion = @id_habitacion;

-- Registrar alerta
INSERT INTO Alertas(tipo, descripcion)
VALUES ('Mantenimiento', CONCAT('Habitación ', @id_habitacion,
                                ' marcada como FueraServicio e inactivada automáticamente.'));
END
END;
GO


