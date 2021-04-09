import { Component, OnInit } from '@angular/core';
import { FormGroup, FormControl, Validators } from '@angular/forms';
import { Router } from '@angular/router';
import { ApiService } from '../../services/api.service';
import { LocalStorageService } from '../../services/local-storage.service';
import { AppComponent } from '../../app.component';

declare var dtSample1: any;
declare var dismissModal:any;
declare var scrollToTop: any;

@Component({
  selector: 'app-product-master',
  templateUrl: './product-master.component.html',
  styleUrls: ['./product-master.component.scss']
})
export class ProductMasterComponent implements OnInit {

  productForm:FormGroup;
  moduleTypeLookup:any;
  divisionTypeLookup:any;
  addArray = [];
  code_exist:boolean = true;
  code_exist_message:any;
  branchDropdownData:any;
  currencyDropdown:any;

  highlightRow : Number;
  proceedButton:boolean = false;
  branchCodeDescription:any;
  branchCodeSelectedVal:any;

  constructor(private apiservice:ApiService, private router: Router, private storage: LocalStorageService, public myapp: AppComponent) {

    this.productForm = new FormGroup({

      mlbrcode: new FormControl('',[Validators.required]),
      mprdcd: new FormControl('',[Validators.required,Validators.maxLength(8)]),
      mcurcd: new FormControl('',[Validators.required]),
      mdivisiontype: new FormControl('',[Validators.required]),
      mintrate: new FormControl('',[Validators.required,Validators.maxLength(10)]),
      mmoduletype: new FormControl('',[Validators.required]),
      mname: new FormControl('',[Validators.required]),
      mnoofguaranter: new FormControl('',[Validators.required,Validators.maxLength(8)]),
     
      // mgeolatd: new FormControl('',[Validators.required]),
      // mgeologd: new FormControl('',[Validators.required]),
      // mcreatedby: new FormControl('',[Validators.required]),
      // mcreateddt: new FormControl('',[Validators.required]),
      // mgeolocation: new FormControl('',[Validators.required]),
      // missynctocoresys: new FormControl('',[Validators.required]),
      // mlastsyncdate: new FormControl('',[Validators.required]),
      // mlasteupdatedby: new FormControl('',[Validators.required]),
      // mlastupdateddt: new FormControl('',[Validators.required])
    })  
  }

  validateProductForm(){
    
    if (this.productForm.invalid) {
      this.productForm.get('mlbrcode').markAsTouched();
      this.productForm.get('mprdcd').markAsTouched();
      this.productForm.get('mcurcd').markAsTouched();
      this.productForm.get('mdivisiontype').markAsTouched();
      this.productForm.get('mintrate').markAsTouched();
      this.productForm.get('mmoduletype').markAsTouched();      
      this.productForm.get('mname').markAsTouched();    
      this.productForm.get('mnoofguaranter').markAsTouched();   
      return;
    }
  }

  ngOnInit() {
    //this.productForm.controls.mlbrcode.disable();

    this.branchDropdownData = this.storage.getSessionStorage('branchDropdownData');
    this.currencyDropdown = this.storage.getSessionStorage('currencyDropdown');
    

    let lookupData = this.storage.getSessionStorage('lookupData');
    this.moduleTypeLookup = lookupData[1053];
    //console.log(this.moduleTypeLookup);
    this.divisionTypeLookup = lookupData[2121];
    //console.log(this.divisionTypeLookup);

    setTimeout(function(){
      dtSample1();
    },1000);
  }

  branchCodeSelected(val, desc, index){
    //console.log(val);
    this.highlightRow = index;
    this.proceedButton = true;
    this.branchCodeDescription = desc;
    this.branchCodeSelectedVal = val;
  }

  proceedActionBranch(){
    this.productForm.patchValue({
      mlbrcode: this.branchCodeDescription  
    });
    dismissModal();
  }

  onSubmit(data){
   
    this.validateProductForm();
    //console.log(data); 
    data.mlbrcode = this.branchCodeSelectedVal;

    let code = {mlbrcode: Number(data.mlbrcode), mprdcd: data.mprdcd};
    //console.log(code);

    this.apiservice.productCompositeEntityExist(code).subscribe(res => {
      //console.log(res);
      if(res.merror == 200){
        this.code_exist = false;
        this.code_exist_message = res.merrormsg;
        scrollToTop();  
      }else{
        this.code_exist = true;

        if (this.productForm.valid) {     
          this.apiservice.addProductData(data).subscribe(res => {
            //console.log(res);
            if(res.merror == 200){
              //alert(res.merrormsg);
              this.addArray[0] = true;
              this.addArray[1] = res.merrormsg;
              this.addArray[2] = true;
    
              //console.log(this.addArray);
              this.router.navigate(['/product-master-view'], { skipLocationChange: true, queryParams: this.addArray });
            }else{
              alert(res.merror);
            }   
          });
          
        }
        
      }
    });
    
  }

}
