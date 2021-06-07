import { ComponentFixture, TestBed } from '@angular/core/testing';

import { FacturaCreditoComponent } from './factura-credito.component';

describe('FacturaCreditoComponent', () => {
  let component: FacturaCreditoComponent;
  let fixture: ComponentFixture<FacturaCreditoComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ FacturaCreditoComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(FacturaCreditoComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
