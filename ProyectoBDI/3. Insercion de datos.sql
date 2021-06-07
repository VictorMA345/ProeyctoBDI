use ProyectoBD_VictorMontero_JeanCarlosUrbina_ManuelAmores
go
--Crear provincias
Insert into Provincia (nombre)
Values 
('Alajuela'),
('Heredia'),
('Cartago'),
('Puntarenas'),
('Limón'),
('Guanacaste'),
('San José');


--Crear cantones
Insert into Canton(idProvincia,nombre)
Values
(1,'San Ramon'),
(1,'San Carlos'),
(1,'Palmares'),
(2,'Flores'),
(2,'Belen'),
(2,'Santa Bárbara'),
(3,'Paraíso'),
(3,'La Unión'),
(3,'Oreamuno'),
(4,'Garabito'),
(4,'Esparza'),
(5,'Pococi'),
(5,'Guácimo'),
(6,'Liberia'),
(6,'Nandayure'),
(6,'Nicoya'),
(7,'Escazú'),
(7,'Goicoechea'),
(7,'Desamparados');

--Crear distritos
Insert into Distrito(idCanton,nombre)
Values 
(1,'San Juan'),
(1,'San Isidro'),
(2,'Santa Clara'),
(2,'La fortuna'),
(3,'Zaragoza'),
(3,'La Granja'),
(4,'San Joaquin'),
(4,'Llorente'),
(5,'San Antonio'),
(6,'Purabá'),
(6,'Santo Domingo'),
(7,'Cachí'),
(7,'Orosi'),
(8,'Tres Rios'),
(8,'San Diego'),
(9,'Cipreses'),
(9,'Santa Rosa'),
(10,'Herradura'),
(10,'Playa Hermosa'),
(11,'Caldera'),
(11,'Macacona'),
(12,'Guapiles'),
(12,'Cariari'),
(13,'Guacimo'),
(13,'Rio Jimenez'),
(14,'Liberia'),
(14,'Cañas Dulces'),
(15,'Carmona'),
(15,'Santa Rita'),
(16,'Nosara'),
(16,'Sámara'),
(17,'Escazu'),
(17,'San Antonio'),
(18,'Guadalupe'),
(18,'Purral'),
(19,'Damas'),
(19,'San Cristobal');


--Creación de Clientes
insert into Cliente(idCliente,nombre,direccionExacta,idDistrito)
values
('2-0818-0369','Victor Julio Montero Alfaro','3 km noroeste de la Ermita de San Juan',1),
('1-0716-0231','Juan Diego Solorzano Matarrita','1 km oeste de la corte',32),
('1-0122-0889','Carlos Salas Angulo','3 km este del hospital',36),
('7-0331-0887','Alejandra Gonzales Chaves','400m sur de la escuela',24),
('6-0113-0976','Rosa Maria Vega García','Avenida 50, 100m de la playa',18),
('5-0881-0554','Gabriel Rodriguez Espinoza','1km sureste de la universidad',26),
('3-0998-0827','Erick Sanchez Matamoros','125m al oeste de la parada',13),
('4-0665-0153','Ernesto Mondragon Delgado','100m este de la parada de taxis',14);


--Creacion de correos
Insert into Correo (idCliente,Correo)
Values
('2-0818-0369','VictorJulio345@gmail.com'),
('1-0716-0231','JuanDS2323@gmail.com'),
('1-0122-0889','CarlosAngulo776@gmail.com'),
('7-0331-0887','AleGonzales987@gmail.com'),
('6-0113-0976','RoseMary654@hotmail.com'),
('5-0881-0554','Gabo369@yahoo.com'),
('3-0998-0827','ErickMD123@gmail.com'),
('4-0665-0153','ErnestoDelgado@gmail.com');



--Creacion de telefonos
Insert into telefono(idCliente,telefono)
Values
('1-0716-0231','7865-1234'),
('2-0818-0369','6280-5962'),
('1-0122-0889','6754-1242'),
('7-0331-0887','8765-1234'),
('6-0113-0976','8765-1532'),
('5-0881-0554','8876-1775'),
('3-0998-0827','8234-9876'),
('4-0665-0153','6541-2980');



--Creación de Sucursales
Insert into Sucursal(idSucursal,nombre,descripcion)
Values
('1111','Pavalense','Sucursal ubicada en Pavas, cuenta con mas de 15000 productos'),
('2222','Chepeña','Sucursal ubicada en San Jóse, cuenta con mas de 15000 productos'),
('3333','Moncheña','Sucursal ubicada en San Ramón, cuenta con mas de 15000 productos'),
('4444','Sancarleña','Sucursal ubicada en San Carlos, cuenta con mas de 15000 productos'),
('5555','Sanromena','Sucursal ubicada en Santa Rosa, cuenta con mas de 15000 productos');




