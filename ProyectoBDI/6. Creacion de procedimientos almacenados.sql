	Use ProyectoBD_VictorMontero_JeanCarlosUrbina_ManuelAmores
	go
			--Procedimientos Almacenados
	--Procedimiento Almacenado para crear un Cliente con todos sus atributos 
	create procedure IngresarCliente
	@idCliente tipoCedula,
	@nombre varchar(100),
	@direccionExacta varchar(200),
	@correo tipoCorreo,
	@telefono tipoTelefono,
	@nombreDistrito varchar(30),
	@nombreCanton varchar(30),
	@nombreProvincia varchar(30)
	as 
	Declare @idProvincia int;
	Declare @idCanton int;
	Declare @idDistrito int;
	begin try
	set @idProvincia = (Select p.idProvincia from Provincia as p where @nombreProvincia = p.nombre)
	if (@idProvincia is null) --no existe una provincia
		return -3
	if ((Select c.idCanton from Canton  as c where @nombreCanton = c.nombre) is null)
	begin
		insert into Canton(idProvincia,nombre) values (@idProvincia,@nombreCanton);
		set @idCanton = (Select c.idCanton from Canton  as c where @nombreCanton = c.nombre);
	end
	else
		set @idCanton = (Select c.idCanton from Canton  as c where @nombreCanton = c.nombre)
	if((Select d.idDistrito from Distrito as d where @nombreDistrito = d.nombre) Is null)
	begin
		insert into Distrito(idCanton,nombre) values (@idCanton,@nombreDistrito);
		set @idDistrito = (Select d.idDistrito from Distrito as d where @nombreDistrito = d.nombre);
	end
	else
		set @idDistrito = (Select d.idDistrito from Distrito as d where @nombreDistrito = d.nombre);
	Insert Into Cliente (nombre,idCliente,direccionExacta,idDistrito)
	Values (@nombre,@idCliente,@direccionExacta,@idDistrito);
	Insert into Correo (idCliente,correo)
	values (@idCliente,@correo);
	Insert into telefono(idCliente,telefono)
	values (@idCliente,@telefono);

	print 'Se ha Insertado con éxito el Cliente'   
	end try
	begin catch
	if (ERROR_NUMBER() = 2627) --irrespeto de clave unica
		return -1
	if (ERROR_NUMBER() = 513) --irrespeto de regla
		return -2
	end catch
	go






	-- Procedimiento de auditoría para aplicar cambios sobre la tabla factura
	Create procedure AplicarAuditoriaFactura 
	@fechaModificación dateTime,
	@fechaCreacion dateTime,
	@usuario varchar(100),
	@usuarioModificación varchar(100),
	@idFacturaC int,
	@saldo float =0,
	@plazo TinyInt =0,
	@montoDescuento float =0,
	@montoNeto float  =0,
	@montoImpuesto float =0,
	@montoBruto float =0,
	@fecha Date = '1753-01-01'
	as
	Insert into Auditoria (idFacturaC,fechaModificacion,fechaCreacion ,usuarioCreacion,usuarioModificacion)
	values (@idFacturaC,@fechaModificación,@fechaCreacion,@usuario,@usuarioModificación);
	if (@fecha != '1753-01-01')
		update FacturasCredito  set fecha = @fecha where idFacturaC = @idFacturaC
	if (@plazo != 0)
		update FacturasCredito  set plazo = @plazo where idFacturaC = @idFacturaC
	if (@montoDescuento != 0)
		update  FacturasCredito set montoDescuento = @montoDescuento where idFacturaC = @idFacturaC
	if (@montoNeto != 0)
		update  FacturasCredito set montoNeto = @montoNeto where idFacturaC = @idFacturaC
	if (@montoImpuesto != 0)
		update FacturasCredito set montoImpuesto = @montoImpuesto where idFacturaC = @idFacturaC
	if (@montoBruto != 0)
		update FacturasCredito set montoBruto = @montoBruto where idFacturaC = @idFacturaC
	if (@saldo != 0)
		update FacturasCredito set saldo = @saldo where idFacturaC = @idFacturaC
	print 'Se ha aplicada la auditoría con éxito'
	
	go




	--Crear una nota y aplicarla a una factura

	Create procedure CrearNota
	@monto float,
	@idFacturaC int,
	@tipo tTipo,
	@descripcion varchar(200),
	@fecha Date
	as
	if ((select f.fecha from FacturasCredito as f where idFacturaC = @idFacturaC) < @fecha and (select f.fechaVencimiento from FacturasCredito as f where idFacturaC = @idFacturaC) > @fecha)
	begin
	 insert into nota (monto,idFacturaC,tipo,descripcion,fecha)
	 values (@monto,@idFacturaC,@tipo,@descripcion,@fecha);
	 if (@tipo = 'Debito')
		update FacturasCredito set montoNeto = montoNeto - @monto where FacturasCredito.idFacturaC = @idFacturaC;

	  if (@tipo = 'Credito')
		update FacturasCredito set montoNeto = montoNeto + @monto where FacturasCredito.idFacturaC = @idFacturaC;
	  return 1;
	end
	else
	begin
		print 'Las fechas no coinciden'
		return 0;
	end
	go 


	create procedure retornarClientes 
	as
	select * from infoCliente
	go

	Create procedure CrearSucursal
	@idSucursal char(4),
	@nombre varchar(50),
	@descripcion varchar(200)
	as
	begin try
	insert into Sucursal(idSucursal,nombre,descripcion)
	values
	(@idSucursal,@nombre,@descripcion);
	end try
	begin catch
	if (ERROR_NUMBER() = 2627) --irrespeto de clave unica
		return -1

	end catch
	go

	create procedure InsertarAbono
	@idAbono char(4),
	@FormaPago tipoPago,
	@idCliente tipoCedula,
	@idFactura int,
	@fecha date,
	@monto float
	as
	if ((select idCliente from Cliente where Cliente.idCliente = @idCliente) is null)
	begin
	 print 'El cliente no existe'
	 return -1
	end
	if((select idFacturaC from FacturasCredito where (select idCliente from Cliente where Cliente.idCliente = @idCliente) = FacturasCredito.idCliente and FacturasCredito.idFacturaC = @idFactura) is null)
	begin 
		print 'El cliente no posee una factura con ese id'
		return -2
	end 
	begin try 
	insert into Abono(idAbono,formaPago,idCliente,idFacturaC,fecha,monto)
	values
	(@idAbono,@FormaPago,@idCliente,@idFactura,@fecha,@monto);
	end try
	begin catch
	print ERROR_NUMBER()
	if (ERROR_NUMBER() = 2627) --irrespeto de clave unica
		return -1
	if (ERROR_NUMBER() = 513) --irrespeto de regla
		return -2
	if (ERROR_NUMBER() = 3609) --Rollback transaction del trigger
		return -3
	end catch
	go


	Create procedure CrearFacturaContado
	@idSucursal char(4),
	@idCliente tipoCedula,
	@montoDescuento float,
	@montoImpuesto float,
	@montoNeto float,
	@fecha date
	as
	Declare @montoBruto float
	set @montoBruto = (@montoNeto + @montoImpuesto) - @montoDescuento
	if ((select idCliente from Cliente where Cliente.idCliente = @idCliente) is null)
	begin
	 print 'El cliente no existe'
	 return -1
	end
	if (@montoDescuento > @montoNeto or @montoImpuesto > @montoNeto )
	begin
	 print 'Los montos no coinciden'
	 return -2
	end
	insert into Factura (idCliente,idSucursal,montoBruto,montoNeto,montoImpuesto,montoDescuento,fecha)
	values (@idCliente,@idSucursal,@montoBruto,@montoNeto,@montoImpuesto,@montoDescuento,@fecha);
	go



