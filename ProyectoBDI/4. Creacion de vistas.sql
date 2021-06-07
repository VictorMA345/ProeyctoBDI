Use ProyectoBD_VictorMontero_JeanCarlosUrbina_ManuelAmores
go	
	
	-- Vistas 

-- Mostrar la informacion del clientes y todas las tablas relacionadas

Create view infoCliente
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


-- Vista para mostrar los montos pendientes de los clientes
Create view VistaSaldoPendiente as
select Cliente.idCliente,Cliente.nombre,Cliente.direccionExacta,SUM(cuentaPorCobrar.saldo * cuentaPorCobrar.tipoCambio) as [Monto Pendiente]  from Cliente 
join cuentaPorCobrar on Cliente.idCliente = cuentaPorCobrar.idCliente group by Cliente.idCliente,Cliente.nombre,Cliente.direccionExacta;
go

-- Vista para mostrar los abonos de los respectivos clientes
create view VistaAbonos 
as
select Cliente.idCliente,Cliente.nombre, Abono.idAbono , Abono.monto from Cliente join Abono on Cliente.idCliente = Abono.idCliente;
go
