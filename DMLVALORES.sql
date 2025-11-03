-- =============================
-- PARA QUE SEA EJECUTABLE VARIAS VECES BORRO TODO E INSERTO NUEVAMENTE
-- =============================
DELETE FROM DetalleFactura;
DELETE FROM Factura;
DELETE FROM TarifaServicio;
DELETE FROM TarifaHabitacion;
DELETE FROM ConsumoServicio;
DELETE FROM Servicio;
DELETE FROM DetalleReserva;
DELETE FROM Reserva;
DELETE FROM PrecioHabitacion;
DELETE FROM Habitacion;
DELETE FROM TipoHabitacion;
DELETE FROM Cliente;
GO

-- =============================
-- CLIENTES
-- =============================
INSERT INTO Cliente (Nombre, Apellido, DNI, Pasaporte, Email, Telefono, Estado)
VALUES
('María', 'Pérez', '32165498', 'AA123456', 'maria@gmail.com', '1122334455', 'Activo'),
('Juan', 'López', '29874125', 'BB987654', 'juan@hotmail.com', '1144556677', 'Activo'),
('Sofía', 'Kim', '40987654', 'CC741852', 'sofia@outlook.com', '1133445566', 'Activo');
GO


-- =============================
-- TIPOS DE HABITACIÓN
-- =============================
INSERT INTO TipoHabitacion (Descripcion, Capacidad)
VALUES ('Estándar', 2), ('Superior', 4), ('Suite', 6);
GO


-- =============================
-- HABITACIONES
-- =============================
INSERT INTO Habitacion (IDTipo, Piso, Estado, Vista)
VALUES 
(1, 3, 'Activo', 'Mar'),
(1, 4, 'Activo', 'Interior'),
(2, 5, 'Activo', 'Jardín'),
(3, 7, 'Activo', 'Mar'),
(3, 8, 'Activo', 'Interior'),
(3, 9, 'Activo', 'Jardín');
GO


-- =============================
-- PRECIOS POR TEMPORADA
-- =============================
INSERT INTO PrecioHabitacion (IDTipo, Temporada, PrecioPorNoche)
VALUES 
(1, 'Alta', 9000),
(1, 'Media', 7000),
(1, 'Baja', 5000),
(2, 'Alta', 15000),
(2, 'Media', 12000),
(2, 'Baja', 9000),
(3, 'Alta', 22000),
(3, 'Media', 18000),
(3, 'Baja', 14000);
GO


-- =============================
-- RESERVAS (todas de meses anteriores)
-- =============================
INSERT INTO Reserva (IDCliente, FechaReserva)
VALUES
(1, '2025-08-01'),  -- María hab 1
(1, '2025-08-03'),  -- María hab 2
(2, '2025-09-01'),  -- Juan
(3, '2025-09-10'),  -- Sofía hab 1
(3, '2025-09-15'),  -- Sofía hab 2
(3, '2025-09-20');  -- Sofía hab 3
GO


-- =============================
-- DETALLE DE RESERVA
-- =============================
INSERT INTO DetalleReserva (IDReserva, IDHabitacion, CheckIn, CheckOut)
VALUES
(1, 1, '2025-08-05', '2025-08-08'),  -- María hab 1 (3 noches)
(2, 2, '2025-08-10', '2025-08-12'),  -- María hab 2 (2 noches)
(3, 3, '2025-09-05', '2025-09-08'),  -- Juan (3 noches)
(4, 4, '2025-09-12', '2025-09-15'),  -- Sofía hab 1 (3 noches)
(5, 5, '2025-09-16', '2025-09-18'),  -- Sofía hab 2 (2 noches)
(6, 6, '2025-09-20', '2025-09-23');  -- Sofía hab 3 (3 noches)
GO


-- =============================
-- SERVICIOS DISPONIBLES
-- =============================
INSERT INTO Servicio (Tipo, CupoDiario, Precio, Costo)
VALUES 
('Spa', 3, 2000, 1000),
('Transporte', 3, 3500, 2000),
('Cena', 3, 2500, 1500);
GO


-- =============================
-- CONSUMOS DE SERVICIO (ahora vinculados a DetalleReserva)
-- =============================
INSERT INTO ConsumoServicio (IDServicio, IDDetalleReserva, FechaConsumo, Cantidad)
VALUES
-- María hab 1
(2, 1, '2025-08-06', 2),  -- Transporte x2
(2, 1, '2025-08-07', 2),  -- Transporte x2 otro día
-- María hab 2
(1, 2, '2025-08-11', 2),  -- Spa 2 veces mismo día

-- Juan
(3, 3, '2025-09-06', 3),  -- Cena 3 noches

-- Sofía hab 1
(2, 4, '2025-09-13', 1),  -- Transporte
-- Sofía hab 2
(3, 5, '2025-09-16', 2),  -- Cena 2 veces
-- Sofía hab 3
(1, 6, '2025-09-21', 1);  -- Spa 1 vez
GO


-- =============================
-- TARIFA HABITACIÓN
-- =============================
INSERT INTO TarifaHabitacion (IDDetalleReserva, Subtotal)
VALUES 
(1, 21000), -- María hab 1 (3 noches estándar media)
(2, 14000), -- María hab 2 (2 noches estándar media)
(3, 36000), -- Juan (3 noches superior media)
(4, 54000), -- Sofía hab 1 (3 noches suite media)
(5, 36000), -- Sofía hab 2 (2 noches suite media)
(6, 54000); -- Sofía hab 3 (3 noches suite media)
GO


-- =============================
-- TARIFA SERVICIO
-- =============================
INSERT INTO TarifaServicio (IDDetalleReserva, Subtotal)
VALUES 
(1, 14000),  -- Transporte (2x3500 + 2x3500)
(2, 4000),   -- Spa (2x2000)
(3, 7500),   -- Cena (3x2500)
(4, 3500),   -- Transporte (1x3500)
(5, 5000),   -- Cena (2x2500)
(6, 2000);   -- Spa (1x2000)
GO


-- =============================
-- FACTURAS
-- =============================
INSERT INTO Factura (IDCliente, MetodoPago, Total)
VALUES
(1, 'Tarjeta', 39000),  -- María: (21000+14000) + (4000+14000) = 39000
(2, 'Efectivo', 43500), -- Juan
(3, 'Transferencia', 153500); -- Sofía: (54000+3500) + (36000+5000) + (54000+2000)
GO


-- =============================
-- DETALLE DE FACTURA
-- =============================
INSERT INTO DetalleFactura (IDFactura, IDTarifaServicio, IDTarifaHabitacion, Total)
VALUES
(1, 1, 1, 35000),  -- María hab 1
(1, 2, 2, 18000),  -- María hab 2
(2, 3, 3, 43500),  -- Juan
(3, 4, 4, 57500),  -- Sofía hab 1
(3, 5, 5, 41000),  -- Sofía hab 2
(3, 6, 6, 56000);  -- Sofía hab 3
GO
