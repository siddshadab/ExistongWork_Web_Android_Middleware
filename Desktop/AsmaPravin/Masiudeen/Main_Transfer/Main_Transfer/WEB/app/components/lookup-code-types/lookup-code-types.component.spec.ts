import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { LookupCodeTypesComponent } from './lookup-code-types.component';

describe('LookupCodeTypesComponent', () => {
  let component: LookupCodeTypesComponent;
  let fixture: ComponentFixture<LookupCodeTypesComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ LookupCodeTypesComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(LookupCodeTypesComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
