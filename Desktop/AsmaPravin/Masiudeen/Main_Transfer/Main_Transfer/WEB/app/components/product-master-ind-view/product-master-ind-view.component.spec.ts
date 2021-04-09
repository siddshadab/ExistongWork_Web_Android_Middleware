import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { ProductMasterIndViewComponent } from './product-master-ind-view.component';

describe('ProductMasterIndViewComponent', () => {
  let component: ProductMasterIndViewComponent;
  let fixture: ComponentFixture<ProductMasterIndViewComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ ProductMasterIndViewComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(ProductMasterIndViewComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
