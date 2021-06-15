import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Cliente } from './Interfaces/cliente';
import { Sucursal } from './Interfaces/sucursal';

@Injectable({
  providedIn: 'root'
})
export class DataService {
  private API= "http://localhost:3002/api";   
  constructor(private response: HttpClient) { }


  /**
   * @method get all GetClientes
   */
   GetClientes(){    
    return this.response.get<Cliente[]>(this.API+'/json/GetClientes');
  }

  /**
   * @method get all GetSucursal
   */
   GetSucursal(){    
    return this.response.get<Sucursal[]>(this.API+'/json/GetSucursal');
  }

  /**
  * @method post
   * @param data
   * @returns code 201
  */
  IngresarCliente(data: any){    
    return this.response.post(this.API+`/json/Cliente`,data);
  }


  /**
  * @method post
   * @param data
   * @returns code 201
  */
  CrearSucursal(data: any){    
    return this.response.post(this.API+`/json/Sucursal`,data);
  }


  /**
  * @method post
   * @param data
   * @returns code 201
  */
   InsertarAbono(data: any){    
    return this.response.post(this.API+`/json/Abono`,data);
  }

  /**
  * @method post
   * @param data
   * @returns code 201
  */
  CrearFacturaContado(data: any){    
    return this.response.post(this.API+`/json/FacturaD`,data);
  }

  /**
  * @method post
   * @param data
   * @returns code 201
  */  
  CrearNota(data: any){    
    return this.response.post(this.API+`/json/nota`,data);
  }

  /**
  * @method post
   * @param data
   * @returns code 201
  */  
   CrearFacturaCredito(data: any){    
    return this.response.post(this.API+`/json/FacturaC`,data);
  }


  /**
  * @method post
   * @param data
   * @returns code 201
  */  
   CrearCuenta(data: any){    
    return this.response.post(this.API+`/json/Cuenta`,data);
  }

  /**
   * @method delete a BorrarCliente by id
   * @param idCliente 
   * @returns code 200
   */
   BorrarCliente(idCliente:string){     
    return this.response.delete(this.API+`/json/BorrarCliente/${idCliente}`);
  }

  /**
   * @method put a Surveyed by id
   * @param idCliente
   * @param data
   * @returns code 200
   */
   modificarCliente(idCliente: string, data: any ){      
    return this.response.put(this.API+`/json/modificarCliente/${idCliente}`,data);
  }

  /**
   * @method delete a BorrarSucursal by id
   * @param idSucursal 
   * @returns code 200
   */
   BorrarSucursal(idSucursal:string){     
    return this.response.delete(this.API+`/json/BorrarSucursal/${idSucursal}`);
  }

   /**
   * @method put a Surveyed by id
   * @param idSucursal
   * @param data
   * @returns code 200
   */
    modificarSucursal(idSucursal: string, data: any ){      
      return this.response.put(this.API+`/json/modificarSucursal/${idSucursal}`,data);
    }

}
