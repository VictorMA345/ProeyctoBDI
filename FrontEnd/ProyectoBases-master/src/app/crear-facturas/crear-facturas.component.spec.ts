import { ComponentFixture, TestBed } from '@angular/core/testing';

import { CrearFacturasComponent } from './crear-facturas.component';

describe('CrearFacturasComponent', () => {
  let component: CrearFacturasComponent;
  let fixture: ComponentFixture<CrearFacturasComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ CrearFacturasComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(CrearFacturasComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
