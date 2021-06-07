import { Component, OnInit } from '@angular/core';
import { FormControl, FormGroup } from '@angular/forms';
import { DataService } from '../data.service';
import Swal from 'sweetalert2'

@Component({
  selector: 'app-crear-cuenta',
  templateUrl: './crear-cuenta.component.html',
  styleUrls: ['./crear-cuenta.component.css']
})
export class CrearCuentaComponent implements OnInit {
 
    profileForm = new FormGroup({
      idCliente: new FormControl(''),
      condicionVenta: new FormControl(''),    
      fecha: new FormControl(''),
      formaPago : new FormControl(''),
      saldo : new FormControl(''),
      plazo : new FormControl(''),
      moneda: new FormControl(''),   
      cambio: new FormControl(''),
    });
  
    constructor(private dataService: DataService) {
    }
  
    ngOnInit(): void {
    }
  
    CrearCuenta(){
      console.log(this.profileForm.value)
      this.dataService.CrearCuenta(this.profileForm.value).toPromise().then((res:any)=>{
        /*if(res[0].code == 201){
          Swal.fire(`Created successfully`);
         //this.get_Surveyed();
        }*/
      }, (error)=>{
        alert(error.message);
      });
    }
  }