import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { UserAccessRightsViewComponent } from './user-access-rights-view.component';

describe('UserAccessRightsViewComponent', () => {
  let component: UserAccessRightsViewComponent;
  let fixture: ComponentFixture<UserAccessRightsViewComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ UserAccessRightsViewComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(UserAccessRightsViewComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
