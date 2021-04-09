import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { StateMasterViewComponent } from './state-master-view.component';

describe('StateMasterViewComponent', () => {
  let component: StateMasterViewComponent;
  let fixture: ComponentFixture<StateMasterViewComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ StateMasterViewComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(StateMasterViewComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
