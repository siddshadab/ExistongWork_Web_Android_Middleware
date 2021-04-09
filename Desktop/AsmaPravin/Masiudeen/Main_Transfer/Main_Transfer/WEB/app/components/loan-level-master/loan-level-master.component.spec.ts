import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { LoanLevelMasterComponent } from './loan-level-master.component';

describe('LoanLevelMasterComponent', () => {
  let component: LoanLevelMasterComponent;
  let fixture: ComponentFixture<LoanLevelMasterComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ LoanLevelMasterComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(LoanLevelMasterComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
