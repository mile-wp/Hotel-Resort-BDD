-- ================================================
-- Crear base de datos TPO si no existe
-- ================================================
IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = N'TPO')
BEGIN
    CREATE DATABASE TPO;
END
GO

USE TPO;
GO

-- ================================================
-- TABLAS DEL SISTEMA HOTELERO
-- ================================================

IF OBJECT_ID('dbo.DetalleFactura', 'U') IS NOT NULL DROP TABLE DetalleFactura;
IF OBJECT_ID('dbo.Factura', 'U') IS NOT NULL DROP TABLE Factura;
IF OBJECT_ID('dbo.TarifaServicio', 'U') IS NOT NULL DROP TABLE TarifaServicio;
IF OBJECT_ID('dbo.ConsumoServicio', 'U') IS NOT NULL DROP TABLE ConsumoServicio;
IF OBJECT_ID('dbo.Servicio', 'U') IS NOT NULL DROP TABLE Servicio;
IF OBJECT_ID('dbo.TarifaHabitacion', 'U') IS NOT NULL DROP TABLE TarifaHabitacion;
IF OBJECT_ID('dbo.DetalleReserva', 'U') IS NOT NULL DROP TABLE DetalleReserva;
IF OBJECT_ID('dbo.Reserva', 'U') IS NOT NULL DROP TABLE Reserva;
IF OBJECT_ID('dbo.PrecioHabitacion', 'U') IS NOT NULL DROP TABLE PrecioHabitacion;
IF OBJECT_ID('dbo.Habitacion', 'U') IS NOT NULL DROP TABLE Habitacion;
IF OBJECT_ID('dbo.TipoHabitacion', 'U') IS NOT NULL DROP TABLE TipoHabitacion;
IF OBJECT_ID('dbo.Cliente', 'U') IS NOT NULL DROP TABLE Cliente;
GO


CREATE TABLE Cliente (
    IDCliente INT IDENTITY(1,1) PRIMARY KEY,
    Nombre NVARCHAR(50) NOT NULL,
    Apellido NVARCHAR(50) NOT NULL,
    DNI NVARCHAR(20),
    Pasaporte NVARCHAR(20),
    Email NVARCHAR(100),
    Telefono NVARCHAR(20),
    Estado NVARCHAR(20) CHECK (Estado IN ('Activo', 'Inactivo'))
);

CREATE TABLE TipoHabitacion (
    IDTipo INT IDENTITY(1,1) PRIMARY KEY,
    Descripcion NVARCHAR(50) CHECK (Descripcion IN ('Estándar', 'Superior', 'Suite')),
    Capacidad INT NOT NULL,
    CONSTRAINT CK_Tipo_Capacidad CHECK (
        (Descripcion = 'Estándar' AND Capacidad = 2) OR
        (Descripcion = 'Superior' AND Capacidad = 4) OR
        (Descripcion = 'Suite' AND Capacidad = 6)
    )
);

CREATE TABLE Habitacion (
    IDHabitacion INT IDENTITY(1,1) PRIMARY KEY,
    IDTipo INT NOT NULL,
    Piso INT CHECK (Piso BETWEEN 1 AND 12),
    Estado NVARCHAR(30) CHECK (Estado IN ('Activo', 'Fuera de Servicio')),
    Vista NVARCHAR(30) CHECK (Vista IN ('Jardín', 'Mar', 'Interior')),
    FOREIGN KEY (IDTipo) REFERENCES TipoHabitacion(IDTipo)
);

CREATE TABLE PrecioHabitacion (
    IDPrecioHabitacion INT IDENTITY(1,1) PRIMARY KEY,
    IDTipo INT NOT NULL,
    Temporada NVARCHAR(50) CHECK (Temporada IN ('Alta', 'Media', 'Baja')),
    PrecioPorNoche DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (IDTipo) REFERENCES TipoHabitacion(IDTipo)
);

CREATE TABLE Reserva (
    IDReserva INT IDENTITY(1,1) PRIMARY KEY,
    IDCliente INT NOT NULL,
    FechaReserva DATE NOT NULL,
    FOREIGN KEY (IDCliente) REFERENCES Cliente(IDCliente)
);

CREATE TABLE DetalleReserva (
    IDDetalleReserva INT IDENTITY(1,1) PRIMARY KEY,
    IDReserva INT NOT NULL,
    IDHabitacion INT NOT NULL,
    CheckIn DATE NOT NULL,
    CheckOut DATE NOT NULL,
    FOREIGN KEY (IDReserva) REFERENCES Reserva(IDReserva),
    FOREIGN KEY (IDHabitacion) REFERENCES Habitacion(IDHabitacion)
);

CREATE TABLE TarifaHabitacion (
    IDTarifaHabitacion INT IDENTITY(1,1) PRIMARY KEY,
    IDHabitacion INT NOT NULL,
    Subtotal DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (IDHabitacion) REFERENCES Habitacion(IDHabitacion)
);

CREATE TABLE Servicio (
    IDServicio INT IDENTITY(1,1) PRIMARY KEY,
    Tipo NVARCHAR(50) CHECK (Tipo IN ('Spa', 'Transporte', 'Cena')),
    CupoDiario INT CONSTRAINT CK_CupoDiario CHECK (CupoDiario = 3),
    Precio DECIMAL(10,2)
);

CREATE TABLE ConsumoServicio (
    IDConsumoServicio INT IDENTITY(1,1) PRIMARY KEY,
    IDServicio INT NOT NULL,
    IDHabitacion INT NOT NULL,
    Cantidad INT NOT NULL,
    FechaConsumo Date NOT NULL,
    FOREIGN KEY (IDServicio) REFERENCES Servicio(IDServicio),
    FOREIGN KEY (IDHabitacion) REFERENCES Habitacion(IDHabitacion)
);

CREATE TABLE TarifaServicio (
    IDTarifaServicio INT IDENTITY(1,1) PRIMARY KEY,
    IDHabitacion INT NOT NULL,
    Subtotal DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (IDHabitacion) REFERENCES Habitacion(IDHabitacion)
);

CREATE TABLE Factura (
    IDFactura INT IDENTITY(1,1) PRIMARY KEY,
    IDCliente INT NOT NULL,
    MetodoPago NVARCHAR(50) CHECK (MetodoPago IN ('Tarjeta', 'Efectivo', 'Transferencia')),
    Total DECIMAL(10,2),
    FOREIGN KEY (IDCliente) REFERENCES Cliente(IDCliente)
);

CREATE TABLE DetalleFactura (
    IDDetalleFactura INT IDENTITY(1,1) PRIMARY KEY,
    IDFactura INT NOT NULL,
    IDTarifaServicio INT,
    IDTarifaHabitacion INT,
    Total DECIMAL(10,2),
    FOREIGN KEY (IDFactura) REFERENCES Factura(IDFactura),
    FOREIGN KEY (IDTarifaServicio) REFERENCES TarifaServicio(IDTarifaServicio),
    FOREIGN KEY (IDTarifaHabitacion) REFERENCES TarifaHabitacion(IDTarifaHabitacion)
);
GO
