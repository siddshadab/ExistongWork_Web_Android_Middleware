import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { BranchMasterIndViewComponent } from './branch-master-ind-view.component';

describe('BranchMasterIndViewComponent', () => {
  let component: BranchMasterIndViewComponent;
  let fixture: ComponentFixture<BranchMasterIndViewComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ BranchMasterIndViewComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(BranchMasterIndViewComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
