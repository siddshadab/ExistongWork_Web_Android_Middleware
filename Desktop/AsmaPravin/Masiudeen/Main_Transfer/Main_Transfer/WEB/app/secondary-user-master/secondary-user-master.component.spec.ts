import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { SecondaryUserMasterComponent } from './secondary-user-master.component';

describe('SecondaryUserMasterComponent', () => {
  let component: SecondaryUserMasterComponent;
  let fixture: ComponentFixture<SecondaryUserMasterComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ SecondaryUserMasterComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(SecondaryUserMasterComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
