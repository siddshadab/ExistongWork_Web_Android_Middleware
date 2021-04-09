import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { DistrictMasterIndViewComponent } from './district-master-ind-view.component';

describe('DistrictMasterIndViewComponent', () => {
  let component: DistrictMasterIndViewComponent;
  let fixture: ComponentFixture<DistrictMasterIndViewComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ DistrictMasterIndViewComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(DistrictMasterIndViewComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
