import { Component, OnInit } from '@angular/core';
import { DataService } from '../data.service';
import { Cliente } from '../Interfaces/cliente';
import { Sucursal } from '../Interfaces/sucursal';
import Swal from 'sweetalert2'


@Component({
  selector: 'app-home',
  templateUrl: './home.component.html',
  styleUrls: ['./home.component.css']
})
export class HomeComponent implements OnInit {
  namePage = 'Facturación Total'
  paquetes: Cliente[] = []
  sucursal: Sucursal[]= []
  constructor(private dataService: DataService) {       
  }

  ngOnInit(): void {
    this.GetClientes()
    this.GetSucursal()
  }

  GetClientes(){
    this.dataService.GetClientes().toPromise().then((res:any)=>{      
      this.paquetes = res;      
    }, (error)=>{
      alert(error.message);
    });
  }

  GetSucursal(){
    this.dataService.GetSucursal().toPromise().then((res:any)=>{      
      this.sucursal = res;
    }, (error)=>{
      alert(error.message);
    });
  }


  BorrarCliente(id: string){
    this.dataService.BorrarCliente(id).toPromise().then((res:any)=>{      
        Swal.fire({
          position: 'center',
          icon: 'success',
          title: '¡Successfully removed!',
          showConfirmButton: true
        })
        this.GetClientes();    
        
    }, (error: any)=>{
      alert(error.message);
    });
  }

  async modificarCliente(idCliente: string, nombreDistrito: string, direccionExacta: string, nombre: string, correo: string, telefono: string){  
    const {value: formValues} = await Swal.fire({      
      title: 'Modificar al cliente '+`${nombre}`,
      html:
        'Nombre'+
        '<input id="nombreDistrito" class="swal2-input">'+
        'Dirección'+
        '<input type="text" id="direccionExacta" class="swal2-input">'+
        'Nombre'+
        '<input id="nombre" class="swal2-input">'+
        'Correo'+
        '<input type="text" id="correo" class="swal2-input">'+
        'Telefono'+
        '<input id="telefono" class="swal2-input">',        
      focusConfirm: false,      
      preConfirm: () => {
        return [
          (document.getElementById("nombreDistrito") as HTMLInputElement).value,
          (document.getElementById("direccionExacta") as HTMLInputElement).value,
          (document.getElementById("nombre") as HTMLInputElement).value,
          (document.getElementById("correo") as HTMLInputElement).value,
          (document.getElementById("telefono") as HTMLInputElement).value
        ]
      }
    })    
    if (formValues) {
      if(formValues[0] == "" || formValues[1] == "" || formValues[2] == "" || formValues[3] == "" || formValues[4] == ""){
        Swal.fire(`Tiene que llenar los datos`);
      }
      else{
        let Distrito= formValues[0]
        let direccion= formValues[1]
        let nombre= formValues[2]
        let correo= formValues[3]
        let telefono= formValues[4]
        let data= {
          Distrito,
          direccion,
          nombre,
          correo,
          telefono
        }
        console.log(data)
          var json= (JSON.stringify(formValues))
          this.dataService.modificarCliente(idCliente,data).toPromise().then((res:any)=>{           
              Swal.fire(`Created successfully`);
              this.GetClientes();            
          }, (error)=>{
            alert(error.message);
          });
      }      
    }   
  }

  BorrarSucursal(id: string){
    this.dataService.BorrarSucursal(id).toPromise().then((res:any)=>{      
        Swal.fire({
          position: 'center',
          icon: 'success',
          title: '¡Successfully removed!',
          showConfirmButton: true
        })
        this.GetSucursal();       
    }, (error: any)=>{
      alert(error.message);
    });
  }

  async modificarSucursal(idSucursal:string, nombre:string, descripcion:string){
    const {value: formValues} = await Swal.fire({      
      title: 'Modificar la sucursal '+`${nombre}`,
      html:
        'Nombre'+
        '<input type="text" id="swal-input1" class="swal2-input">'+
        'Descripción'+
        '<input id="swal-input2" class="swal2-input">',        
      focusConfirm: false,      
      preConfirm: () => {
        return [
          (document.getElementById("swal-input1") as HTMLInputElement).value,
          (document.getElementById("swal-input2") as HTMLInputElement).value
        ]
      }
    })    
    if (formValues) {
      if(formValues[0] == "" || formValues[1] == ""){
        Swal.fire(`Tiene que llenar los datos`);
      }
      else{
        let nombre= formValues[0]
        let descripcion= formValues[1]
        let data= {
          nombre,
          descripcion
        }
          var json= (JSON.stringify(formValues))
          this.dataService.modificarSucursal(idSucursal,data).toPromise().then((res:any)=>{           
              Swal.fire(`Created successfully`);
              this.GetSucursal();            
          }, (error)=>{
            alert(error.message);
          });
      }      
    }   
  }  
}
