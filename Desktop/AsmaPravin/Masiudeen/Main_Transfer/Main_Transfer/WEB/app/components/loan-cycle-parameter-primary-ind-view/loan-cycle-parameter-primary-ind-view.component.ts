import { Component, OnInit } from '@angular/core';
import {Router, ActivatedRoute} from '@angular/router';
import {FormGroup, FormControl, Validators} from '@angular/forms';
import { ApiService } from '../../services/api.service';
import { LocalStorageService } from '../../services/local-storage.service';

@Component({
  selector: 'app-loan-cycle-parameter-primary-ind-view',
  templateUrl: './loan-cycle-parameter-primary-ind-view.component.html',
  styleUrls: ['./loan-cycle-parameter-primary-ind-view.component.scss']
})
export class LoanCycleParameterPrimaryIndViewComponent implements OnInit {

  sub:any;
  page:any;
  primaryData:any;
  secondaryData:any;
  editActivated:boolean = false;
  formClass:string = "form-readcontroller";
  controlMandate:string = "";

  productDropdownData:any;
  branchDropdownData:any;

  loanCycleLookup:any;
  groupTypeLookup:any;
  customerTypeLookup:any;
  frequencyLookup:any;
  groupCycleLookup:any;
  groupCycleLogicLookup:any;
  ruleTypeLookup:any;
  genderLookup:any;

  selectedItem = 0
  tempcond =false
  showcodetype =false;
  updaterow = false;
  editIndex =null;
  primaryUpdate:boolean = true;
  rightsData:any;

  updateArray = [];
  deleteArray = [];
  deleteData = [];

  loanCycleParPriEditForm:FormGroup;

  constructor(private router: Router, private route: ActivatedRoute, private apiservice:ApiService, private storage: LocalStorageService) {
    this.loanCycleParPriEditForm = new FormGroup({
      mcusttype: new FormControl('',[Validators.required]),
      meffdate: new FormControl('',[Validators.required]),
      mgrtype: new FormControl('',[Validators.required]),
      mlbrcode: new FormControl('',[Validators.required]),
      mloancycle: new FormControl('',[Validators.required]),
      mprdcd: new FormControl('',[Validators.required]),
      mfrequency: new FormControl('',[Validators.required]),
      mgender: new FormControl(''),
      mgrpcycyn: new FormControl('',[Validators.required]),
      mincramount: new FormControl(''),
      mlogic: new FormControl(''),
      mmaxage: new FormControl('',[Validators.pattern("^[0-9]*$"),Validators.maxLength(2)]),
      //mmaxamount: new FormControl(''),
      mmaxnoofgrpmems: new FormControl('',[Validators.required,Validators.pattern("^[0-9]*$"),Validators.maxLength(8)]),
      mmaxperiod: new FormControl('',[Validators.pattern("^[0-9]*$"),Validators.maxLength(8)]),
      mminage: new FormControl('',[Validators.pattern("^[0-9]*$"),Validators.maxLength(2)]),
      //mminamount: new FormControl(''),
      mminnoofgrpmems: new FormControl('',[Validators.required,Validators.pattern("^[0-9]*$"),Validators.maxLength(8)]),
      mminperiod: new FormControl('',[Validators.pattern("^[0-9]*$"),Validators.maxLength(8)]),
      mmultiplefactor: new FormControl('',[Validators.pattern("^[0-9]*$"),Validators.maxLength(8)]),
      mnoofinstlclosure: new FormControl('',[Validators.pattern("^[0-9]*$"),Validators.maxLength(8)]),
      mtenor: new FormControl('',[Validators.pattern("^[0-9]*$"),Validators.maxLength(8)]),
      mruletype: new FormControl('',[Validators.required]),
      muptoamount: new FormControl('',[Validators.required,Validators.pattern("^[0-9]*$"),Validators.maxLength(30)]),
      mmaxamount: new FormControl('',[Validators.required,Validators.pattern("^[0-9]*$"),Validators.maxLength(30)]),
      mminamount: new FormControl('',[Validators.required,Validators.pattern("^[0-9]*$"),Validators.maxLength(30)])
    })
  }

