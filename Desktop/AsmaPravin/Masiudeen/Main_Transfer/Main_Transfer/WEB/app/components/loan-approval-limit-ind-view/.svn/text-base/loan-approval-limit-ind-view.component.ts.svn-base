import { Component, OnInit } from '@angular/core';
import {Router, ActivatedRoute} from '@angular/router';
import {FormGroup, FormControl, Validators} from '@angular/forms';
import { ApiService } from '../../services/api.service';
import { LocalStorageService } from '../../services/local-storage.service';

declare var dtSample2: any;
declare var dismissModal:any;


@Component({
  selector: 'app-loan-approval-limit-ind-view',
  templateUrl: './loan-approval-limit-ind-view.component.html',
  styleUrls: ['./loan-approval-limit-ind-view.component.scss']
})
export class LoanApprovalLimitIndViewComponent implements OnInit {

  sub:any;
  loanApprovalViewData:any;
  editActivated:boolean = false;
  formClass:string = "form-readcontroller";
  controlMandate:string = "";
  deleteData = [];

  updateArray = [];
  deleteArray = [];
  rightsData:any;
  reportingUserDropdown:any;
  branchDropdownData:any;
  productDropdownData:any;
  groupCodeLookup:any;

  highlightRowProduct : Number;
  proceedButtonProduct:boolean = false;
  productCodeDescription:any;
  productCodeSelectedVal:any;
  productSel:boolean = false;

  loanApprovalLimitViewForm:FormGroup;

