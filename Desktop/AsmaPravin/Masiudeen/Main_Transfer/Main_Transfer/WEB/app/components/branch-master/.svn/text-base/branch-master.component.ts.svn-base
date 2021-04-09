import { Component, OnInit, Input, ChangeDetectorRef } from '@angular/core';
import {FormGroup, FormControl, Validators} from '@angular/forms';
import { ApiService } from '../../services/api.service';
import {Router} from '@angular/router';
import { LocalStorageService } from '../../services/local-storage.service';

// declare var getDate: any;
// declare var getTime:any;
// declare var pageWrapperSpacing: any;
declare var dtSample: any;
declare var dismissModal:any;
declare var scrollToTop: any;


@Component({
  selector: 'app-branch-master',
  templateUrl: './branch-master.component.html',
  styleUrls: ['./branch-master.component.scss']
})
export class BranchMasterComponent implements OnInit {

  branchForm: FormGroup;
  branchTypeLookup:any;
  branchCatLookup: any;
  branchWeekLookup: any;
  //addAlert:boolean = false;
  addArray = [];
  code_exist:boolean = true;
  code_exist_message:any;
  //branch_code_val_type:boolean = false;
  reportingUserDropdown:any;
  countryDropdown:any;
  stateDropdown = [];
  districtDropdown = [];
  cityDropdown = [];

  highlightRow : Number;
  proceedButton:boolean = false;
  reportingUserSelectedVal:any;
  reportingUserDescription:any;
  
  constructor(private apiservice:ApiService, private router: Router, private storage: LocalStorageService, private chRef: ChangeDetectorRef) {
    this.branchForm = new FormGroup({
          
      mpbrcode: new FormControl('',[Validators.required,Validators.pattern("^[0-9]*$"),Validators.maxLength(10)]),
      madd1: new FormControl('',[Validators.maxLength(100)]),
      madd2: new FormControl('',[Validators.maxLength(100)]),
      madd3:new FormControl('',[Validators.maxLength(100)]),
      mbiccode: new FormControl('',[Validators.maxLength(15)]),
      mbranchcat:new FormControl('',[Validators.required]),
      mbranchemailid:new FormControl('',[Validators.maxLength(60)]),
      mbranchtype: new FormControl('',[Validators.required]),
      mbrnmanager: new FormControl('',[Validators.required]),
      mcountrycd: new FormControl('',[Validators.required]),
      mstate:new FormControl('',[Validators.required]),
      mdistrict:new FormControl('',[Validators.required]),
      mcitycd:new FormControl('',[Validators.required]),
      mfaxno1:new FormControl('',[Validators.maxLength(15)]),
      mformatndt:new FormControl('',[Validators.required]),
      mlastopendate:new FormControl,
      mlegacybrncd: new FormControl('',[Validators.required,Validators.maxLength(15)]),
      mmaxgroupmembers:new FormControl('',[Validators.pattern("^[0-9]*$"),Validators.maxLength(4)]),
      mmingroupmembers:new FormControl('',[Validators.pattern("^[0-9]*$"),Validators.maxLength(4)]),
      mname: new FormControl('',[Validators.required,Validators.maxLength(30)]),
      mparentbrcode:new FormControl('',[Validators.required,Validators.pattern("^[0-9]*$"),Validators.maxLength(10)]),
      mpincode: new FormControl('',[Validators.required,Validators.pattern("^[0-9]*$"),Validators.maxLength(8)]),
      msector: new FormControl('',[Validators.pattern("^[0-9]*$"),Validators.maxLength(4)]),
      mshortname:new  FormControl('',[Validators.maxLength(15)]),
      mswiftaddr:new FormControl('',[Validators.maxLength(15)]),
      mtele1: new FormControl('',[Validators.maxLength(15)]),
      mtele2: new FormControl('',[Validators.maxLength(15)]),
      mweekoff1:new FormControl,
      mweekoff2:new FormControl
      
      //Mandatory fields  
      // mlatitude: new FormControl,
      // mlogitude:new FormControl,
      // mgeolocation:new FormControl(''),
      // mcreateddt: new FormControl(''),
      // mcreatedby: new FormControl(''),
      // mlastupdateby: new FormControl(''),
      // missynctocoresys: new FormControl(''),
      // mlastsynsdate : new FormControl('')
     

    })
   }

   validateForm(){
    if (this.branchForm.invalid) {
      this.branchForm.get('mpbrcode').markAsTouched();
      this.branchForm.get('mbranchcat').markAsTouched();
      this.branchForm.get('mbranchtype').markAsTouched();
      this.branchForm.get('mbranchtype1').markAsTouched();
      this.branchForm.get('mbrnmanager').markAsTouched();
      this.branchForm.get('mcitycd').markAsTouched();
      this.branchForm.get('mcountrycd').markAsTouched();
      this.branchForm.get('mformatndt').markAsTouched();
      this.branchForm.get('mlegacybrncd').markAsTouched();
      this.branchForm.get('mname').markAsTouched();
      this.branchForm.get('mparentbrcode').markAsTouched();
      this.branchForm.get('mpincode').markAsTouched();
      this.branchForm.get('mstate').markAsTouched();
      return;
    }
  }

