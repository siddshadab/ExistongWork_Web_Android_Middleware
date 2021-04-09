import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { DistrictMasterViewComponent } from './district-master-view.component';

describe('DistrictMasterViewComponent', () => {
  let component: DistrictMasterViewComponent;
  let fixture: ComponentFixture<DistrictMasterViewComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ DistrictMasterViewComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(DistrictMasterViewComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