--creacion de cuentas por cobrar 
Insert into cuentaPorCobrar(idCliente,condicionVenta,fecha,formaPago,saldo,plazo,moneda,fechaDeVencimiento,tipoCambio)
Values
('1-0716-0231','Credito','2021-02-02','Tarjeta',500000.0,3,'₡','2021-05-02',1.0),
('2-0818-0369','Credito','2021-03-07','Tarjeta',750000.0,6,'₡','2021-09-07',1.0),
('2-0818-0369','Credito','2021-03-20','Tarjeta',800000.0,5,'₡','2021-08-20',1.0),
('1-0122-0889','Credito','2021-08-25','Contado',3000.0,4,'$','2021-12-25',616.35),
('7-0331-0887','Contado','2021-06-13','Transferencia Electronica',400000.0,2,'₡','2021-08-13',1.0),
('6-0113-0976','Credito','2021-10-09','Cheque',1000.0,4,'€','2022-02-09',748.630),
('5-0881-0554','Contado','2021-05-18','Tarjeta',750.0,3,'€','2021-08-18',748.63),
('3-0998-0827','Credito','2021-06-06','Contado',600000.0,4,'₡','2021-10-06',1.0),
('3-0998-0827','Contado','2021-01-01','Cheque',500.0,7,'$','2021-08-01',616.35),
('4-0665-0153','Credito','2021-04-04','Transferencia Electronica',250000.0,4,'₡','2021-08-04',1.0);



--Creación de factura de crédito
DBCC CHECKIDENT ( FacturasCredito, RESEED, 1 )
insert into FacturasCredito (idSucursal,idCliente,montoDescuento,montoImpuesto,montoNeto,montoBruto,fecha,saldo,plazo,fechaVencimiento,idCuentaPorCobrar)
Values
('1111','3-0998-0827',25000.0,12500.0,125000.0,137500.0,'2021-01-01',137500.0,3,'2021-04-01',9),
('1111','3-0998-0827',30000.0,15000.0,90000.0,105000.0,'2021-02-01',105000.0,2,'2021-04-01',9),
('2222','4-0665-0153',15000.0,15000.0,90000.0,90000.0,'2021-04-10',90000.0,4,'2021-06-10',10),
('2222','6-0113-0976',20000.0,20000.0,160000.0,160000.0,'2021-11-19',160000.0,2,'2022-01-19',6),
('3333','1-0716-0231',75000.0,60000.0,200000.0,215000.0,'2021-04-05',215000.0,3,'2021-07-05',1),
('4444','5-0881-0554',100000.0,25000.0,200000.0,275000,'2021-06-12',275000,2,'2021-08-12',7),
('4444','1-0122-0889',55000.0,11000.0,110000.0,154000.0,'2021-09-20',154000.0,2,'2021-11-20',4),
('5555','7-0331-0887',40000.0,20000.0,120000.0,140000.0,'2021-07-07',140000.0,1,'2021-08-07',5);


--Creación de abonos
Insert into Abono(idAbono,formaPago,idCliente,fecha,monto,idFacturaC)
Values
('1111','Contado','3-0998-0827','2021-01-01', 10000.45,1),
('1112','Transferencia electronica','5-0881-0554','2021-04-25', 11234.12,6),
('2222','Tarjeta','4-0665-0153','2021-12-22', 5000.21,3),
('3333','Cheque','1-0716-0231','2021-04-01', 8321.33,5),
('4444','Transferencia electronica','7-0331-0887','2021-08-12', 12900.86,8),
('5555','Transferencia electronica','5-0881-0554','2021-06-22', 11234.12,6),
('6666','Contado','3-0998-0827','2021-03-01', 6000.45,2),
('7777','Tarjeta','4-0665-0153','2021-04-22', 13456.21,3),
('8888','Cheque','1-0122-0889','2021-09-30', 13475.33,7),
('9999','Transferencia electronica','6-0113-0976','2021-12-11', 12900.86,4);                 


--Creación de Notas	
 Insert into Nota(idFacturaC,tipo,fecha,descripcion,monto)
 Values
(1,'Debito','2021-03-14','Precio erréneo del producto',10000),
(1,'Credito','2021-02-17','Transporte',7500),
(2,'Debito','2021-03-09','Transporte, el cliente no necesitó transporte',12500),
(2,'Credito','2021-03-07','Precio erróneo del producto',15000),
(3,'Credito','2021-05-05','Agregación de un producto',8500),
(4,'Credito','2021-12-15','Adición de un servicio',9000),
(5,'Credito','2021-05-20','Agregación de un producto',12000),
(6,'Credito','2021-06-13','Precio erróneo',5000),
(7,'Debito','2021-10-23','Devolución de un articulo',10000),
(8,'Debito','2021-07-20','Garantía',20000);




--Creación de Facturas de contado
insert into Factura(idSucursal,idCliente,montoDescuento,montoNeto,montoImpuesto,montoBruto,fecha)
Values
('1111','2-0818-0369',12000,129250,16250,125000,'2021-03-20'),
('2222','3-0998-0827',8000,218000,26000,200000,'2021-02-20'),
('5555','7-0331-0887',2000,111000,13000,100000,'2021-01-01'),
('4444','1-0122-0889',1000,10300,1300,10000,'2021-01-01');
