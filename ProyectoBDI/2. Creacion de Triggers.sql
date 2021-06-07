Use ProyectoBD_VictorMontero_JeanCarlosUrbina_ManuelAmores
go					 
   --Triggers

-- Trigger para Comprobar que los montos de las cuentas por cobrar sean mayores a las facturas de credito generadas	
Create Trigger VerificarFacturas on FacturasCredito
for
	insert,update 
as
Declare @SumasMontoNeto float;
Declare @saldo float;
set @saldo = (select c.saldo*c.tipoCambio from cuentaPorCobrar as c where c.idCuentaPorCobrar = (select top 1 idCuentaPorCobrar from inserted));
set @SumasMontoNeto = (select SUM(MontoNeto) FROM FacturasCredito where FacturasCredito.idCuentaPorCobrar = (select top 1 idCuentaPorCobrar from inserted));
	if(@saldo < @SumasMontoNeto)
		begin
			print 'Los montos de las Facturas de credito no pueden ser mayores al saldo de la cuenta por cobrar';
			rollback transaction;
		end
go



--Trigger para para validar que un abono no se mayor que la factura de credito a la que se va a asignar y restarle el abono
--a la factura de credito si el monto es menor
Create Trigger AplicarAbono on
Abono for
insert,update
as
declare @totalAbono float;
set @totalAbono = (select top 1 monto from inserted)
if((select top 1 saldo from FacturasCredito where FacturasCredito.idFacturaC = (select top 1 idFacturaC from inserted )) > @totalAbono) 
	begin
		update FacturasCredito set saldo = saldo - @totalAbono where FacturasCredito.idFacturaC = (select top 1 idFacturaC from inserted )
	end
else if ((select top 1 saldo from FacturasCredito where FacturasCredito.idFacturaC = (select top 1 idFacturaC from inserted )) = @totalAbono)
	update FacturasCredito set saldo = 0,estado = 'Cancelada' where  FacturasCredito.idFacturaC = (select top 1 idFacturaC from inserted )

else if ((select top 1 saldo from FacturasCredito where FacturasCredito.idFacturaC = (select top 1 idFacturaC from inserted )) < @totalAbono)
begin
	print 'No se puede ingresar un abono mayor a la factura' 
	rollback transaction;
end
go



