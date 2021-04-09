import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { UserMasterViewComponent } from './user-master-view.component';

describe('UserMasterViewComponent', () => {
  let component: UserMasterViewComponent;
  let fixture: ComponentFixture<UserMasterViewComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ UserMasterViewComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(UserMasterViewComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
