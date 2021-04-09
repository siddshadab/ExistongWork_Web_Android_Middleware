import { Component, OnInit } from '@angular/core';
import {FormGroup, FormControl, Validators} from '@angular/forms';
import { ApiService } from '../../services/api.service';
import {Router} from '@angular/router';
import { LocalStorageService } from '../../services/local-storage.service';

declare var dtSample: any;
declare var dtSample1: any;
declare var dtSample2: any;
declare var dismissModal:any;

@Component({
  selector: 'app-loan-approval-limit',
  templateUrl: './loan-approval-limit.component.html',
  styleUrls: ['./loan-approval-limit.component.scss']
})
export class LoanApprovalLimitComponent implements OnInit {

  loanApprovalLimitForm:FormGroup;
  addArray = [];
  reportingUserDropdown:any;
  branchDropdownData:any;
  productDropdownData:any;
  groupCodeLookup:any;

  highlightRowUser : Number;
  proceedButtonUser:boolean = false;
  reportingUserSelectedVal:any;
  reportingUserDescription:any;
  highlightRowBranch : Number;
  proceedButtonBranch:boolean = false;
  branchCodeDescription:any;
  branchCodeSelectedVal:any;
  highlightRowProduct : Number;
  proceedButtonProduct:boolean = false;
  productCodeDescription:any;
  productCodeSelectedVal:any;
  
  constructor(private apiservice:ApiService, private router: Router, private storage: LocalStorageService) { 

    this.loanApprovalLimitForm = new FormGroup({
      mlbrcode: new FormControl('',[Validators.required]),
      mgrpcd: new FormControl('',[Validators.required]),
      musercd: new FormControl('',[Validators.required]),
      msrno: new FormControl('',[Validators.required,Validators.pattern("^[0-9]*$"),Validators.maxLength(8)]),
      mprdcd: new FormControl('',[Validators.required]),
      mlimitamt: new FormControl('',[Validators.required,Validators.pattern("^[0-9]+(.[0-9]{0,2})?$")]),
      moverduedays: new FormControl('',[Validators.required,Validators.pattern("^[0-9]*$"),Validators.maxLength(8)]),
      mloanacmindrbal: new FormControl('',[Validators.required,Validators.pattern("^[0-9]+(.[0-9]{0,2})?$")]),
      mloanacmincrbal: new FormControl('',[Validators.required,Validators.pattern("^[0-9]+(.[0-9]{0,2})?$")]),
      mwriteoffamt: new FormControl('',[Validators.required,Validators.pattern("^[0-9]+(.[0-9]{0,2})?$")]),
      mremarks: new FormControl('',[Validators.required,Validators.maxLength(10)]),
      mcheqlimitamt: new FormControl('',[Validators.required,Validators.pattern("^[0-9]+(.[0-9]{0,2})?$")]),
      mminintrate: new FormControl('',[Validators.required,Validators.pattern("^[0-9]+(.[0-9]{0,2})?$")]),
      mmaxintrate: new FormControl('',[Validators.required,Validators.pattern("^[0-9]+(.[0-9]{0,2})?$")])
      //mlastsynsdate: new FormControl('',[Validators.required])      
    })
  }

  validateForm(){
    if (this.loanApprovalLimitForm.invalid) {
      this.loanApprovalLimitForm.get('mlbrcode').markAsTouched();
      this.loanApprovalLimitForm.get('mgrpcd').markAsTouched();
      this.loanApprovalLimitForm.get('musercd').markAsTouched();
      this.loanApprovalLimitForm.get('msrno').markAsTouched();
      this.loanApprovalLimitForm.get('mprdcd').markAsTouched();
      this.loanApprovalLimitForm.get('mlimitamt').markAsTouched();
      this.loanApprovalLimitForm.get('moverduedays').markAsTouched();
      this.loanApprovalLimitForm.get('mloanacmindrbal').markAsTouched();
      this.loanApprovalLimitForm.get('mloanacmincrbal').markAsTouched();
      this.loanApprovalLimitForm.get('mwriteoffamt').markAsTouched();
      this.loanApprovalLimitForm.get('mremarks').markAsTouched();
      this.loanApprovalLimitForm.get('mcheqlimitamt').markAsTouched();
      this.loanApprovalLimitForm.get('mminintrate').markAsTouched();
      this.loanApprovalLimitForm.get('mmaxintrate').markAsTouched();
      //this.loanApprovalLimitForm.get('mlastsynsdate').markAsTouched();
      return;
    }
  }

  ngOnInit() {

    //this.loanApprovalLimitForm.controls.mlbrcode.disable();
    //this.loanApprovalLimitForm.controls.musercd.disable();
    //this.loanApprovalLimitForm.controls.mprdcd.disable();

    this.reportingUserDropdown = this.storage.getSessionStorage('reportingUserDropdown');
    this.branchDropdownData = this.storage.getSessionStorage('branchDropdownData');
    this.productDropdownData = this.storage.getSessionStorage('productDropdownData');

    let lookupData = this.storage.getSessionStorage('lookupData');
    this.groupCodeLookup = lookupData[1009];

    setTimeout(function(){
      dtSample();
      dtSample1();
      dtSample2();
    },1000);

  }

  reportingUserSelected(val, desc, index){
    //console.log(val);
    this.highlightRowUser = index;
    this.proceedButtonUser = true;
    this.reportingUserDescription = desc;
    this.reportingUserSelectedVal = val;
  }

  branchCodeSelected(val, desc, index){
    //console.log(val);
    this.highlightRowBranch = index;
    this.proceedButtonBranch = true;
    this.branchCodeDescription = desc;
    this.branchCodeSelectedVal = val;
  }

  productCodeSelected(val, desc, index){
    //console.log(val);
    this.highlightRowProduct = index;
    this.proceedButtonProduct = true;
    this.productCodeDescription = desc;
    this.productCodeSelectedVal = val;
  }

  proceedActionUser(){
    this.loanApprovalLimitForm.patchValue({
      musercd: this.reportingUserDescription
    });
    dismissModal();
  }

  proceedActionBranch(){
    this.loanApprovalLimitForm.patchValue({
      mlbrcode: this.branchCodeDescription  
    });
    dismissModal();
  }

  proceedActionProduct(){
    this.loanApprovalLimitForm.patchValue({
      mprdcd: this.productCodeDescription  
    });
    dismissModal();
  }

  onSubmit(data){
    this.validateForm();
    //console.log(data);
    //data.mlastsynsdate = this.apiservice.dateInIso(data.mlastsynsdate);

    data.musercd = this.reportingUserSelectedVal;
    data.mlbrcode = this.branchCodeSelectedVal;
    data.mprdcd = this.productCodeSelectedVal;

    if (this.loanApprovalLimitForm.valid) {
      //console.log("Form Submitted!");
      this.apiservice.postLoanApprovalLimit(data).subscribe(res =>{
        //console.log(res);
        if(res.merror == 200){
          //alert(res.merrormsg);
          this.addArray[0] = true;
          this.addArray[1] = res.merrormsg;
          this.addArray[2] = true;

          //console.log(this.addArray);
          this.router.navigate(['/loan-approval-limit-view'], { skipLocationChange: true, queryParams: this.addArray });
        }else{
          alert(res.merror);
        }
        //alert("Data added successfully.");
      });
      this.loanApprovalLimitForm.reset();
    }

  }

}
