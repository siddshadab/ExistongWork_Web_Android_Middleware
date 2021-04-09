import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { LoanLevelIndViewComponent } from './loan-level-ind-view.component';

describe('LoanLevelIndViewComponent', () => {
  let component: LoanLevelIndViewComponent;
  let fixture: ComponentFixture<LoanLevelIndViewComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ LoanLevelIndViewComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(LoanLevelIndViewComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
