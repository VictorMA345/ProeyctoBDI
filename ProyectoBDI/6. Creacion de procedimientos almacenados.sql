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
	set @idProvincia = (Select p.idProvincia from Provincia as p where @nombreProvincia = p.nombre)
	
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
	insert into nota (monto,idFacturaC,tipo,descripcion,fecha)
	 values (@monto,@idFacturaC,@tipo,@descripcion,@fecha);
	 if (@tipo = 'Debito' and @monto<= (select montoNeto from FacturasCredito where FacturasCredito.idFacturaC = @idFacturaC)) 
		 begin
			update FacturasCredito set montoNeto = montoNeto - @monto  where FacturasCredito.idFacturaC = @idFacturaC;
			update FacturasCredito set saldo = saldo - @monto  where FacturasCredito.idFacturaC = @idFacturaC;
		 end
		
	  if (@tipo = 'Credito')
	  begin
		update FacturasCredito set montoNeto = montoNeto + @monto where FacturasCredito.idFacturaC = @idFacturaC;
		update FacturasCredito set saldo = saldo + @monto where FacturasCredito.idFacturaC = @idFacturaC;
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
	insert into Sucursal(idSucursal,nombre,descripcion)
	values
	(@idSucursal,@nombre,@descripcion);
	go

	create procedure InsertarAbono
	@idAbono char(4),
	@FormaPago tipoPago,
	@idCliente tipoCedula,
	@idFactura int,
	@fecha date,
	@monto float
	as	
	insert into Abono(idAbono,formaPago,idCliente,idFacturaC,fecha,monto)
	values
	(@idAbono,@FormaPago,@idCliente,@idFactura,@fecha,@monto);
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
   select * from cuentaPorCobrar
set @saldo = @montoBruto
set @fechavencimiento = DATEADD(MONTH,@plazo,@fecha) 
set @montoNeto = (@montoBruto + @montoImpuesto) - @montoDescuento


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



Create procedure GetClientes 
as
Select  Cliente.idCliente,Cliente.nombre,Cliente.idDistrito,Cliente.direccionExacta,Distrito.nombre as nombreDistrito,
Canton.nombre as nombreCanton,Provincia.nombre as nombreProvincia, correo.correo,telefono.telefono
from Cliente
inner join Distrito on Distrito.idDistrito = Cliente.idDistrito
inner join Canton on Distrito.idCanton = Canton.idCanton 
inner join Provincia on Provincia.idProvincia = Canton.idProvincia
inner join correo on correo.idCliente = Cliente.idCliente
inner join telefono on telefono.idCliente = Cliente.idCliente;
go


Create procedure GetSucursal
as
select * from Sucursal
go	   


Create procedure BorrarCliente
@idCliente tipoCedula
as
delete Abono WHERE idCliente = @idCliente
delete Correo where idCliente = @idCliente
delete telefono where idCliente = @idCliente
delete Nota where idFacturaC in (select idFacturaC from FacturasCredito where idCliente = @idCliente)
delete FacturasCredito where idCliente = @idCliente
delete Factura where idCliente = @idCliente
delete cuentaPorCobrar where idCliente =@idCliente
delete Cliente where idCliente = @idCliente
go


create procedure BorrarSucursal
@idSucursal char(4)
as
select * into #AbonosBorrados from Abono where idFacturaC in (select idFacturaC from FacturasCredito where idSucursal= @idSucursal)
select * into #NotasBorradas from Nota where idFacturaC in (select idFacturaC from FacturasCredito where idSucursal= @idSucursal)
delete Nota where Nota.idNota in (select idNota from #NotasBorradas) 
delete Abono where Abono.idAbono in (select idAbono from #AbonosBorrados) 
delete FacturasCredito where idSucursal = @idSucursal
delete Factura where idSucursal = @idSucursal

delete Sucursal where idSucursal = @idSucursal
go


Create procedure modificarCliente
@idCliente tipoCedula,
@Distrito varchar(30),
@direccion varchar(200),
@nombre varchar(100),
@correo tipoCorreo,
@telefono tipoTelefono
as
begin try
Declare @idDistrito int
set @idDistrito = (select idDistrito from Distrito where nombre = @Distrito)
update Correo set correo = @correo where Correo.idCliente = @idCliente
update Cliente set direccionExacta = @direccion where Cliente.idCliente = @idCliente
update telefono set telefono = @telefono where telefono.idCliente = @idCliente
update Cliente set nombre = @nombre where Cliente.idCliente = @idCliente
update Cliente set idDistrito = @idDistrito where Cliente.idCliente = @idCliente
end try
begin Catch
print ERROR_NUMBER()
	if (ERROR_NUMBER() = 2627) --irrespeto de clave unica
		return -1
	if (ERROR_NUMBER() = 513) --irrespeto de regla
		return -2
end catch
go



create procedure modificarSucursal 
@idSucursal char(4),
@nombre varchar(50),
@descripcion varchar(200)

as
update Sucursal set descripcion = @descripcion where Sucursal.idSucursal = @idSucursal 
update Sucursal set nombre = @nombre where Sucursal.idSucursal = @idSucursal 
go
			select * from cuentaPorCobrar
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
insert into cuentaPorCobrar(idCliente,condicionVenta,fecha,formaPago,saldo,plazo,moneda,tipoCambio,fechaDeVencimiento)
values 
(@idCliente,@condicionVenta,@fecha,@formaPago,@saldo,@plazo,@moneda,@cambio,@fechavencimiento);
go