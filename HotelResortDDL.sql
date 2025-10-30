-- Usar la base de datos HotelResort
USE HotelResort;
GO

-- ========================================
-- TABLA: Cliente
-- ========================================
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='Cliente' AND xtype='U')
BEGIN
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
END
GO

-- ========================================
-- TABLA: TipoHabitacion
-- ========================================
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='TipoHabitacion' AND xtype='U')
BEGIN
    CREATE TABLE TipoHabitacion (
        IDTipo INT IDENTITY(1,1) PRIMARY KEY,
        Descripcion NVARCHAR(50) CHECK (Descripcion IN ('Estándar', 'Superior', 'Suite')),
        Capacidad INT NOT NULL
    );
END
GO

-- ========================================
-- TABLA: Habitacion
-- ========================================
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='Habitacion' AND xtype='U')
BEGIN
    CREATE TABLE Habitacion (
        IDHabitacion INT IDENTITY(1,1) PRIMARY KEY,
        IDTipo INT NOT NULL,
        Piso INT,
        Estado NVARCHAR(30) CHECK (Estado IN ('Activo', 'Fuera de Servicio')),
        Vista NVARCHAR(30) CHECK (Vista IN ('Jardín', 'Mar', 'Interior')),
        FOREIGN KEY (IDTipo) REFERENCES TipoHabitacion(IDTipo)
    );
END
GO

-- ========================================
-- TABLA: PrecioHabitacion
-- ========================================
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='PrecioHabitacion' AND xtype='U')
BEGIN
    CREATE TABLE PrecioHabitacion (
        IDPrecioHabitacion INT IDENTITY(1,1) PRIMARY KEY,
        IDTipo INT NOT NULL,
        Temporada NVARCHAR(50) CHECK (Temporada IN ('Alta', 'Media', 'Baja')),
        PrecioPorNoche DECIMAL(10,2) NOT NULL,
        FOREIGN KEY (IDTipo) REFERENCES TipoHabitacion(IDTipo)
    );
END
GO

-- ========================================
-- TABLA: Reserva
-- ========================================
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='Reserva' AND xtype='U')
BEGIN
    CREATE TABLE Reserva (
        IDReserva INT IDENTITY(1,1) PRIMARY KEY,
        IDCliente INT NOT NULL,
        FechaReserva DATE NOT NULL,
        FOREIGN KEY (IDCliente) REFERENCES Cliente(IDCliente)
    );
END
GO

-- ========================================
-- TABLA: DetalleReserva
-- ========================================
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='DetalleReserva' AND xtype='U')
BEGIN
    CREATE TABLE DetalleReserva (
        IDDetalleReserva INT IDENTITY(1,1) PRIMARY KEY,
        IDReserva INT NOT NULL,
        IDHabitacion INT NOT NULL,
        CheckIn DATE NOT NULL,
        CheckOut DATE NOT NULL,
        FOREIGN KEY (IDReserva) REFERENCES Reserva(IDReserva),
        FOREIGN KEY (IDHabitacion) REFERENCES Habitacion(IDHabitacion)
    );
END
GO

-- ========================================
-- TABLA: TarifaHabitacion
-- ========================================
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='TarifaHabitacion' AND xtype='U')
BEGIN
    CREATE TABLE TarifaHabitacion (
        IDTarifaHabitacion INT IDENTITY(1,1) PRIMARY KEY,
        IDHabitacion INT NOT NULL,
        Subtotal DECIMAL(10,2) NOT NULL,
        FOREIGN KEY (IDHabitacion) REFERENCES Habitacion(IDHabitacion)
    );
END
GO

-- ========================================
-- TABLA: Servicio
-- ========================================
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='Servicio' AND xtype='U')
BEGIN
    CREATE TABLE Servicio (
        IDServicio INT IDENTITY(1,1) PRIMARY KEY,
        Tipo NVARCHAR(50) CHECK (Tipo IN ('Spa', 'Transporte', 'Cena')),
        CupoDiario INT,
        Precio DECIMAL(10,2)
    );
END
GO

-- ========================================
-- TABLA: ConsumoServicio
-- ========================================
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='ConsumoServicio' AND xtype='U')
BEGIN
    CREATE TABLE ConsumoServicio (
        IDConsumoServicio INT IDENTITY(1,1) PRIMARY KEY,
        IDServicio INT NOT NULL,
        IDHabitacion INT NOT NULL,
        Cantidad INT NOT NULL,
        FOREIGN KEY (IDServicio) REFERENCES Servicio(IDServicio),
        FOREIGN KEY (IDHabitacion) REFERENCES Habitacion(IDHabitacion)
    );
END
GO

-- ========================================
-- TABLA: TarifaServicio
-- ========================================
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='TarifaServicio' AND xtype='U')
BEGIN
    CREATE TABLE TarifaServicio (
        IDTarifaServicio INT IDENTITY(1,1) PRIMARY KEY,
        IDHabitacion INT NOT NULL,
        Subtotal DECIMAL(10,2) NOT NULL,
        FOREIGN KEY (IDHabitacion) REFERENCES Habitacion(IDHabitacion)
    );
END
GO

-- ========================================
-- TABLA: Factura
-- ========================================
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='Factura' AND xtype='U')
BEGIN
    CREATE TABLE Factura (
        IDFactura INT IDENTITY(1,1) PRIMARY KEY,
        IDCliente INT NOT NULL,
        MetodoPago NVARCHAR(50) CHECK (MetodoPago IN ('Tarjeta', 'Efectivo', 'Transferencia')),
        Total DECIMAL(10,2),
        FOREIGN KEY (IDCliente) REFERENCES Cliente(IDCliente)
    );
END
GO

-- ========================================
-- TABLA: DetalleFactura
-- ========================================
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='DetalleFactura' AND xtype='U')
BEGIN
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
END
GO