  ngOnInit() {
    //getDate(".datepicker");
    //getTime(".timepicker");
    //pageWrapperSpacing();

    //this.branchForm.controls.mbrnmanager.disable();

    this.reportingUserDropdown = this.storage.getSessionStorage('reportingUserDropdown');
    this.countryDropdown = this.storage.getSessionStorage('countryDropdown');

    let lookupData = this.storage.getSessionStorage('lookupData');
    this.branchTypeLookup = lookupData[1031];
    this.branchCatLookup = lookupData[78620];
    this.branchWeekLookup = lookupData[1019];
    //console.log(this.branchTypeLookup);

    setTimeout(function(){
      dtSample();
    },1000);
  }

  reportingUserSelected(val, desc, index){
    //console.log(val);
    this.highlightRow = index;
    this.proceedButton = true;
    this.reportingUserDescription = desc;
    this.reportingUserSelectedVal = val;
  }

  proceedActionUser(){
    this.branchForm.patchValue({
      mbrnmanager: this.reportingUserDescription
    });
    dismissModal();
  }

  getState(event){
    //console.log(event.target.value);
    let stateObj = {mcountryid : event.target.value};
    //console.log(stateObj);
    this.apiservice.stateListByCountry(stateObj).subscribe(res => {
      //console.log(res);
      this.stateDropdown = res;
    });
  }

  getDistrict(event){
    //console.log(event.target.value);
    let districtObj = {mstatecd : event.target.value};
    //console.log(districtObj);
    this.apiservice.districtListByState(districtObj).subscribe(res => {
      //console.log(res);
      this.districtDropdown = res;
    });
  }

  getCity(event){
    //console.log(event.target.value);
    let cityObj = {mdistcd : event.target.value};
    this.apiservice.cityListByDistrict(cityObj).subscribe(res => {
      //console.log(res);
      this.cityDropdown = res;
    });
  }

  // onKeyUp(val){
  //   //console.log(val);
  //   if(Number.isInteger(Number(val))){
  //     this.branch_code_val_type = true;
  //   }else{
  //     this.branch_code_val_type = false;
  //     this.branch_code_exist = false;
  //   }
  // }

  // onKeyUp(val){
  //   if(val !== "" && Number.isInteger(Number(val))){
  //     //console.log('Method called');
  //     let code = {mpbrcode: val};
  //     //console.log(code);
  //     this.apiservice.branchCodeExist(code).subscribe(res => {
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

  // checkCodeExist(val){
  //   console.log(val);
  //   //this.code_exist = true;
  //   //if(val !== "" && Number.isInteger(Number(val))){
  //     //console.log('Method called');
  //     let code = {mpbrcode: Number(val)};
  //     console.log(code);
  //     this.apiservice.branchCodeExist(code).subscribe(res => {
  //       console.log('in response');
  //       console.log(res);
  //       console.log(res.merror);
  //       if(res){
  //         if(res.merror == 200){
  //           this.code_exist = false;
  //           console.log(this.code_exist);
  //           scrollToTop();
  //           this.code_exist_message = res.merrormsg;
  //           //alert(res.merrormsg);
  //           return this.code_exist;
  //         }else{
  //           this.code_exist = true;
  //           return this.code_exist;
  //         }
  //       }
        
  //     });
  //   // }else{
  //   //   this.code_exist = true;
  //   //   //console.log('wrong input');
  //   // }
  //   //console.log(this.code_exist);
    
  // }

  onSubmit(data){
    this.validateForm();

    data.mbrnmanager = this.reportingUserSelectedVal;

    data.mformatndt = this.apiservice.dateInIso(data.mformatndt);
    data.mlastopendate = this.apiservice.dateInIso(data.mlastopendate);

    console.log(data);

    let code = {mpbrcode: Number(data.mpbrcode)};
    //console.log(code);
    this.apiservice.branchCodeExist(code).subscribe(res => {
      //console.log(res);
      if(res.merror == 200){
        this.code_exist = false;
        this.code_exist_message = res.merrormsg;
        scrollToTop();  
      }else{
        this.code_exist = true;

        if (this.branchForm.valid) {
          //console.log("idhr aaaya"+data);
          this.apiservice.postBranchData(data).subscribe(res => {
            //console.log(res);
            if(res.merror == 200){
              this.addArray[0] = true;
              this.addArray[1] = res.merrormsg;
              this.addArray[2] = true;
    
              //console.log(this.addArray);
              this.router.navigate(['/branch-master-view'], { skipLocationChange: true, queryParams: this.addArray });
            }else{
              alert(res.merror);
            }
          });
          this.branchForm.reset();
        }
        
      }
    });
    //if(!code_exist_res){
      // if (this.branchForm.valid) {
      //   // if (this.branchForm.valid && !this.code_exist) {
      //     console.log("idhr aaaya"+data);
      //     this.apiservice.postBranchData(data).subscribe(res => {
      //       //console.log(res);
      //       if(res.merror == 200){
      //         //this.addAlert = true;
      //         //console.log(this.addAlert);
      //         this.addArray[0] = true;
      //         this.addArray[1] = res.merrormsg;
      //         this.addArray[2] = true;
    
      //         //console.log(this.addArray);
      //         this.router.navigate(['/branch-master-view'], { skipLocationChange: true, queryParams: this.addArray });
      //       }else{
      //         alert(res.merror);
      //       }
      //     });
      //     this.branchForm.reset();
      //   }

    //}
    
    
  }
}