  validateForm(){
    if (this.loanCycleParPriEditForm.invalid) {
      this.loanCycleParPriEditForm.get('mcusttype').markAsTouched();
      this.loanCycleParPriEditForm.get('meffdate').markAsTouched();
      this.loanCycleParPriEditForm.get('mgrtype').markAsTouched();
      this.loanCycleParPriEditForm.get('mlbrcode').markAsTouched();
      this.loanCycleParPriEditForm.get('mloancycle').markAsTouched();
      this.loanCycleParPriEditForm.get('mprdcd').markAsTouched();
      this.loanCycleParPriEditForm.get('mgrpcycyn').markAsTouched();
      this.loanCycleParPriEditForm.get('mmaxnoofgrpmems').markAsTouched();
      this.loanCycleParPriEditForm.get('mminnoofgrpmems').markAsTouched();
      return;
    }
  }

  ngOnInit() {

    this.rightsData = this.storage.getSessionStorage('rights');
    //console.log(this.rightsData);
    
    this.sub = this.route
      .queryParams
      .subscribe(params => {
        this.primaryData = JSON.parse(params.first);
        //console.log(this.primaryData);
        this.secondaryData = JSON.parse(params.second);
        console.log(this.secondaryData);
        
        //console.log("loanCycleDatapreview:" + JSON.stringify(this.primaryData));
    });

    this.branchDropdownData = this.storage.getSessionStorage('branchDropdownData');
    this.productDropdownData = this.storage.getSessionStorage('productDropdownData');

    let lookupData = this.storage.getSessionStorage('lookupData');
    this.loanCycleLookup = lookupData[909060];
    this.groupTypeLookup = lookupData[1076];
    this.customerTypeLookup = lookupData[1060];
    this.frequencyLookup = lookupData[909019];
    this.groupCycleLookup = lookupData[30125];
    this.groupCycleLogicLookup = lookupData[909061];
    this.ruleTypeLookup = lookupData[75559];
    this.genderLookup = lookupData[1139];
  }

  backToView(){
    this.editActivated = false;
    if(!this.editActivated){
      this.formClass = "form-readcontroller";
      this.controlMandate = "";
    }
  }

