import { ComponentFixture, TestBed } from '@angular/core/testing';

import { CrearAuditoriaComponent } from './crear-auditoria.component';

describe('CrearAuditoriaComponent', () => {
  let component: CrearAuditoriaComponent;
  let fixture: ComponentFixture<CrearAuditoriaComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ CrearAuditoriaComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(CrearAuditoriaComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
