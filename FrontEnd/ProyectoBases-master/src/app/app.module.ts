import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';
import {HttpClientModule} from '@angular/common/http';
import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import { CrearClientesComponent } from './crear-clientes/crear-clientes.component';
import { CrearFacturasComponent } from './crear-facturas/crear-facturas.component';
import { CrearAuditoriaComponent } from './crear-auditoria/crear-auditoria.component';
import { HomeComponent } from './home/home.component';
import { CrearAbonoComponent } from './crear-abono/crear-abono.component';
import { ReactiveFormsModule } from '@angular/forms';
import { CrearSucursalComponent } from './crear-sucursal/crear-sucursal.component';
import { FacturaCreditoComponent } from './factura-credito/factura-credito.component';
import { FacturaContadoComponent } from './factura-contado/factura-contado.component';
import { CrearNotaComponent } from './crear-nota/crear-nota.component';
import { CrearCuentaComponent } from './crear-cuenta/crear-cuenta.component';

@NgModule({
  declarations: [
    AppComponent,
    CrearClientesComponent,
    CrearFacturasComponent,
    CrearAuditoriaComponent,
    HomeComponent,
    CrearAbonoComponent,
    CrearSucursalComponent,
    FacturaCreditoComponent,
    FacturaContadoComponent,
    CrearNotaComponent,
    CrearCuentaComponent,
    
    
  ],
  imports: [
    BrowserModule,
    AppRoutingModule,
    ReactiveFormsModule,
    HttpClientModule

  ],
  providers: [],
  bootstrap: [AppComponent]
})
export class AppModule { }