create database ProyectoBD_VictorMontero_JeanCarlosUrbina_ManuelAmores
GO--Crear la base de datos
USE ProyectoBD_VictorMontero_JeanCarlosUrbina_ManuelAmores
GO
					--Valores default

--Default del estado de la cuenta por cobrar
CREATE DEFAULT DEstado AS 'Vigente'
Go


--Default de la moneda
CREATE DEFAULT DMoneda AS '₡'
GO

--Default del monto 
CREATE DEFAULT DMonto AS 0
GO

--Regla para el correo
CREATE RULE reglaCorreo AS (@correo like ('[a-Z0-9]%@[a-Z]%.[a-Z]%'))
GO
EXEC sp_addtype 'tipoCorreo','varchar (50)', 'not null' 
GO
EXEC sp_bindrule 'reglaCorreo','tipoCorreo' 
GO

--Regla para la moneda que se desea usar
CREATE RULE reglaMoneda AS (@tipo in ('₡','$','€'))
GO
EXEC sp_addtype 'tipoMoneda','char(1)', 'not null'
GO
EXEC sp_bindrule 'reglaMoneda','tipoMoneda'
GO
EXEC sp_bindefault 'DMoneda','tipoMoneda'
GO

--Regla para el estado de la cuenta por cobrar
CREATE RULE reglaEstado AS (@tipo in ('Vencida','Vigente','Cancelada'))
GO
EXEC sp_addtype 'tipoEstado','varchar(10)', 'not null'
GO
EXEC sp_bindrule 'reglaEstado','tipoEstado'  
GO
EXEC sp_bindefault 'DEstado','tipoEstado'
GO



--Regla para el tipo de factura
CREATE RULE reglaFactura AS (@factura in ('Credito','Contado'))
GO
EXEC sp_addtype 'tipoFactura','varchar(7)', 'not null' 
GO
EXEC sp_bindrule 'reglaFactura','tipoFactura'  
GO


--Regla para el tipo de la nota
CREATE RULE reglaTipo AS (@estado in ('Credito','Debito'))
GO
EXEC sp_addtype 'tTipo','varchar(7)', 'not null' 
GO
EXEC sp_bindrule 'reglaTipo','tTipo'  
GO


--Regla para el id del cliente
CREATE RULE reglaCedula AS (@cedula like ('[1-7]-[0-9][0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]'))
GO
EXEC sp_addtype 'tipoCedula','char(11)', 'not null' 
GO
EXEC sp_bindrule 'reglaCedula','tipoCedula'
GO

--Regla para el telefono del cliente
CREATE RULE reglaTelefono AS 
(@telefono like '[0-9][0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]')
or
(@telefono like '([0-9][0-9][0-9]) [0-9][0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]')
GO
EXEC sp_addtype 'tipoTelefono', 'varchar (17)', 'not null'	--ASIGNAR EL TIPO DEL DATO
GO
EXEC sp_bindrule 'reglaTelefono','tipoTelefono' --ASOCIAR LA REGLA A LA VARIABLE 
GO

--Regla para la forma de pago
CREATE RULE reglaPago AS (@pago in ('Cheque','Contado','Tarjeta','Transferencia electronica'))
GO
EXEC sp_addtype 'tipoPago','varchar(30)', 'not null' 
GO
EXEC sp_bindrule 'reglaPago','tipoPago'  
GO


--Tabla para las provincias
create table Provincia(
	idProvincia INT IDENTITY (1,1) primary key not null,
	nombre varchar(30) not null
);

--Tabla para los cantones
create table Canton(
	idCanton INT IDENTITY (1,1) primary key not null,
	idProvincia INT FOREIGN KEY REFERENCES Provincia not null,
	nombre varchar(30) not null
);

--Tabla para los distritos
create table Distrito(
	idDistrito INT IDENTITY (1,1) primary key not null,
	idCanton INT FOREIGN KEY REFERENCES Canton not null,
	nombre varchar(30) not null
);

