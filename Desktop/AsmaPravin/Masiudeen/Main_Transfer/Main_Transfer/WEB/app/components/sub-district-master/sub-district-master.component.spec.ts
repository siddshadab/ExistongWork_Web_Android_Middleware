import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { SubDistrictMasterComponent } from './sub-district-master.component';

describe('SubDistrictMasterComponent', () => {
  let component: SubDistrictMasterComponent;
  let fixture: ComponentFixture<SubDistrictMasterComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ SubDistrictMasterComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(SubDistrictMasterComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
