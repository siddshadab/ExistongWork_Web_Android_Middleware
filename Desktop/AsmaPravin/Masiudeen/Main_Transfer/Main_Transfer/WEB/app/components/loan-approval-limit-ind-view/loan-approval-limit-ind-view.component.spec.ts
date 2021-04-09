import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { LoanApprovalLimitIndViewComponent } from './loan-approval-limit-ind-view.component';

describe('LoanApprovalLimitIndViewComponent', () => {
  let component: LoanApprovalLimitIndViewComponent;
  let fixture: ComponentFixture<LoanApprovalLimitIndViewComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ LoanApprovalLimitIndViewComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(LoanApprovalLimitIndViewComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
