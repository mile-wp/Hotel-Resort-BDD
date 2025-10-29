USE HotelResort;
GO

-- ====== CLIENTES ======
INSERT INTO Clientes (nombre, apellido, DNI, pasaporte, telefono, email, estado) VALUES ('Marta', 'Gonzalez', '46294103', 'ABC213465','1123765412', 'mgonzalez@gmail.com', 'Activo'),
('Juan', 'Pérez', '39854216', 'ARG254879', '1132548796', 'juanperez@hotmail.com', 'Activo'),
('Lucía', 'Fernández', '42156897', 'ARG879654', '1128459632', 'lucia.fernandez@gmail.com', 'Activo'),
('Carlos', 'Díaz', '37451236', 'ARG652147', '1145896321', 'cdiaz@yahoo.com', 'Activo'),
('Ana', 'Torres', '43569125', 'ARG475698', '1154789632', 'ana.torres@gmail.com', 'Activo'),
('Valentina', 'Romero', '45231478', 'ARG785412', '1169854721', 'valen.romero@hotmail.com', 'Activo'),
('Pedro', 'Gómez', '40697852', 'ARG986321', '1178963214', 'pgomez@gmail.com', 'Activo'),
('Martina', 'Suárez', '44512369', 'ARG124578', '1136985472', 'martina.suarez@gmail.com', 'Activo'),
('Tomás', 'Herrera', '45879631', 'ARG365874', '1125478963', 'tomas.herrera@hotmail.com', 'Activo'),
('Sofía', 'Acosta', '42789632', 'ARG654789', '1147852369', 'sofia.acosta@gmail.com', 'Activo'),
('Joaquín', 'Morales', '40325897', 'ARG987456', '1174523698', 'joaquin.morales@hotmail.com', 'Activo'),
('Emilia', 'Castro', '46875124', 'ARG357951', '1169857412', 'emilia.castro@gmail.com', 'Activo'),
('Ignacio', 'Vega', '43965412', 'ARG951357', '1132147856', 'nacho.vega@gmail.com', 'Activo'),
('Julieta', 'Navarro', '45678912', 'ARG159753', '1185247963', 'julieta.navarro@hotmail.com', 'Activo'),
('Mateo', 'Méndez', '41569874', 'ARG753159', '1158963247', 'mateo.mendez@gmail.com', 'Activo'),
('Camila', 'Rojas', '44213579', 'ARG264813', '1147852136', 'camila.rojas@gmail.com', 'Activo'),
('Agustina', 'Pérez', '40123564', 'ARG864213', '1132659874', 'agusperez@hotmail.com', 'Activo'),
('Franco', 'López', '45879654', 'ARG147852', '1152148796', 'franco.lopez@gmail.com', 'Activo'),
('Victoria', 'Ruiz', '42987531', 'ARG258741', '1187963214', 'victoria.ruiz@gmail.com', 'Activo'),
('Benjamín', 'Ramos', '44751236', 'ARG357159', '1178542639', 'benja.ramos@gmail.com', 'Activo'),
('Santiago', 'Ortiz', '41896532', 'ARG852369', '1136985471', 'santiago.ortiz@gmail.com', 'Activo'),
('Mía', 'Flores', '46321587', 'ARG654123', '1152369874', 'mia.flores@hotmail.com', 'Activo'),
('Lautaro', 'Silva', '44123658', 'ARG951654', '1163214785', 'lautaro.silva@gmail.com', 'Activo'),
('Catalina', 'Bravo', '45987412', 'ARG357486', '1185479632', 'catalina.bravo@gmail.com', 'Activo'),
('Emma', 'Cabrera', '43569812', 'ARG654951', '1147856329', 'emma.cabrera@hotmail.com', 'Activo'),
('Dylan', 'Soto', '42478591', 'ARG951248', '1132145896', 'dylan.soto@gmail.com', 'Activo'),
('Malena', 'Torres', '46258741', 'ARG753486', '1169854712', 'malena.torres@gmail.com', 'Activo'),
('Lucas', 'Benítez', '43125874', 'ARG159486', '1178546321', 'lucas.benitez@gmail.com', 'Activo'),
('Renata', 'Aguilar', '44987523', 'ARG258963', '1154786329', 'renata.aguilar@hotmail.com', 'Activo'),
('Thiago', 'Herrera', '42753698', 'ARG753951', '1132548963', 'thiago.herrera@gmail.com', 'Activo');



-- ====== RESERVAS ======
INSERT INTO Reservas (id_cliente, check_in, check_out, estado) VALUES ('1','2025-11-10', '', '')


-- ====== HABITACIONES ======
INSERT INTO Habitaciones (numero, tipo, estado, precio_noche) VALUES (101, 'Individual', 'Disponible', 800),
(102, 'Doble', 'Ocupada', 1200),
(103, 'Suite', 'Disponible', 2500),
(104, 'Doble', 'Disponible', 1300),
(105, 'Individual', 'Ocupada', 850),
(106, 'Suite', 'Disponible', 2700),
(107, 'Doble', 'Disponible', 1250),
(108, 'Individual', 'Disponible', 900),
(109, 'Suite', 'Ocupada', 2600),
(110, 'Doble', 'Disponible', 1400),
(111, 'Individual', 'Disponible', 750),
(112, 'Doble', 'Ocupada', 1350),
(113, 'Suite', 'Disponible', 2300),
(114, 'Doble', 'Disponible', 1450),
(115, 'Individual', 'Disponible', 780),
(116, 'Suite', 'Ocupada', 2900),
(117, 'Doble', 'Disponible', 1500),
(118, 'Suite', 'Disponible', 3100),
(119, 'Individual', 'Ocupada', 870),
(120, 'Doble', 'Disponible', 1320);



