import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { LookupMasterComponent } from './lookup-master.component';

describe('LookupMasterComponent', () => {
  let component: LookupMasterComponent;
  let fixture: ComponentFixture<LookupMasterComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ LookupMasterComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(LookupMasterComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
