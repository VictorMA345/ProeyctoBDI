import { Component, OnInit } from '@angular/core';
import { FormControl, FormGroup } from '@angular/forms';
import Swal from 'sweetalert2'
import { DataService } from '../data.service';

@Component({
  selector: 'app-crear-sucursal',
  templateUrl: './crear-sucursal.component.html',
  styleUrls: ['./crear-sucursal.component.css']
})
export class CrearSucursalComponent implements OnInit {


  profileForm = new FormGroup({
    idSucursal: new FormControl(''),
    nombre: new FormControl(''),
    descripcion: new FormControl('')
  });


  constructor(private dataService: DataService) { 
    
  }

  ngOnInit(): void {
  }

  CrearSucursal(){
    console.log(this.profileForm.value);
    this.dataService.CrearSucursal(this.profileForm.value).toPromise().then((res:any)=>{
    /*if(res[0].code == 201){
      Swal.fire(`Created successfully`);
     //this.get_Surveyed();
    }*/
  }, (error)=>{
    alert(error.message);
  });
  }

}