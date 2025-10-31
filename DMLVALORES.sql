--Insertar valores
-- =============================
-- CARGA DE DATOS CON TODAS LAS RESERVAS FINALIZADAS
-- =============================

-- Clientes
INSERT INTO Cliente (Nombre, Apellido, DNI, Pasaporte, Email, Telefono, Estado) VALUES ('María', 'Gómez', '30111222', 'AA123456', 'maria.gomez@mail.com', '1111-1111', 'Inactivo'),
('Juan', 'Pérez', '28999888', 'BB654321', 'juan.perez@mail.com', '2222-2222', 'Inactivo'),
('Lucía', 'Martínez', '40555444', 'CC987654', 'lucia.martinez@mail.com', '3333-3333', 'Inactivo');

-- Tipos de habitación
INSERT INTO TipoHabitacion (Descripcion, Capacidad) VALUES ('Estándar', 2),
('Superior', 4),
('Suite', 6);

-- Habitaciones
INSERT INTO Habitacion (IDTipo, Piso, Estado, Vista) VALUES (1, 3, 'Activo', 'Jardín'),
(2, 5, 'Activo', 'Mar'),
(3, 8, 'Activo', 'Interior');

-- Precio por noche según temporada
INSERT INTO PrecioHabitacion (IDTipo, Temporada, PrecioPorNoche) VALUES (1, 'Media', 10000.00),
(2, 'Media', 16000.00),
(3, 'Media', 25000.00);

-- Reservas
INSERT INTO Reserva (IDCliente, FechaReserva) VALUES (1, '2025-03-10'),
(2, '2025-03-15'),
(3, '2025-08-05');

-- Detalle de reservas: check-in/check-out (todas finalizadas)
INSERT INTO DetalleReserva (IDReserva, IDHabitacion, CheckIn, CheckOut) VALUES (1, 1, '2025-03-20', '2025-03-25'),  -- María
(2, 2, '2025-03-22', '2025-03-28'),  -- Juan
(3, 3, '2025-08-10', '2025-08-15');  -- Lucía

-- Tarifas de habitación
INSERT INTO TarifaHabitacion (IDHabitacion, Subtotal) VALUES (1, 50000.00),
(2, 80000.00),
(3, 75000.00);

-- Servicios disponibles
INSERT INTO Servicio (Tipo, CupoDiario, Precio) VALUES ('Spa', 3, 5000.00),
('Transporte', 3, 3000.00),
('Cena', 3, 7000.00);

-- Consumos de servicios
INSERT INTO ConsumoServicio (IDServicio, IDHabitacion, Cantidad, FechaConsumo) VALUES (1, 1, 1, '2025-06-12'),  -- María usó Spa
(2, 1, 1, '2026-12-1'),  -- María usó Transporte
(3, 2, 2, '2025-03-4'),  -- Juan tuvo 2 cenas
(1, 3, 1, '2025-09-11'),  -- Lucía usó Spa
(3, 3, 1, '2026-12-2');  -- Lucía tuvo 1 cena

-- Tarifas de servicio
INSERT INTO TarifaServicio (IDHabitacion, Subtotal) VALUES (1, 8000.00),
(2, 14000.00),
(3, 12000.00);

-- Facturas (todas con total ya definido)
INSERT INTO Factura (IDCliente, MetodoPago, Total) VALUES (1, 'Tarjeta', 58000.00),
(2, 'Efectivo', 94000.00),
(3, 'Transferencia', 87000.00);

-- Detalle de facturas
INSERT INTO DetalleFactura (IDFactura, IDTarifaServicio, IDTarifaHabitacion, Total) VALUES (1, 1, 1, 58000.00),
(2, 2, 2, 94000.00),
(3, 3, 3, 87000.00);