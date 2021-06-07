Use ProyectoBD_VictorMontero_JeanCarlosUrbina_ManuelAmores
go						
							


							--Cursores 
-- Cursor para verificar y cambiar las cuentas por cobrar que se encuentren vencidas

Declare VerificarEstado cursor for 
select estado,fechaDeVencimiento,idCuentaPorCobrar from cuentaPorCobrar

Declare @estadoT tipoEstado
Declare @fechaVencimiento Date
Declare @idCuentaPorCobrar int

open VerificarEstado

fetch next from VerificarEstado into
@estadoT,@fechaVencimiento,@idCuentaPorCobrar
while @@FETCH_STATUS = 0
begin
if (@fechaVencimiento < GETDATE())
	Update cuentaPorCobrar set Estado = 'Vencida' where cuentaPorCobrar.idCuentaPorCobrar = @idCuentaPorCobrar
fetch next from VerificarEstado into @estadoT,@fechaVencimiento,@idCuentaPorCobrar
end

close VerificarEstado
Deallocate VerificarEstado



-- Cursor usado para obtener la fecha de vencimiento en base al plazo y la fecha de creacion
Declare CambiarFecha cursor for 
select fecha,plazo,idCuentaPorCobrar from cuentaPorCobrar

Declare @fecha Date
Declare @plazo int
Declare @CuentaPorCobrar int
open CambiarFecha

fetch next from CambiarFecha into
@fecha,@plazo,@CuentaPorCobrar

while @@FETCH_STATUS = 0
begin
update cuentaPorCobrar set fechaDeVencimiento = DATEADD(MONTH,@plazo,@fecha) where @CuentaPorCobrar = cuentaPorCobrar.idCuentaPorCobrar;
fetch next from CambiarFecha into @fecha,@plazo,@CuentaPorCobrar
end

close CambiarFecha

Deallocate CambiarFecha

--Cursor para aplicar los montos de las notas a las facturas de crédito
Declare aplicar cursor for 
select monto,tipo,idFacturaC from nota	
open aplicar;
Declare @monto int;
Declare @reglaTipo tTipo;
Declare @idFacturaC int 
fetch next from aplicar into
@monto,@reglaTipo,@idFacturaC

while @@FETCH_STATUS = 0
begin
if (@reglaTipo = 'Debito')
	update FacturasCredito set montoNeto = montoNeto + @monto where @idFacturaC = FacturasCredito.idFacturaC;
if (@reglaTipo = 'Credito')
	update FacturasCredito set montoNeto = montoNeto - @monto where @idFacturaC = FacturasCredito.idFacturaC;
fetch next from aplicar into @monto,@reglaTipo,@idFacturaC
end
close aplicar
Deallocate aplicar

