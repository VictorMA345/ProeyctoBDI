import { ComponentFixture, TestBed } from '@angular/core/testing';

import { FacturaContadoComponent } from './factura-contado.component';

describe('FacturaContadoComponent', () => {
  let component: FacturaContadoComponent;
  let fixture: ComponentFixture<FacturaContadoComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ FacturaContadoComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(FacturaContadoComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
