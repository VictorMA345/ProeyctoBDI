import { Component, OnInit } from '@angular/core';
import { FormControl, FormGroup } from '@angular/forms';
import { DataService } from '../data.service';
import Swal from 'sweetalert2'

@Component({
  selector: 'app-factura-credito',
  templateUrl: './factura-credito.component.html',
  styleUrls: ['./factura-credito.component.css']
})
export class FacturaCreditoComponent implements OnInit {
  profileForm = new FormGroup({
    idSucursal: new FormControl(''),
    idCliente: new FormControl(''),
    montoDescuento: new FormControl(''),    
    montoImpuesto: new FormControl(''),
    montoBruto: new FormControl(''),
    fecha: new FormControl(''),
    plazo: new FormControl(''),   
    idCuenta: new FormControl(''),
  });

  constructor(private dataService: DataService) {
    console.log("Estoy en Factura Contado")
   }

  ngOnInit(): void {
  }

  CrearFacturaCredito(){
    console.log(this.profileForm.value)
    this.dataService.CrearFacturaCredito(this.profileForm.value).toPromise().then((res:any)=>{
    Swal.fire(`Creada satisfactoriamente`);
    }, (error)=>{
      Swal.fire(`Error a la hora de crear la factura`)
    });
  }
}