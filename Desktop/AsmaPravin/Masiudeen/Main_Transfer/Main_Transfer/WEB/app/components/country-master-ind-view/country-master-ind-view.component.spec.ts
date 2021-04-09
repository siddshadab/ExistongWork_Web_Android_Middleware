import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { CountryMasterIndViewComponent } from './country-master-ind-view.component';

describe('CountryMasterIndViewComponent', () => {
  let component: CountryMasterIndViewComponent;
  let fixture: ComponentFixture<CountryMasterIndViewComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ CountryMasterIndViewComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(CountryMasterIndViewComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