  constructor(private router: Router, private route: ActivatedRoute, private apiservice:ApiService, private storage: LocalStorageService) {
    this.loanApprovalLimitViewForm = new FormGroup({
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

  ngOnInit() {

    this.rightsData = this.storage.getSessionStorage('rights');
    //console.log(this.rightsData);

    this.reportingUserDropdown = this.storage.getSessionStorage('reportingUserDropdown');
    this.branchDropdownData = this.storage.getSessionStorage('branchDropdownData');
    this.productDropdownData = this.storage.getSessionStorage('productDropdownData');

    let lookupData = this.storage.getSessionStorage('lookupData');
    this.groupCodeLookup = lookupData[1009];

    this.sub = this.route
      .queryParams
      .subscribe(params => {
        //console.log(params);
        this.loanApprovalViewData = JSON.parse(params.first);
    });

    setTimeout(function(){
      dtSample2();
    },1000);

  }

  productCodeSelected(val, desc, index){
    //console.log(val);
    this.productSel = true;
    this.highlightRowProduct = index;
    this.proceedButtonProduct = true;
    this.productCodeDescription = desc;
    this.productCodeSelectedVal = val;
  }

  proceedActionProduct(){
    this.loanApprovalLimitViewForm.patchValue({
      mprdcd: this.productCodeDescription  
    });
    dismissModal();
  }

  backToView(){
    this.editActivated = false;
    if(!this.editActivated){
      this.formClass = "form-readcontroller";
      this.controlMandate = "";
    }
  }

  updateInput(){
    this.loanApprovalLimitViewForm.patchValue({
      mlbrcode: this.loanApprovalViewData.loanApprovalLimitCompositeEntity.mlbrcode,
      mgrpcd: this.loanApprovalViewData.loanApprovalLimitCompositeEntity.mgrpcd,
      musercd: this.loanApprovalViewData.loanApprovalLimitCompositeEntity.musercd,
      msrno: this.loanApprovalViewData.loanApprovalLimitCompositeEntity.msrno,
      mprdcd: this.loanApprovalViewData.mprdcd,
      mlimitamt: this.loanApprovalViewData.mlimitamt,
      moverduedays: this.loanApprovalViewData.moverduedays,
      mloanacmindrbal: this.loanApprovalViewData.mloanacmindrbal,
      mloanacmincrbal: this.loanApprovalViewData.mloanacmincrbal,
      mwriteoffamt: this.loanApprovalViewData.mwriteoffamt,
      mremarks: this.loanApprovalViewData.mremarks,
      mcheqlimitamt: this.loanApprovalViewData.mcheqlimitamt,
      mminintrate: this.loanApprovalViewData.mminintrate,
      mmaxintrate: this.loanApprovalViewData.mmaxintrate
      //mlastsynsdate: this.loanApprovalViewData.mlastsynsdate
    });
  }

  edit(){
    this.editActivated = true;
    //console.log(this.editActivated);
    if(this.editActivated){
      this.formClass = "form-controller";
      this.controlMandate = "control-mandatory";
    }
    this.updateInput();
  }

  validateForm(){
    if (this.loanApprovalLimitViewForm.invalid) {
      this.loanApprovalLimitViewForm.get('mlbrcode').markAsTouched();
      this.loanApprovalLimitViewForm.get('mgrpcd').markAsTouched();
      this.loanApprovalLimitViewForm.get('musercd').markAsTouched();
      this.loanApprovalLimitViewForm.get('msrno').markAsTouched();
      this.loanApprovalLimitViewForm.get('mprdcd').markAsTouched();
      this.loanApprovalLimitViewForm.get('mlimitamt').markAsTouched();
      this.loanApprovalLimitViewForm.get('moverduedays').markAsTouched();
      this.loanApprovalLimitViewForm.get('mloanacmindrbal').markAsTouched();
      this.loanApprovalLimitViewForm.get('mloanacmincrbal').markAsTouched();
      this.loanApprovalLimitViewForm.get('mwriteoffamt').markAsTouched();
      this.loanApprovalLimitViewForm.get('mremarks').markAsTouched();
      this.loanApprovalLimitViewForm.get('mcheqlimitamt').markAsTouched();
      this.loanApprovalLimitViewForm.get('mminintrate').markAsTouched();
      this.loanApprovalLimitViewForm.get('mmaxintrate').markAsTouched();
      //this.loanApprovalLimitViewForm.get('mlastsynsdate').markAsTouched();
      return;
    }
  }

  onSubmit(data){
    this.validateForm();
    //console.log(data);
    //data.mlastsynsdate = this.apiservice.dateInIso(data.mlastsynsdate);

    if(this.productSel){
      data.mprdcd = this.productCodeSelectedVal;
    }else{
      data.mprdcd = this.loanApprovalViewData.mprdcd;
    }

    data.mlbrcode = this.loanApprovalViewData.loanApprovalLimitCompositeEntity.mlbrcode;
    data.mgrpcd = this.loanApprovalViewData.loanApprovalLimitCompositeEntity.mgrpcd;
    data.musercd = this.loanApprovalViewData.loanApprovalLimitCompositeEntity.musercd;
    data.msrno = this.loanApprovalViewData.loanApprovalLimitCompositeEntity.msrno;

    if (this.loanApprovalLimitViewForm.valid) {
      //console.log("Form Submitted!");
      this.apiservice.updateLoanApprovalLimit(data).subscribe(res =>{
        //console.log(res);
        if(res.merror == 200){
          //alert(res.merrormsg);
          this.updateArray[0] = true;
          this.updateArray[1] = res.merrormsg;
          this.updateArray[2] = true;

          //console.log(this.updateArray);
          this.router.navigate(['/loan-approval-limit-view'], { skipLocationChange: true, queryParams: this.updateArray });
        }else{
          //console.log('in');
          alert(res.merror);
        }
        //alert("Data Updated successfully.");
      });
      //this.loanApprovalLimitViewForm.reset();
    }

  }

  delete(){
    if(confirm("Are you sure to delete ?")) {
      this.deleteData.push(this.loanApprovalViewData.loanApprovalLimitCompositeEntity);
      //console.log(this.deleteData);
      let objCode = {code: this.deleteData};
      //console.log(objCode);
      this.apiservice.deleteLoanApprovalLimit(objCode).subscribe(res => {
        //console.log(res);
        if(res.merror == 200){
          //alert(res.merrormsg);
          this.deleteArray[0] = true;
          this.deleteArray[1] = res.merrormsg;
          this.deleteArray[2] = false;
          //console.log(this.deleteArray);
          this.router.navigate(['/loan-approval-limit-view'], { skipLocationChange: true, queryParams: this.deleteArray });
        }else{
          alert(res.merror);
        }
      });
    }
  }
  
}
