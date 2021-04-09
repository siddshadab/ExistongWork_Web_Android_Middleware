import { Component, OnInit, ChangeDetectorRef } from '@angular/core';
import {FormGroup, FormControl, Validators, FormArray} from '@angular/forms';
import { ApiService } from '../../services/api.service';
import {Router} from '@angular/router';
import { LocalStorageService } from '../../services/local-storage.service';

declare var dtSample1: any;
declare var dtSample2: any;
declare var dismissModal:any;

@Component({
  selector: 'app-loan-cycle-parameter-primary',
  templateUrl: './loan-cycle-parameter-primary.component.html',
  styleUrls: ['./loan-cycle-parameter-primary.component.scss']
})
export class LoanCycleParameterPrimaryComponent implements OnInit {

  loanCycleParPriForm:FormGroup;
  dataList: FormArray;
  loanCycleListPreview:any = [];
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

  addArray = [];

  dynamicArray:any = [];  
  newDynamic:any = {};

  highlightRowBranch : Number;
  proceedButtonBranch:boolean = false;
  branchCodeDescription:any;
  branchCodeSelectedVal:any;
  highlightRowProduct : Number;
  proceedButtonProduct:boolean = false;
  productCodeDescription:any;
  productCodeSelectedVal:any;

  constructor(private apiservice:ApiService, private router: Router, private storage: LocalStorageService, private chRef: ChangeDetectorRef) {
    this.loanCycleParPriForm = new FormGroup({
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
      mmaxnoofgrpmems: new FormControl('',[Validators.required,Validators.pattern("^[0-9]*$"),Validators.maxLength(8)]),
      mmaxperiod: new FormControl('',[Validators.pattern("^[0-9]*$"),Validators.maxLength(8)]),
      mminage: new FormControl('',[Validators.pattern("^[0-9]*$"),Validators.maxLength(2)]),
      mminnoofgrpmems: new FormControl('',[Validators.required,Validators.pattern("^[0-9]*$"),Validators.maxLength(8)]),
      mminperiod: new FormControl('',[Validators.pattern("^[0-9]*$"),Validators.maxLength(8)]),
      mmultiplefactor: new FormControl('',[Validators.pattern("^[0-9]*$"),Validators.maxLength(8)]),
      mnoofinstlclosure: new FormControl('',[Validators.pattern("^[0-9]*$"),Validators.maxLength(8)]),
      mtenor: new FormControl('',[Validators.pattern("^[0-9]*$"),Validators.maxLength(8)]),
      // mfrequency1: new FormControl('',[Validators.required]),
      mruletype: new FormControl('',[Validators.required]),
      muptoamount: new FormControl('',[Validators.required,Validators.pattern("^[0-9]*$"),Validators.maxLength(30)]),
      mmaxamount: new FormControl('',[Validators.required,Validators.pattern("^[0-9]*$"),Validators.maxLength(30)]),
      mminamount: new FormControl('',[Validators.required,Validators.pattern("^[0-9]*$"),Validators.maxLength(30)])
      //datas: items
      // datas: new FormArray([
      //   new FormGroup({ 'itemQty': new FormControl(null), 'itemName': new FormControl(null)})
      // ]) 
    })
  }



  // get datas(){
  //   return this.loanCycleParPriForm.get('datas') as FormArray;
  // }

  // addNewRow(){
  //   let items = new FormArray([new FormGroup({ 'itemQty': new FormControl(null), 'itemName': new FormControl(null)})])
  //   this.datas.push(items);
  // }

  validateForm(){
    if (this.loanCycleParPriForm.invalid) {
      this.loanCycleParPriForm.get('mcusttype').markAsTouched();
      this.loanCycleParPriForm.get('meffdate').markAsTouched();
      this.loanCycleParPriForm.get('mgrtype').markAsTouched();
      this.loanCycleParPriForm.get('mlbrcode').markAsTouched();
      this.loanCycleParPriForm.get('mloancycle').markAsTouched();
      this.loanCycleParPriForm.get('mprdcd').markAsTouched();
      this.loanCycleParPriForm.get('mfrequency').markAsTouched();
      this.loanCycleParPriForm.get('mgrpcycyn').markAsTouched();
      this.loanCycleParPriForm.get('mmaxnoofgrpmems').markAsTouched();
      this.loanCycleParPriForm.get('mminnoofgrpmems').markAsTouched();
      this.loanCycleParPriForm.get('mruletype').markAsTouched();
      this.loanCycleParPriForm.get('muptoamount').markAsTouched();
      this.loanCycleParPriForm.get('mmaxamount').markAsTouched();
      this.loanCycleParPriForm.get('mminamount').markAsTouched();
      return;
    }
  }

