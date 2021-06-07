import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { CrearAbonoComponent } from './crear-abono/crear-abono.component';
import { CrearAuditoriaComponent } from './crear-auditoria/crear-auditoria.component';
import { CrearClientesComponent } from './crear-clientes/crear-clientes.component';
import { CrearCuentaComponent } from './crear-cuenta/crear-cuenta.component';
import { CrearFacturasComponent } from './crear-facturas/crear-facturas.component';
import { CrearNotaComponent } from './crear-nota/crear-nota.component';
import { CrearSucursalComponent } from './crear-sucursal/crear-sucursal.component';
import { FacturaContadoComponent } from './factura-contado/factura-contado.component';
import { FacturaCreditoComponent } from './factura-credito/factura-credito.component';
import { HomeComponent } from './home/home.component';


const routes: Routes = [
  { path: 'CrearAuditoria', component: CrearAuditoriaComponent},
  { path: 'CrearClientes', component: CrearClientesComponent},
  { path: 'CrearFacturas', component: CrearFacturasComponent},
  { path: 'Home', component: HomeComponent},
  { path: 'CrearAbono', component: CrearAbonoComponent},
  { path: 'CrearSucursal', component: CrearSucursalComponent},
  { path: 'FacturaCredito', component: FacturaCreditoComponent},
  { path: 'FacturaContado', component: FacturaContadoComponent},
  { path: 'CrearNota', component: CrearNotaComponent},
  { path: 'CrearCuenta', component: CrearCuentaComponent},
  { path: '**', pathMatch: 'full',redirectTo: 'Home'},
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