  updateInput(){
    this.showcodetype =true;
    this.loanCycleParPriEditForm.controls['mcusttype'].disable();
    this.loanCycleParPriEditForm.controls['meffdate'].disable();
    this.loanCycleParPriEditForm.controls['mgrtype'].disable();
    this.loanCycleParPriEditForm.controls['mlbrcode'].disable();
    this.loanCycleParPriEditForm.controls['mloancycle'].disable();
    this.loanCycleParPriEditForm.controls['mprdcd'].disable();

    this.loanCycleParPriEditForm.patchValue({
      mcusttype: this.primaryData.loanCycleParameterPrimaryCompositeEntity.mcusttype,
      meffdate: this.primaryData.loanCycleParameterPrimaryCompositeEntity.meffdate,
      mgrtype: this.primaryData.loanCycleParameterPrimaryCompositeEntity.mgrtype,
      mlbrcode: this.primaryData.loanCycleParameterPrimaryCompositeEntity.mlbrcode,
      mloancycle: this.primaryData.loanCycleParameterPrimaryCompositeEntity.mloancycle,
      mprdcd: this.primaryData.loanCycleParameterPrimaryCompositeEntity.mprdcd,
      mfrequency: this.primaryData.mfrequency,
      mgender: this.primaryData.mgender,
      mgrpcycyn: this.primaryData.mgrpcycyn,
      mincramount: this.primaryData.mincramount,
      mlogic: this.primaryData.mlogic,
      mmaxage: this.primaryData.mmaxage,
      //mmaxamount: this.primaryData.mmaxamount,
      mmaxnoofgrpmems: this.primaryData.mmaxnoofgrpmems,
      mmaxperiod: this.primaryData.mmaxperiod,
      mminage: this.primaryData.mminage,
      //mminamount: this.primaryData.mminamount,
      mminnoofgrpmems: this.primaryData.mminnoofgrpmems,
      mminperiod: this.primaryData.mminperiod,
      mmultiplefactor: this.primaryData.mmultiplefactor,
      mnoofinstlclosure: this.primaryData.mnoofinstlclosure,
      mtenor: this.primaryData.mtenor
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

  addNewRecords(data){
    console.log(this.primaryData.loanCycleParameterPrimaryCompositeEntity.meffdate);
    //this.primaryData.loanCycleParameterPrimaryCompositeEntity.meffdate = this.apiservice.dateInIso(this.primaryData.loanCycleParameterPrimaryCompositeEntity.meffdate);

    let newRecordBody =  {
      "mcusttype": this.primaryData.loanCycleParameterPrimaryCompositeEntity.mcusttype,
      "meffdate": this.primaryData.loanCycleParameterPrimaryCompositeEntity.meffdate,
      "mgrtype": this.primaryData.loanCycleParameterPrimaryCompositeEntity.mgrtype,
      "mlbrcode": this.primaryData.loanCycleParameterPrimaryCompositeEntity.mlbrcode,
      "mloancycle": this.primaryData.loanCycleParameterPrimaryCompositeEntity.mloancycle,
      "mprdcd": this.primaryData.loanCycleParameterPrimaryCompositeEntity.mprdcd,
      "mfrequency": data.mfrequency,
      "mgender": data.mgender,
      "mgrpcycyn": data.mgrpcycyn,
      "mincramount": data.mincramount,
      "mlogic": data.mlogic,
      "mmaxage": data.mmaxage,
      "mmaxnoofgrpmems": data.mmaxnoofgrpmems,
      "mmaxperiod": data.mmaxperiod,
      "mminage": data.mminage,
      "mminnoofgrpmems": data.mminnoofgrpmems,
      "mminperiod": data.mminperiod,
      "mmultiplefactor": data.mmultiplefactor,
      "mnoofinstlclosure": data.mnoofinstlclosure,
      "mtenor": data.mtenor,
      "mruletype": data.mruletype,
      "muptoamount": data.muptoamount,
      "mmaxamount": data.mmaxamount,
      "mminamount": data.mminamount
    }
    console.log(newRecordBody);
    
    this.apiservice.updateLoanCycleSecondary(newRecordBody).subscribe(res => {
    //this.apiservice.postLoanCycleParameterPrimary(newRecordBody).subscribe(res => {
        console.log(res);
        let api = this.apiservice;
        res.frequencyDesc = api.getLookupName(909019,res.mfrequency);
        res.ruleTypeDesc = api.getLookupName(75559,res.mruletype);
        alert(res.merrormsg);
        this.secondaryData.push({
        "loanCycleParameterSecondaryCompositeEntity": {
          "mcusttype": res.mcusttype,
          "meffdate": res.meffdate,
          "mfrequency": res.mfrequency,
          "mlbrcode": res.mlbrcode,
          "mprdcd": res.mprdcd,
          "mruletype": res.mruletype,
          "msrno": res.msrno,
        },
        "frequencyDesc": res.frequencyDesc,
        "ruleTypeDesc": res.ruleTypeDesc,
        "muptoamount": res.muptoamount,
        "mmaxamount": res.mmaxamount,
        "mminamount": res.mminamount
      } )
      //this.updateInput();
      // this.loanCycleParPriEditForm.patchValue({
      //   mruletype: '',
      //   muptoamount: '',
      //   mminamount: '',
      //   mmaxamount: '',
      
      // });
      this.loanCycleParPriEditForm.controls['mruletype'].setValue('')
      this.loanCycleParPriEditForm.controls['muptoamount'].setValue('')
      this.loanCycleParPriEditForm.controls['mmaxamount'].setValue('');
      this.loanCycleParPriEditForm.controls['mminamount'].setValue('');
      this.loanCycleParPriEditForm.controls['mruletype'].markAsUntouched();
      this.loanCycleParPriEditForm.controls['muptoamount'].markAsUntouched();
      this.loanCycleParPriEditForm.controls['mmaxamount'].markAsUntouched();
      this.loanCycleParPriEditForm.controls['mminamount'].markAsUntouched();
      this.loanCycleParPriEditForm.controls['mruletype'].markAsPristine();
      this.loanCycleParPriEditForm.controls['muptoamount'].markAsPristine();
      this.loanCycleParPriEditForm.controls['mmaxamount'].markAsPristine();
      this.loanCycleParPriEditForm.controls['mminamount'].markAsPristine();

      //this.updateInput();
    });  
}
removeRecords(data){
  console.log(this.secondaryData);
  console.log(data);

  //this.secondaryData[this.editIndex].loanCycleParameterSecondaryCompositeEntity.meffdate = this.apiservice.dateInIso(this.secondaryData[this.editIndex].loanCycleParameterSecondaryCompositeEntity.meffdate);

  let deleteBody =  {
    "mcusttype": this.secondaryData[this.editIndex].loanCycleParameterSecondaryCompositeEntity.mcusttype,
    "meffdate": this.secondaryData[this.editIndex].loanCycleParameterSecondaryCompositeEntity.meffdate,
    "mgrtype": this.secondaryData[this.editIndex].loanCycleParameterSecondaryCompositeEntity.mgrtype,
    "mlbrcode": this.secondaryData[this.editIndex].loanCycleParameterSecondaryCompositeEntity.mlbrcode,
    "mloancycle": this.secondaryData[this.editIndex].loanCycleParameterSecondaryCompositeEntity.mloancycle,
    "mprdcd": this.secondaryData[this.editIndex].loanCycleParameterSecondaryCompositeEntity.mprdcd,
    "mfrequency": this.secondaryData[this.editIndex].loanCycleParameterSecondaryCompositeEntity.mfrequency,
    "mruletype": data.mruletype,
    "msrno": this.secondaryData[this.editIndex].loanCycleParameterSecondaryCompositeEntity.msrno
  }
  console.log(deleteBody);
  this.apiservice.deleteLoanCycleParameterSecondary(deleteBody).subscribe(res => {
    console.log(res);
    if(res.merror == 200){
      //alert(res.merrormsg);
      this.deleteArray[0] = true;
      this.deleteArray[1] = res.merrormsg;
      this.deleteArray[2] = false;

      //console.log(this.updateArray);
      this.router.navigate(['/loan-cycle-parameter-primary-view'], { skipLocationChange: true, queryParams: this.deleteArray });
    }else{
      //console.log('in');
      alert(res.merror);
    }
    
  });
  
}
updateRecords(data){
  //console.log(data);

  let updateBody = {
    "mcusttype": this.primaryData.loanCycleParameterPrimaryCompositeEntity.mcusttype,
    "meffdate": this.primaryData.loanCycleParameterPrimaryCompositeEntity.meffdate,
    "mgrtype": this.primaryData.loanCycleParameterPrimaryCompositeEntity.mgrtype,
    "mlbrcode": this.primaryData.loanCycleParameterPrimaryCompositeEntity.mlbrcode,
    "mloancycle": this.primaryData.loanCycleParameterPrimaryCompositeEntity.mloancycle,
    "mprdcd": this.primaryData.loanCycleParameterPrimaryCompositeEntity.mprdcd,
    "mfrequency": this.primaryData.mfrequency,
    'msrno': this.secondaryData[this.editIndex].loanCycleParameterSecondaryCompositeEntity.msrno,
    "mruletype": data.mruletype,
    "muptoamount": data.muptoamount,
    "mmaxamount": data.mmaxamount,
    "mminamount": data.mminamount
    // "loanCycleParameterPrimaryCompositeEntity": {
    //   "mcusttype": data.mcusttype,
    //   "meffdate": data.meffdate,
    //   "mfrequency": data.mfrequency,
    //   "mlbrcode": data.mlbrcode,
    //   "mprdcd": data.mprdcd,
    //   "mruletype": data.mruletype,
    //   "msrno": data.msrno,
    // },
  }
  console.log(updateBody);
  this.apiservice.updateLoanCycleSecondary(updateBody).subscribe(res => {
  //this.apiservice.updateLoanCycleParameterPrimary(updateBody).subscribe(res => {
    console.log(res);
   
    this.secondaryData[this.editIndex].mruletype = res.mruletype;
    this.secondaryData[this.editIndex].muptoamount = data.muptoamount;
    this.secondaryData[this.editIndex].mmaxamount = data.mmaxamount;
    this.secondaryData[this.editIndex].mminamount = data.mminamount;
    //alert(res.merrormsg);
    this.updateInput();
    this.editfield(false,'','');
    this.tempcond = false;

    if(res.merror == 200){
      //alert(res.merrormsg);
      this.updateArray[0] = true;
      this.updateArray[1] = res.merrormsg;
      this.updateArray[2] = true;

      //console.log(this.updateArray);
      this.router.navigate(['/loan-cycle-parameter-primary-view'], { skipLocationChange: true, queryParams: this.updateArray });
    }else{
      //console.log('in');
      alert(res.merror);
    }
  });
  
}


  editfield(val, list , index ){
    console.log(list);
    console.log("val :" + val);
    if(val){
      this.editIndex = index;
      this.updaterow = true;
      this.tempcond = true;
      this.selectedItem = index;
      this.primaryUpdate = false;
      console.log(this.selectedItem);
          this.loanCycleParPriEditForm.patchValue({
            mruletype: list.loanCycleParameterSecondaryCompositeEntity.mruletype,
            muptoamount: list.muptoamount,
            mminamount: list.mminamount,
            mmaxamount: list.mmaxamount,
          
          });
    }else{
      this.editIndex = null;
      this.updaterow = false
      this.tempcond =false;
      this.selectedItem = 0;
      this.primaryUpdate = true;
      this.loanCycleParPriEditForm.patchValue({
        mruletype: '',
        muptoamount: '',
        mminamount: '',
        mmaxamount: '',
      
      });

    }

  }

  onSubmit(data){
    console.log(data);
    this.loanCycleParPriEditForm.get('mruletype').clearValidators();
    this.loanCycleParPriEditForm.get('mruletype').updateValueAndValidity();
    this.loanCycleParPriEditForm.get('muptoamount').clearValidators();
    this.loanCycleParPriEditForm.get('muptoamount').updateValueAndValidity();
    this.loanCycleParPriEditForm.get('mmaxamount').clearValidators();
    this.loanCycleParPriEditForm.get('mmaxamount').updateValueAndValidity();
    this.loanCycleParPriEditForm.get('mminamount').clearValidators();
    this.loanCycleParPriEditForm.get('mminamount').updateValueAndValidity();

    this.validateForm();
    
    let updateData = {
      "mcusttype": this.primaryData.loanCycleParameterPrimaryCompositeEntity.mcusttype,
      "meffdate": this.primaryData.loanCycleParameterPrimaryCompositeEntity.meffdate,
      "mgrtype": this.primaryData.loanCycleParameterPrimaryCompositeEntity.mgrtype,
      "mlbrcode": this.primaryData.loanCycleParameterPrimaryCompositeEntity.mlbrcode,
      "mloancycle": this.primaryData.loanCycleParameterPrimaryCompositeEntity.mloancycle,
      "mprdcd": this.primaryData.loanCycleParameterPrimaryCompositeEntity.mprdcd,
      "mfrequency": data.mfrequency,
      "mgender": data.mgender,
      "mgrpcycyn": data.mgrpcycyn,
      "mincramount": data.mincramount,
      "mlogic": data.mlogic,
      "mmaxage": data.mmaxage,
      "mmaxnoofgrpmems": data.mmaxnoofgrpmems,
      "mmaxperiod": data.mmaxperiod,
      "mminage": data.mminage,
      "mminnoofgrpmems": data.mminnoofgrpmems,
      "mminperiod": data.mminperiod,
      "mmultiplefactor": data.mmultiplefactor,
      "mnoofinstlclosure": data.mnoofinstlclosure

    };
    console.log(updateData);
    //data.meffdate = this.apiservice.dateInIso(data.meffdate);
    //console.log(data);
    
    if (this.loanCycleParPriEditForm.valid) {
      //console.log("Form Submitted!");
      this.apiservice.updateLoanCycleParameterPrimary(updateData).subscribe(res => {
        console.log(res);
        if(res.merror == 200){
          //alert(res.merrormsg);
          this.updateArray[0] = true;
          this.updateArray[1] = res.merrormsg;
          this.updateArray[2] = true;

          //console.log(this.updateArray);
          this.router.navigate(['/loan-cycle-parameter-primary-view'], { skipLocationChange: true, queryParams: this.updateArray });
        }else{
          //console.log('in');
          alert(res.merror);
        }
        // if(res.merror == 200){
        //   alert(res.merrormsg);
        // }else{
        //   alert(res.merror);
        // }
        //this.router.navigate(['/branch-master']);
      });
      //this.userForm.reset();
     }else{
      console.log('error');
     }
  }

  delete(){
    if(confirm("Are you sure to delete ?")) {
      this.deleteData.push(this.primaryData.loanCycleParameterPrimaryCompositeEntity);
      //console.log(this.deleteData);
      let objCode = this.deleteData;
      //console.log(objCode);
      this.apiservice.deleteLoanCycleParameterPrimary(objCode).subscribe(res => {
        //console.log(res);
        if(res.merror == 200){
          //alert(res.merrormsg);
          this.deleteArray[0] = true;
          this.deleteArray[1] = res.merrormsg;
          this.deleteArray[2] = false;
    
          //console.log(this.updateArray);
          this.router.navigate(['/loan-cycle-parameter-primary-view'], { skipLocationChange: true, queryParams: this.deleteArray });
        }else{
          //console.log('in');
          alert(res.merror);
        }
      });
    }
  }

}
