import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';
import {HttpClientModule} from '@angular/common/http';
import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import { CrearClientesComponent } from './crear-clientes/crear-clientes.component';
import { CrearAuditoriaComponent } from './crear-auditoria/crear-auditoria.component';
import { HomeComponent } from './home/home.component';
import { CrearAbonoComponent } from './crear-abono/crear-abono.component';
import { ReactiveFormsModule } from '@angular/forms';
import { CrearSucursalComponent } from './crear-sucursal/crear-sucursal.component';
import { FacturaCreditoComponent } from './factura-credito/factura-credito.component';
import { FacturaContadoComponent } from './factura-contado/factura-contado.component';
import { CrearNotaComponent } from './crear-nota/crear-nota.component';
import { CrearCuentaComponent } from './crear-cuenta/crear-cuenta.component';
import { BrowserAnimationsModule } from '@angular/platform-browser/animations';
import { MatButtonModule } from '@angular/material/button';
import {MatIconModule} from '@angular/material/icon';
import { CrearFacturaComponent } from './crear-facturas/crear-factura.component';

@NgModule({
  declarations: [
    AppComponent,
    CrearClientesComponent,
    CrearAuditoriaComponent,
    HomeComponent,
    CrearAbonoComponent,
    CrearSucursalComponent,
    FacturaCreditoComponent,
    FacturaContadoComponent,
    CrearNotaComponent,
    CrearCuentaComponent,
    CrearFacturaComponent,
    
    
  ],
  imports: [
    BrowserModule,
    AppRoutingModule,
    ReactiveFormsModule,
    HttpClientModule,
    BrowserAnimationsModule,
    MatButtonModule,
    MatIconModule

  ],
  providers: [],
  bootstrap: [AppComponent]
})
export class AppModule { }