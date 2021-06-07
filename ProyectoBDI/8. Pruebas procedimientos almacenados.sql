--Pruebas de procedimientos almacenados
use ProyectoBD_VictorMontero_JeanCarlosUrbina_ManuelAmores
go
--Se ejecuta el procedimiento IngresarCliente para validar su funcionamiento
exec IngresarCliente '5-0458-0786','Manuel Amores Gonzalez','xxxxxxxxxxxxxx','Amores90@gmail.com','6443-0976','San Isidro','Tilaran','Guanacaste'


--Aca se ejecuta el procedimiento para AplicarAuditoriaFactura
exec AplicarAuditoriaFactura '2021-05-19','2021-05-19','Victor Montero','Victor Montero',5,@montoImpuesto = 5000, @saldo = 100000;
 


--Aca se creaNota y se aplica de una ve a la factura de credito
exec CrearNota '10000',3,'Debito','Pago','2021-05-01'