  ngOnInit() {
    
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
    //console.log(this.groupTypeLookup);
    // this.newDynamic = {name: "", email: "",phone:""};  
    // this.dynamicArray.push(this.newDynamic);

    setTimeout(function(){
      dtSample1();
      dtSample2();
    },1000);
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

  proceedActionBranch(){
    this.loanCycleParPriForm.patchValue({
      mlbrcode: this.branchCodeDescription  
    });
    dismissModal();
  }

  proceedActionProduct(){
    this.loanCycleParPriForm.patchValue({
      mprdcd: this.productCodeDescription  
    });
    dismissModal();
  }

  // addRow() {    
  //   this.newDynamic = {name: "", email: "",phone:""};  
  //   this.dynamicArray.push(this.newDynamic);
  //   console.log(this.dynamicArray);  
  //   return true;  
  // }

  deleteRow(index){
    if(this.loanCycleListPreview.length > 1){
      this.loanCycleListPreview.splice(index, 1);


    }else{
      this.loanCycleListPreview.splice(index, 1);
      this.loanCycleListPreview.controls['mlbrcode'].enable();
      this.loanCycleListPreview.controls['mloancycle'].enable();
      this.loanCycleListPreview.controls['mgrtype'].enable()
      this.loanCycleListPreview.controls['mprdcd'].enable()
    }
    
  }

  onSubmit(data){
    this.validateForm();
    let submitData = this.loanCycleParPriForm.getRawValue();
    //console.log(submitData);
    console.log(this.loanCycleListPreview.length);

    if (this.loanCycleParPriForm.valid) {

      submitData.mlbrcode = this.branchCodeSelectedVal;
      submitData.mprdcd = this.productCodeSelectedVal;

      this.loanCycleListPreview.push(  {
        "mcusttype": submitData.mcusttype,
        "meffdate": submitData.meffdate,
        "mgrtype": submitData.mgrtype,
        "mlbrcode": submitData.mlbrcode,
        "mloancycle": submitData.mloancycle,
        "mprdcd": submitData.mprdcd,
        "mfrequency": submitData.mfrequency,
        "mgender": submitData.mgender,
        "mgrpcycyn": submitData.mgrpcycyn,
        "mincramount": submitData.mincramount,
        "mlogic": submitData.mlogic,
        "mmaxage": submitData.mmaxage,
        "mmaxnoofgrpmems": submitData.mmaxnoofgrpmems,
        "mmaxperiod": submitData.mmaxperiod,
        "mminage": submitData.mminage,
        "mminnoofgrpmems": submitData.mminnoofgrpmems,
        "mminperiod": submitData.mminperiod,
        "mmultiplefactor": submitData.mmultiplefactor,
        "mnoofinstlclosure": submitData.mnoofinstlclosure,
        "mtenor": submitData.mtenor,
        "mruletype": submitData.mruletype,
        "muptoamount": submitData.muptoamount,
        "mmaxamount": submitData.mmaxamount,
        "mminamount": submitData.mminamount
      }); 

      this.loanCycleParPriForm.controls['mruletype'].setValue('Select');
      this.loanCycleParPriForm.controls['muptoamount'].setValue('');
      this.loanCycleParPriForm.controls['mmaxamount'].setValue('');
      this.loanCycleParPriForm.controls['mminamount'].setValue('');
      this.loanCycleParPriForm.controls['mruletype'].markAsPristine();
      this.loanCycleParPriForm.controls['muptoamount'].markAsPristine();
      this.loanCycleParPriForm.controls['mmaxamount'].markAsPristine();
      this.loanCycleParPriForm.controls['mminamount'].markAsPristine();
      this.loanCycleParPriForm.controls['mruletype'].markAsUntouched();
      this.loanCycleParPriForm.controls['muptoamount'].markAsUntouched();
      this.loanCycleParPriForm.controls['mmaxamount'].markAsUntouched();
      this.loanCycleParPriForm.controls['mminamount'].markAsUntouched();
      //this.loanCycleParPriForm.controls['mlbrcode'].disable();
      //this.loanCycleParPriForm.controls['mloancycle'].disable();
      //this.loanCycleParPriForm.controls['mgrtype'].disable();
      //this.loanCycleParPriForm.controls['mprdcd'].disable();


    }

    console.log(this.loanCycleListPreview.length);

  }

  submitFinalForm(data){
    console.log(data);
    data.meffdate = this.apiservice.dateInIso(data.meffdate);

    let primarySubmit = {
        "mcusttype": data.mcusttype,
        "meffdate": data.meffdate,
        "mgrtype": data.mgrtype,
        "mlbrcode": data.mlbrcode,
        "mloancycle": data.mloancycle,
        "mprdcd": data.mprdcd,
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
        "mtenor": data.mtenor
    }
    console.log(primarySubmit);
    this.apiservice.postLoanCycleParameterPrimary(primarySubmit).subscribe(res => {
      console.log(res);
      //alert("Success");
      //this.loanCycleListPreview.splice(i, 1);
      //console.log("loanCyclelistpreview:" + JSON.stringify( this.loanCycleListPreview))
    });

    console.log("count :" + this.loanCycleListPreview.length);
    if(this.loanCycleListPreview.length > 0){

      for(var i=0; i< this.loanCycleListPreview.length ; i++){

        this.loanCycleListPreview[i].meffdate = this.apiservice.dateInIso(this.loanCycleListPreview[i].meffdate);
  
        let newRecordBody =  {
          "mcusttype": this.loanCycleListPreview[i].mcusttype,
          "meffdate": this.loanCycleListPreview[i].meffdate,
          "mgrtype": this.loanCycleListPreview[i].mgrtype,
          "mlbrcode": this.loanCycleListPreview[i].mlbrcode,
          "mloancycle": this.loanCycleListPreview[i].mloancycle,
          "mprdcd": this.loanCycleListPreview[i].mprdcd,
          "mfrequency": this.loanCycleListPreview[i].mfrequency,
          "mruletype": this.loanCycleListPreview[i].mruletype,
          "muptoamount": this.loanCycleListPreview[i].muptoamount,
          "mmaxamount": this.loanCycleListPreview[i].mmaxamount,
          "mminamount": this.loanCycleListPreview[i].mminamount
        }
        console.log(newRecordBody);
        this.apiservice.postLoanCycleParameterSecondary(newRecordBody).subscribe(res => {
          console.log(res);
          //alert();
          this.loanCycleListPreview.splice(i, 1);
          console.log("loanCyclelistpreview:" + JSON.stringify( this.loanCycleListPreview));

          if(res.merror == 200){
            //alert(res.merrormsg);
            this.addArray[0] = true;
            this.addArray[1] = res.merrormsg;
            this.addArray[2] = true;
  
            //console.log(this.addArray);
            this.router.navigate(['/loan-cycle-parameter-primary-view'], { skipLocationChange: true, queryParams: this.addArray });
          }else{
            alert(res.merror);
          }
        });
     
      }

    }
    



    //console.log("count :" + this.loanCycleListPreview.length);
    // for(var i=0; i< this.loanCycleListPreview.length ; i++){

    //   this.loanCycleListPreview[i].meffdate = this.apiservice.dateInIso(this.loanCycleListPreview[i].meffdate);

    //   let newRecordBody =  {
    //     "mcusttype": this.loanCycleListPreview[i].mcusttype,
    //     "meffdate": this.loanCycleListPreview[i].meffdate,
    //     "mgrtype": this.loanCycleListPreview[i].mgrtype,
    //     "mlbrcode": this.loanCycleListPreview[i].mlbrcode,
    //     "mloancycle": this.loanCycleListPreview[i].mloancycle,
    //     "mprdcd": this.loanCycleListPreview[i].mprdcd,
    //     "mfrequency": this.loanCycleListPreview[i].mfrequency,
    //     "mgender": this.loanCycleListPreview[i].mgender,
    //     "mgrpcycyn": this.loanCycleListPreview[i].mgrpcycyn,
    //     "mincramount": this.loanCycleListPreview[i].mincramount,
    //     "mlogic": this.loanCycleListPreview[i].mlogic,
    //     "mmaxage": this.loanCycleListPreview[i].mmaxage,
    //     "mmaxnoofgrpmems": this.loanCycleListPreview[i].mmaxnoofgrpmems,
    //     "mmaxperiod": this.loanCycleListPreview[i].mmaxperiod,
    //     "mminage": this.loanCycleListPreview[i].mminage,
    //     "mminnoofgrpmems": this.loanCycleListPreview[i].mminnoofgrpmems,
    //     "mminperiod": this.loanCycleListPreview[i].mminperiod,
    //     "mmultiplefactor": this.loanCycleListPreview[i].mmultiplefactor,
    //     "mnoofinstlclosure": this.loanCycleListPreview[i].mnoofinstlclosure,
    //     "mtenor": this.loanCycleListPreview[i].mtenor,
    //     "mruletype": this.loanCycleListPreview[i].mruletype,
    //     "muptoamount": this.loanCycleListPreview[i].muptoamount,
    //     "mmaxamount": this.loanCycleListPreview[i].mmaxamount,
    //     "mminamount": this.loanCycleListPreview[i].mminamount
    //   }
    //   console.log(newRecordBody);
    //   this.apiservice.postLoanCycleParameterPrimary(newRecordBody).subscribe(res => {
    //     console.log(res);
    //     alert();
    //     this.loanCycleListPreview.splice(i, 1);
    //     console.log("loanCyclelistpreview:" + JSON.stringify( this.loanCycleListPreview))
    //   });
   
    // }

  }

  // counter:number;
  onSubmitOld(data){
    //console.log("data is :" + this.loanCycleParPriForm.get(['datas','0']).value);
    // this.counter = 0;
    // for(let dat of this.datas.controls){
    //   console.log("Datas "+ this.loanCycleParPriForm.get(['datas',this.counter]).value);
    //   this.counter = this.counter+1;
    // }
    // this.validateForm();

    // data.meffdate = this.apiservice.dateInIso(data.meffdate);
    // //console.log(data);
    
    // if (this.loanCycleParPriForm.valid) {
    //   //console.log("Form Submitted!");
    //   this.apiservice.postLoanCycleParameterPrimary(data).subscribe(res => {
    //     //console.log(res);
    //     alert("Loan Cycle added successfully !");
    //     this.router.navigate(['/loan-cycle-parameter-primary']);
    //   });
    //   this.loanCycleParPriForm.reset();
    // }
  }

}
