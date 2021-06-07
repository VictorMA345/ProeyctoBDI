import { Component, OnInit } from '@angular/core';
import { FormControl, FormGroup } from '@angular/forms';
import { DataService } from '../data.service';
import Swal from 'sweetalert2'


@Component({
  selector: 'app-factura-contado',
  templateUrl: './factura-contado.component.html',
  styleUrls: ['./factura-contado.component.css']
})
export class FacturaContadoComponent implements OnInit {
  profileForm = new FormGroup({
    idSucursal: new FormControl(''),
    idCliente: new FormControl(''),
    montoDescuento: new FormControl(''),    
    montoImpuesto: new FormControl(''),
    montoNeto: new FormControl(''),
    fecha: new FormControl('')    
  });

  constructor(private dataService: DataService) {
    console.log("Estoy en Factura Contado")
   }

  ngOnInit(): void {
  }

  CrearFacturaContado(){
    this.dataService.CrearFacturaContado(this.profileForm.value).toPromise().then((res:any)=>{
      if(res[0].code == 201){
        Swal.fire(`Created successfully`);
       //this.get_Surveyed();
      }
    }, (error)=>{
      alert(error.message);
    });
  }
}