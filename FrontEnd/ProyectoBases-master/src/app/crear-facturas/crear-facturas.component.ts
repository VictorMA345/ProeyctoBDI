import { Component, OnInit } from '@angular/core';

@Component({
  selector: 'app-crear-facturas',
  templateUrl: './crear-facturas.component.html',
  styleUrls: ['./crear-facturas.component.css']
})
export class CrearFacturasComponent implements OnInit {

  constructor() { 
    console.log("Estoy en facturas")
  }

  ngOnInit(): void {
  }

}
