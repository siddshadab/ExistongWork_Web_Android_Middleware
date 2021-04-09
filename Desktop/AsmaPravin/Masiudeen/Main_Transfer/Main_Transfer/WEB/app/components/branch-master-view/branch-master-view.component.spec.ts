import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { BranchMasterViewComponent } from './branch-master-view.component';

describe('BranchMasterViewComponent', () => {
  let component: BranchMasterViewComponent;
  let fixture: ComponentFixture<BranchMasterViewComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ BranchMasterViewComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(BranchMasterViewComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
