import { Component, OnInit } from '@angular/core';
import { FormControl, FormGroup } from '@angular/forms';
import { DataService } from '../data.service';
import Swal from 'sweetalert2'


@Component({
  selector: 'app-crear-clientes',
  templateUrl: './crear-clientes.component.html',
  styleUrls: ['./crear-clientes.component.css']
})
export class CrearClientesComponent{


  profileForm = new FormGroup({
    idCliente: new FormControl(''),
    nombre: new FormControl(''),
    direccionExacta: new FormControl(''),
    correo : new FormControl(''),
    telefono : new FormControl(''),
    nombreDistrito : new FormControl(''),
    nombreCanton : new FormControl(''),
    nombreProvincia : new FormControl('')
  });

  constructor(private dataService: DataService) {
    console.log("Estoy en clientes")
  }

  ngOnInit(): void {
  }



  IngresarCliente() {
    this.dataService.IngresarCliente(this.profileForm.value).toPromise().then((res:any)=>{
      Swal.fire(`Creado satisfactoriamente`);
      }, (error)=>{
        Swal.fire(`Error a la hora de crear el cliente`)
      });
  }
  
}