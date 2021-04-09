import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { UserMasterIndViewComponent } from './user-master-ind-view.component';

describe('UserMasterIndViewComponent', () => {
  let component: UserMasterIndViewComponent;
  let fixture: ComponentFixture<UserMasterIndViewComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ UserMasterIndViewComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(UserMasterIndViewComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
