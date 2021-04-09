import { ApiService } from './../../services/api.service';
import { Router } from '@angular/router';
import { LocalStorageService } from './../../services/local-storage.service';
import { AppComponent } from './../../app.component';
import { FormGroup, Validators, FormControl } from '@angular/forms';
import { Component, OnInit } from '@angular/core';

declare var dtSample2: any;
declare var dismissModal:any;

@Component({
  selector: 'app-loan-level-master',
  templateUrl: './loan-level-master.component.html',
  styleUrls: ['./loan-level-master.component.scss']
})
export class LoanLevelMasterComponent implements OnInit {

  loanLvlForm:FormGroup;
  addArray = [];
  productDropdownData:any;

  highlightRowProduct : Number;
  proceedButtonProduct:boolean = false;
  productCodeDescription:any;
  productCodeSelectedVal:any;

  constructor(private apiservice:ApiService, private router: Router, private storage: LocalStorageService, public myapp: AppComponent) {

    this.loanLvlForm = new FormGroup({

      // mrefno: new FormControl('',[Validators.required,Validators.pattern("^[0-9]*$"),Validators.maxLength(8)]),
      mbuttonid: new FormControl('',[Validators.required,Validators.pattern("^[0-9]*$"),Validators.maxLength(2)]),
      mbuttonname: new FormControl('',[Validators.required,Validators.maxLength(30)]),
      //mproductname: new FormControl('',[Validators.required,Validators.maxLength(75)]),
      mstageid: new FormControl('',[Validators.required,Validators.pattern("^[0-9]*$"),Validators.maxLength(4)]),
      mprdcd: new FormControl('',[Validators.required]),
      morderid: new FormControl('',[Validators.required,Validators.pattern("^[0-9]*$"),Validators.maxLength(2)]),
      mismandatory: new FormControl('',[Validators.required,Validators.pattern("^[0-9]*$"),Validators.maxLength(2)]),     
     
    }) 

    
   }
  
   validateloanLvlForm(){
    
    if (this.loanLvlForm.invalid) {
      // this.loanLvlForm.get('mrefno').markAsTouched();
      this.loanLvlForm.get('mbuttonid').markAsTouched();
      this.loanLvlForm.get('mbuttonname').markAsTouched();
      //this.loanLvlForm.get('mproductname').markAsTouched();
      this.loanLvlForm.get('mstageid').markAsTouched();
      this.loanLvlForm.get('mprdcd').markAsTouched();      
      this.loanLvlForm.get('morderid').markAsTouched();    
      this.loanLvlForm.get('mismandatory').markAsTouched();   
      return;
    }  
  }

  ngOnInit() {
    this.productDropdownData = this.storage.getSessionStorage('productDropdownData');

    setTimeout(function(){
      dtSample2();
    },1000);

  }

  productCodeSelected(val, desc, index){
    //console.log(val);
    this.highlightRowProduct = index;
    this.proceedButtonProduct = true;
    this.productCodeDescription = desc;
    this.productCodeSelectedVal = val;
  }

  proceedActionProduct(){
    this.loanLvlForm.patchValue({
      mprdcd: this.productCodeDescription  
    });
    dismissModal();
  }

  // onKeyUp(val){
  //   if(val !== "" && Number.isInteger(Number(val))){
  //     //console.log('Method called');
  //     let code = {mrefno: val};
  //     //console.log(code);
  //     this.apiservice.mrefnoExist(code).subscribe(res => {
  //       //console.log(res);
  //       if(res.merror == 200){
  //         this.code_exist = false;
  //         this.code_exist_message = res.merrormsg;
  //       }else{
  //         this.code_exist = true;
  //       }
  //     });
  //   }else{
  //     this.code_exist = true;
  //     //console.log('wrong input');
  //   }
    
  // }

  onSubmit(data){
   
    this.validateloanLvlForm();
    //console.log(data);
    data.mprdcd = this.productCodeSelectedVal;

    if (this.loanLvlForm.valid) {     
      this.apiservice.addLoanLvl(data).subscribe(res => {
        //console.log(res);
        //alert("Record added successfully !");
        if(res.merror == 200){
          //alert(res.merrormsg);
          this.addArray[0] = true;
          this.addArray[1] = res.merrormsg;
          this.addArray[2] = true;

          //console.log(this.addArray);
          this.router.navigate(['/loan-level-view'], { skipLocationChange: true, queryParams: this.addArray });
        }else{
          alert(res.merror);
        }      
      });
      this.loanLvlForm.reset();
      //alert('record sumitted');
    }
  
  }

}
