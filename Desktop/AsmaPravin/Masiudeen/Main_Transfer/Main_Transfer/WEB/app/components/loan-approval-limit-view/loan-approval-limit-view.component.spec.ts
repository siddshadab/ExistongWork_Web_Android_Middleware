import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { LoanApprovalLimitViewComponent } from './loan-approval-limit-view.component';

describe('LoanApprovalLimitViewComponent', () => {
  let component: LoanApprovalLimitViewComponent;
  let fixture: ComponentFixture<LoanApprovalLimitViewComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ LoanApprovalLimitViewComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(LoanApprovalLimitViewComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