--Tabla para los clientes
create table Cliente(
		idCliente tipoCedula PRIMARY KEY,
		direccionExacta varchar(200) not null,
		nombre varchar(100) not null,
		idDistrito int FOREIGN KEY REFERENCES Distrito not null,
		usuarioCreacion varchar(100),
		usuarioModificacion varchar(100),
		fechaModificacion datetime,
		fechaCreacion datetime
	);
ALTER TABLE Cliente ADD UNIQUE (idCliente)

--Tabla para los clientes
create table Correo( 
	idCliente tipoCedula PRIMARY KEY FOREIGN KEY REFERENCES Cliente,
	correo tipoCorreo
);

--Tabla para los telefonos
create table telefono(	 
idCliente tipoCedula PRIMARY KEY FOREIGN KEY REFERENCES Cliente,
telefono tipoTelefono
);


--Tabla para las sucursales
create table Sucursal(

idSucursal char(4) PRIMARY KEY NOT NULL,
nombre varchar(50) not null,
descripcion varchar(200) not null

);
ALTER TABLE Sucursal ADD UNIQUE (idSucursal)
create table cuentaPorCobrar(
    --Keys
    idCuentaPorCobrar int Identity(1,1) PRIMARY KEY not null,
    idCliente tipoCedula FOREIGN KEY REFERENCES Cliente not null,

    --Demás Atributos
    condicionVenta tipoFactura,
    fecha date not null,
    formaPago tipoPago,
    saldo float not null,
    plazo TinyInt not null,
    Estado tipoEstado,
    moneda tipoMoneda,
    tipoCambio float not null,
    fechaDeVencimiento date,

    --Auditoria
    usuarioCreacion varchar(100) ,
    usuarioModificacion varchar(100) ,
    fechaModificacion datetime ,
    fechaCreacion datetime 
);



--Tabla para las facturas
create table Factura(

idSucursal char(4) Foreign key references Sucursal not null,
idFacturaD int IDENTITY (1,1) primary key not null,
idCliente tipoCedula foreign key references Cliente,
montoDescuento float not null,
montoNeto float not null,
montoImpuesto float not null,
montoBruto float not null,
fecha date not null,

);
ALTER TABLE Factura ADD UNIQUE (idFacturaD)


--Crear tabla de facturas de credito
create table FacturasCredito(

idSucursal char(4) Foreign key references Sucursal not null,
idCliente tipoCedula foreign key references Cliente,
montoDescuento float not null,
montoNeto float not null,
montoImpuesto float not null,
montoBruto float not null,
fecha date not null,
idFacturaC int identity(1,1) PRIMARY KEY not null,
saldo float not null,
plazo TinyInt not null,
fechaVencimiento date not null,
idCuentaPorCobrar int foreign KEY references cuentaPorCobrar not null,
estado tipoEstado 
);


--Crear tabla de auditoria
create table Auditoria (

idAuditoria int identity(1,1) PRIMARY KEY NOT NULL,
idFacturaC int Foreign Key references FacturasCredito not null,
usuarioCreacion varchar(100) not null,
usuarioModificacion varchar(100) not null,
fechaModificacion datetime not null,
fechaCreacion datetime not null	

);




--Crear tabla de abonos
create table Abono(
idAbono char(4) PRIMARY KEY not null,
formaPago tipoPago,
idCliente tipoCedula FOREIGN KEY REFERENCES Cliente,
idFacturaC int references facturasCredito,
fecha date not null,
monto float not null,

--Auditoria
usuarioCreacion varchar(100) ,
usuarioModificacion varchar(100),
fechaModificacion datetime ,
fechaCreacion datetime
);
ALTER TABLE Abono ADD UNIQUE (idAbono)

--Crear tabla de abonos
create table Nota(
    --Keys
    idNota int Identity(1,1) PRIMARY KEY not null,
    idFacturaC int FOREIGN KEY REFERENCES FacturasCredito not null,

    --Demás Atributos
    tipo tTipo,
    fecha date not null,
    descripcion varchar(200) not null,
    monto float not null,

    --Auditoria
    usuarioCreacion varchar(100),
    usuarioModificacion varchar(100),
    fechaModificacion datetime,
    fechaCreacion datetime 
);






