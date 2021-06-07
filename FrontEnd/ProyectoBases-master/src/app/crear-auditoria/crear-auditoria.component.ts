import { Component, OnInit } from '@angular/core';

@Component({
  selector: 'app-crear-auditoria',
  templateUrl: './crear-auditoria.component.html',
  styleUrls: ['./crear-auditoria.component.css']
})
export class CrearAuditoriaComponent implements OnInit {

  constructor() { 
    console.log("Estoy en auditoria")
  }

  ngOnInit(): void {
  }

}