create procedure CrearFacturaCredito
@idSucursal char(4),
@idCliente tipoCedula,
@montoDescuento float,
@montoImpuesto float,
@montoBruto float,
@fecha date,
@plazo tinyint,
@idCuenta int
as
Declare @montoNeto float;
Declare @saldo float
Declare @fechavencimiento date

set @saldo = @montoBruto
set @fechavencimiento = DATEADD(MONTH,@plazo,@fecha) 
set @montoNeto = (@montoBruto + @montoImpuesto) - @montoDescuento
if ((select idCliente from Cliente where Cliente.idCliente = @idCliente) is null)
begin
 print 'El cliente no existe'
 return -1
end
if (@montoDescuento > @montoBruto or @montoImpuesto > @montoBruto )
begin
 print 'Los montos no coinciden'
 return -2
end

insert into FacturasCredito(idCliente,idSucursal,montoBruto,montoNeto,montoImpuesto,montoDescuento,fecha,saldo,plazo,fechaVencimiento,idCuentaPorCobrar)
values (@idCliente,@idSucursal,@montoBruto,@montoNeto,@montoImpuesto,@montoDescuento,@fecha,@saldo,@plazo,@fechavencimiento,@idCuenta);
go


create procedure CrearCuenta
@idCliente tipoCedula,
@condicionVenta tipoFactura,
@fecha DATE,
@formaPago tipoPago,
@saldo float,
@plazo tinyint,
@moneda tipoMoneda,
@cambio float
as
Declare @fechavencimiento Date
set @fechavencimiento = DATEADD(MONTH,@plazo,@fecha) 
if ((select idCliente from Cliente where Cliente.idCliente = @idCliente) is null)
begin
 print 'El cliente no existe'
 return -1
end
insert into cuentaPorCobrar(idCliente,condicionVenta,fecha,formaPago,saldo,plazo,moneda,tipoCambio,fechaDeVencimiento)
values 
(@idCliente,@condicionVenta,@fecha,@formaPago,@saldo,@plazo,@moneda,@cambio,@fechavencimiento);
go
	select * from FacturasCredito
		select * from cuentaPorCobrar

