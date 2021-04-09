import { ApiService } from '../../services/api.service';
import { Router, ActivatedRoute } from '@angular/router';
import { LocalStorageService } from './../../services/local-storage.service';
import { AppComponent } from './../../app.component';
import { FormGroup, FormControl, Validators } from '@angular/forms';
import { Component, OnInit, Input } from '@angular/core';

declare var dtSample2: any;
declare var dismissModal:any;

@Component({
  selector: 'app-loan-level-ind-view',
  templateUrl: './loan-level-ind-view.component.html',
  styleUrls: ['./loan-level-ind-view.component.scss']
})
export class LoanLevelIndViewComponent implements OnInit {

  sub:any;
  page:any;
  userList:any;
  loanLvlData:any;
  editActivated:boolean = false;
  formClass:string = "form-readcontroller";
  controlMandate:string = "";
  deleteData = [];

  updateArray = [];
  deleteArray = [];
  rightsData:any;
  productDropdownData:any;
  productDropName:any;

  highlightRowProduct : Number;
  proceedButtonProduct:boolean = false;
  productCodeDescription:any;
  productCodeSelectedVal:any;
  productSel:boolean = false;

  @Input() listData:[];

  loanLvlForm:FormGroup;

  constructor(private apiservice:ApiService,private route: ActivatedRoute, private router: Router, private storage: LocalStorageService, public myapp: AppComponent) {

    this.loanLvlForm = new FormGroup({

      // mrefno: new FormControl('',[Validators.required,Validators.pattern("^[0-9]*$"),Validators.maxLength(8)]),
      mbuttonid: new FormControl('',[Validators.required,Validators.pattern("^[0-9]*$"),Validators.maxLength(2)]),
      mbuttonname: new FormControl('',[Validators.required,Validators.maxLength(30)]),
      //mproductname: new FormControl('',[Validators.required,Validators.maxLength(75)]),
      mstageid: new FormControl('',[Validators.required,Validators.pattern("^[0-9]*$"),Validators.maxLength(4)]),
      mprdcd: new FormControl('',[Validators.required]),
      morderid: new FormControl('',[Validators.required,Validators.pattern("^[0-9]*$"),Validators.maxLength(2)]),
      mismandatory: new FormControl('',[Validators.required]),     
     
    });
   }

   ngOnInit() {
    
    this.rightsData = this.storage.getSessionStorage('rights');
    //console.log(this.rightsData);

    this.productDropdownData = this.storage.getSessionStorage('productDropdownData');
    
    this.sub = this.route
      .queryParams
      .subscribe(params => {
        //console.log(params);
        this.loanLvlData = params;
      });

    this.productDropName = this.productDropdownData.find(e => e.mprdCd == this.loanLvlData.mprdcd);
    //console.log(this.reportUsrName);

    if(this.productDropName){
      this.productDropName = this.productDropName.mname;
    }else{
      this.productDropName = this.loanLvlData.mprdcd;
    }

    setTimeout(function(){
      dtSample2();
    },1000);
  }

   updateInput(){
    this.loanLvlForm.patchValue({
      // mrefno:this.loanLvlData.mrefno,
      mbuttonid:this.loanLvlData.mbuttonid,
      mbuttonname:this.loanLvlData.mbuttonname,
      //mproductname:this.loanLvlData.mproductname,
      mstageid:this.loanLvlData.mstageid,
      mprdcd:this.productDropName,
      morderid:this.loanLvlData.morderid,
      mismandatory:this.loanLvlData.mismandatory,
    });
  }

  backToView(){
    this.editActivated = false;
    if(!this.editActivated){
      this.formClass = "form-readcontroller";
      this.controlMandate = "";
    }
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
    this.loanLvlForm.patchValue({
      mprdcd: this.productCodeDescription  
    });
    dismissModal();
  }

  edit(){
    this.editActivated = true;
    this.updateInput();
    if(this.editActivated){
      this.formClass = "form-controller";
      this.controlMandate = "control-mandatory";
    }
  }

  delete(){
    if(confirm("Are you sure to delete ?")) { 
      this.deleteData.push(this.loanLvlData.mrefno);
      //console.log(this.deleteData);
      let objCode = {mrefno: this.deleteData};
      //let objMrefNo = {musrcode: this.loanLvlData.mrefno};       
      this.apiservice.deleteLoanLvl(objCode).subscribe(res => {
        //console.log(res);
        if(res.merror == 200){
          //alert(res.merrormsg);
          this.deleteArray[0] = true;
          this.deleteArray[1] = res.merrormsg;
          this.deleteArray[2] = false;
          //console.log(this.deleteArray);
          this.router.navigate(['/loan-level-view'], { skipLocationChange: true, queryParams: this.deleteArray });
        }else{
          alert(res.merror);
        }        
      });     
    }
  }

  onSubmit(data){
    //console.log(data);

    if(this.productSel){
      data.mprdcd = this.productCodeSelectedVal;
    }else{
      data.mprdcd = this.loanLvlData.mprdcd;
    }
    
    if (this.loanLvlForm.valid) {
      //console.log("Form Submitted!");
      this.apiservice.editLoanLvl(data).subscribe(res => {
        //console.log(res);
        //console.log(res.merrormsg);
        if(res.merror == 200){
          //alert(res.merrormsg);
          this.updateArray[0] = true;
          this.updateArray[1] = res.merrormsg;
          this.updateArray[2] = true;

          //console.log(this.updateArray);
          this.router.navigate(['/loan-level-view'], { skipLocationChange: true, queryParams: this.updateArray });
        }else{
          alert(res.merror);
        }
        //alert("Record updated successfully !");        
      });      
    }
  }


}