-- ====== TARIFAS ======
INSERT INTO Tarifas (id_temporada, tipo_habitacion, precio) VALUES 
(1, 'Suite', 450.00),
(1, 'Doble', 350.00),
(1, 'Simple', 250.00),
(2, 'Suite', 380.00),
(2, 'Doble', 300.00),
(2, 'Simple', 220.00),
(3, 'Suite', 300.00),
(3, 'Doble', 250.00),
(3, 'Simple', 180.00);
GO

-- ====== SERVICIOS ======
INSERT INTO Servicios (nombre_servicio, precio) VALUES 
('Desayuno buffet', 15),
('Almuerzo ejecutivo', 25),
('Cena gourmet', 35),
('Spa relajante', 50),
('Gimnasio', 10),
('Piscina climatizada', 20),
('Transporte al aeropuerto', 30),
('Lavandería', 12),
('Masaje descontracturante', 45),
('Tour guiado por la ciudad', 40);





-- ====== DETALLE DE RESERVAS ======
INSERT INTO DetalleReserva (id_reserva, id_habitacion, id_servicio, cantidad) VALUES
(1, 101, 1, 2),
(1, 101, 5, 1),
(2, 104, 2, 2),
(3, 103, 3, 2),
(4, 107, 4, 1),
(5, 105, 1, 2),
(6, 109, 7, 1),
(7, 108, 8, 1),
(8, 110, 2, 2),
(9, 111, 6, 1),
(10, 112, 1, 2),
(11, 114, 4, 1),
(12, 116, 3, 2),
(13, 117, 5, 1),
(14, 118, 1, 2),
(15, 120, 7, 1),
(16, 119, 8, 1),
(17, 115, 2, 2),
(18, 113, 3, 2),
(19, 106, 9, 1);



-- ====== ALERTAS (ejemplo inicial) ======
INSERT INTO Alertas (tipo, descripcion)
VALUES
('Info', 'Base de datos inicial cargada correctamente.');
GO

-- ====== 🔍 CONSULTAS DE PRUEBA ======

-- 1️⃣ Ver todos los clientes y su estado
SELECT * FROM Clientes;

-- 2️⃣ Ver habitaciones con su estado actual
SELECT * FROM Habitaciones;

-- 3️⃣ Consultar temporadas y sus rangos de fechas
SELECT * FROM Temporadas;

-- 4️⃣ Ver tarifas por tipo de habitación
SELECT * FROM Tarifas;

-- 5️⃣ Consultar servicios y su margen calculado (usa la función)
SELECT 
    id_servicio,
    descripcion,
    costo,
    precio,
    dbo.fn_margen_servicio(id_servicio) AS Margen
FROM Servicios;

-- 6️⃣ Consultar reservas con detalle
SELECT 
    r.id_reserva,
    c.nombre AS Cliente,
    h.tipo AS Habitacion,
    r.check_in,
    r.check_out,
    dr.subtotal
FROM Reservas r
JOIN Clientes c ON r.id_cliente = c.id_cliente
JOIN DetalleReserva dr ON r.id_reserva = dr.id_reserva
JOIN Habitaciones h ON dr.id_habitacion = h.id_habitacion;

-- 7️⃣ Consultar alertas generadas (por triggers o errores)
SELECT * FROM Alertas ORDER BY fecha DESC;

-- 8️⃣ Consultar vista de habitaciones repetidas (debería estar vacía si todo está bien)
SELECT * FROM vw_habitaciones_repetidas;

-- 9️⃣ Probar función manualmente
SELECT dbo.fn_margen_servicio(2) AS Margen_Spa;

-- 🔟 Ejecutar procedimiento de ejemplo (reserva válida)
EXEC sp_registrar_reserva 
    @id_cliente = 1,
    @id_habitacion = 2,
    @check_in = '2025-12-26',
    @check_out = '2025-12-28';

-- Luego verificamos:
SELECT * FROM Reservas;
SELECT * FROM DetalleReserva;
SELECT * FROM Alertas ORDER BY fecha DESC;

-- 11️⃣ Probar error de cliente inactivo (debería lanzar alerta y error)
-- EXEC sp_registrar_reserva 3, 1, '2025-12-22', '2025-12-27';

-- 12️⃣ Probar reserva repetida (mismo cliente, habitación y fecha)
-- EXEC sp_registrar_reserva 1, 1, '2025-12-20', '2025-12-25';

-- 13️⃣ Verificar alerta de mantenimiento
-- UPDATE Habitaciones SET estado = 'FueraServicio' WHERE id_habitacion = 5;
-- SELECT * FROM Alertas ORDER BY fecha DESC;
GO
