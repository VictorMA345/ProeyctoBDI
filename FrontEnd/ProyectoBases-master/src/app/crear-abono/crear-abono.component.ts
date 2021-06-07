import { Component, OnInit } from '@angular/core';
import { FormControl, FormGroup } from '@angular/forms';
import { DataService } from '../data.service';
import Swal from 'sweetalert2'



@Component({
  selector: 'app-crear-abono',
  templateUrl: './crear-abono.component.html',
  styleUrls: ['./crear-abono.component.css']
})
export class CrearAbonoComponent implements OnInit {
  profileForm = new FormGroup({
    idAbono: new FormControl(''),
    FormaDePago: new FormControl(''),
    idCliente: new FormControl(''),
    idFactura: new FormControl(''),
    fecha: new FormControl(''),
    monto: new FormControl('')
  });
  constructor(private dataService: DataService) {
    console.log("Estoy en clientes")
   }

  ngOnInit(): void {
  }

  InsertarAbono(){
    console.log(this.profileForm.value)
    this.dataService.InsertarAbono(this.profileForm.value).toPromise().then((res:any)=>{
      //if(res[0].code == 201){
        Swal.fire(`Created successfully`);
       //this.get_Surveyed();
      //}
    }, (error)=>{
      alert(error.message);
    });
  }
}