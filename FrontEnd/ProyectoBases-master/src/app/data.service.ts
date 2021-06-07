import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';

@Injectable({
  providedIn: 'root'
})
export class DataService {
  private API= "http://localhost:3002/api";   
  constructor(private response: HttpClient) { }


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

}
