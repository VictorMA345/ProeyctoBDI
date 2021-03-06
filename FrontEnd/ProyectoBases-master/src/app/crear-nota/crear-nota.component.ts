import { Component, OnInit } from '@angular/core';
import { FormControl, FormGroup } from '@angular/forms';
import { DataService } from '../data.service';
import Swal from 'sweetalert2'

@Component({
  selector: 'app-crear-nota',
  templateUrl: './crear-nota.component.html',
  styleUrls: ['./crear-nota.component.css']
})
export class CrearNotaComponent implements OnInit {
  profileForm = new FormGroup({
    monto: new FormControl(''),
    idFacturaC: new FormControl(''),
    tipo: new FormControl(''),
    descripcion: new FormControl(''),
    fecha: new FormControl('')    
  });

  constructor(private dataService: DataService) {
   }

  ngOnInit(): void {
  }

  CrearNota(){
    this.dataService.CrearNota(this.profileForm.value).toPromise().then((res:any)=>{
    Swal.fire(`Creada satisfactoriamente`);
    }, (error)=>{
      Swal.fire(`Error a la hora de crear la nota`)
    });
  }
}