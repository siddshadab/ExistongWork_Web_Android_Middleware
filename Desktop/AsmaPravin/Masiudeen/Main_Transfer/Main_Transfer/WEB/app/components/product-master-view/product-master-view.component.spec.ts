import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { ProductMasterViewComponent } from './product-master-view.component';

describe('ProductMasterViewComponent', () => {
  let component: ProductMasterViewComponent;
  let fixture: ComponentFixture<ProductMasterViewComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ ProductMasterViewComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(ProductMasterViewComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
