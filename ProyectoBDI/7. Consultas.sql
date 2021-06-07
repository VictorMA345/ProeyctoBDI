
Use ProyectoBD_VictorMontero_JeanCarlosUrbina_ManuelAmores
go			



        --Consultas 

--Seleccionar todas las facturas cuyo estado sea vigente  
Select c.nombre,cc.idcuentaPorCobrar,f.estado  from Cliente as c join cuentaPorCobrar as cc on 
c.idCliente = cc.IdCliente join FacturasCredito as f on cc.idCuentaPorCobrar = f.idCuentaPorCobrar where f.estado = 'Vigente';



-- Seleccionar Personas que tienen facturas en la sucursal Chepeña
select Sucursal.nombre,Sucursal.idSucursal,Cliente.nombre from
Cliente join Factura on Cliente.idCliente = Factura.idCliente join Sucursal on Sucursal.idSucursal = Factura.idSucursal
where Sucursal.nombre = 'Chepeña' 
GROUP BY Sucursal.nombre,Sucursal.idSucursal,Cliente.nombre   -- Group para evitar que salgan numeros repetidos de clientes con más de una factura en esta sucursal




-- Seleccionar Clientes que no tienen facturas de contado
Select Cliente.nombre,Cliente.idCliente from Factura right join Cliente on Factura.idCliente = Cliente.idCliente 
where Factura.idFacturaD Is null;



-- Ver los clientes que su cuenta por cobrar es mayor al promedio de todas las cuentas por cobrar 
select Cliente.idCliente, Cliente.nombre, cuentaPorCobrar.saldo,cuentaPorCobrar.idCuentaPorCobrar, (select sum(saldo)/count(*) from cuentaPorCobrar) as [Promedio]
from Cliente,cuentaPorCobrar 
where Cliente.idCliente=cuentaPorCobrar.idCliente and 
cuentaPorCobrar.saldo > (select sum(saldo)/count(*) from cuentaPorCobrar);

--Sacar los clientes cuyas fechas de las facturas de crédito oscilan entre febrero y agosto del 2021 y cuyo monto bruto sea mayor a 120000

Select Cliente.nombre,Cliente.idCliente,FacturasCredito.fecha,FacturasCredito.fechaVencimiento,FacturasCredito.montoBruto from
Cliente inner join FacturasCredito  on Cliente.idCliente = FacturasCredito.idCliente where
Month(FacturasCredito.fecha) >= 2 and MONTH(FacturasCredito.fechaVencimiento) <= 8 and montoBruto > 120000 and
YEAR(FacturasCredito.fecha) = 2021 and YEAR(FacturasCredito.fechaVencimiento) = 2021






