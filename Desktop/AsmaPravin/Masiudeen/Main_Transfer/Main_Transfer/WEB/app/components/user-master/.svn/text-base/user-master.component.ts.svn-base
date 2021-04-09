import { Component, OnInit, Input, ChangeDetectorRef } from '@angular/core';
import {FormGroup, FormControl, Validators} from '@angular/forms';
import { ApiService } from '../../services/api.service';
import {Router} from '@angular/router';
import { LocalStorageService } from '../../services/local-storage.service';
import { AppComponent } from '../../app.component';
import * as moment from 'moment';

//declare var getDate: any;
//declare var pageWrapperSpacing: any;
//let AppComponentObject = new AppComponent;
declare var dtSample: any;
declare var dtSample1: any;
declare var scrollToTop: any;
declare var dismissModal:any;

@Component({
  selector: 'app-user-master',
  templateUrl: './user-master.component.html',
  styleUrls: ['./user-master.component.scss']
})
export class UserMasterComponent implements OnInit {
  date: moment.Moment;
  //newdate: moment.Moment;
  //date = moment()
  //console.log(this.date.)
  finaldata;
  userForm:FormGroup;
  dateData:any;
  dateDatas:any;
  nextSysDate:any;
  lastPwdChDate:any;
  genderLookup:any;
  statusLookup:any;
  groupCodeLookup:any;
  addArray = [];
  code_exist:boolean = true;
  code_exist_message:any;
  branchDropdownData:any;
  reportingUserDropdown:any;

  highlightRowUser : Number;
  proceedButtonUser :boolean = false;
  reportingUserSelectedVal:any;
  reportingUserDescription:any;
  highlightRowBranch : Number;
  proceedButtonBranch :boolean = false;
  branchCodeDescription:any;
  branchCodeSelectedVal:any;

  constructor(private apiservice:ApiService, private router: Router, private storage: LocalStorageService, public myapp: AppComponent, private chRef: ChangeDetectorRef) { 
    
    this.userForm = new FormGroup({
      //mgeolatd: new FormControl('',[Validators.required]),
      //mgeologd: new FormControl('',[Validators.required]),
      musrcode: new FormControl('',[Validators.required,Validators.maxLength(8)]),
      musrname: new FormControl('',[Validators.required,Validators.maxLength(35)]),
      musrshortname: new FormControl('',[Validators.required,Validators.maxLength(10)]),
      mgender: new FormControl('',[Validators.required]),
      //musrdesignation: new FormControl('',[Validators.required]),
      memailid: new FormControl('',[Validators.required]),
      mmobile: new FormControl('',[Validators.required]),
      musrbrcode: new FormControl('',[Validators.required]),
      mautologoutperiod: new FormControl('',[Validators.required]),
      //mautologoutyn: new FormControl('',[Validators.required]),
      mmaxbadlginperday: new FormControl('',[Validators.required]),
      mnextsyslgindt: new FormControl(''),
      mmaxbadlginperinst: new FormControl('',[Validators.required]),
      mnoofbadlogins: new FormControl('',[Validators.required]),
      //mbadloginsdt: new FormControl(''),
      musrpass: new FormControl('',[Validators.required]),
      mlastpwdchgdt: new FormControl(''),
      mpwdchgperioddays: new FormControl('',[Validators.required,Validators.maxLength(8)]),
      mpwdchgforcedyn: new FormControl('',[Validators.required]),
      mnextpwdchgdt: new FormControl(''),
      mgrpcd: new FormControl('',[Validators.required]),
      mjoindate: new FormControl(''),
      mlastsyslidt: new FormControl(''),
      mregdevicemacid: new FormControl('',[Validators.required]),
      mreportinguser: new FormControl('',[Validators.required]),
      mstatus: new FormControl('',[Validators.required]),
      mreason: new FormControl('',[Validators.required]),
      msusdate: new FormControl(''),
      //mpermnum: new FormControl('',[Validators.required,Validators.maxLength(10)]),
      //mlogcode: new FormControl('',[Validators.required,Validators.maxLength(10)]),
      //mreportman: new FormControl('',[Validators.required]),
      //mperinstance: new FormControl('',[Validators.required]),
      //mlogotherbranch: new FormControl('',[Validators.required]),
      //mmultibracc: new FormControl('',[Validators.required]),
      //mdaysfreq: new FormControl('',[Validators.required,Validators.maxLength(8)]),
      mcustaccesslvl: new FormControl('',[Validators.required]),
      //moldpass1: new FormControl('',[Validators.required])      
    })
  }

  // onValueChange(value): void {
  //   console.log(value);
    
  // }

  validateUserMasterForm(){
    if (this.userForm.invalid) {
      //this.userForm.get('mgeolatd').markAsTouched();
      //this.userForm.get('mgeologd').markAsTouched();
      this.userForm.get('musrcode').markAsTouched();
      this.userForm.get('musrname').markAsTouched();
      this.userForm.get('musrshortname').markAsTouched();
      this.userForm.get('mgender').markAsTouched();
      //this.userForm.get('musrdesignation').markAsTouched();
      this.userForm.get('memailid').markAsTouched();
      this.userForm.get('mmobile').markAsTouched();
      this.userForm.get('musrbrcode').markAsTouched();
      this.userForm.get('mautologoutperiod').markAsTouched();
      //this.userForm.get('mautologoutyn').markAsTouched();
      this.userForm.get('mmaxbadlginperday').markAsTouched();
      this.userForm.get('mnextsyslgindt').markAsTouched();
      this.userForm.get('mmaxbadlginperinst').markAsTouched();
      this.userForm.get('mnoofbadlogins').markAsTouched();
      this.userForm.get('musrpass').markAsTouched();
      //this.userForm.get('mlastpwdchgdt').markAsTouched();
      this.userForm.get('mpwdchgperioddays').markAsTouched();
      this.userForm.get('mpwdchgforcedyn').markAsTouched();
      this.userForm.get('mnextpwdchgdt').markAsTouched();
      this.userForm.get('mgrpcd').markAsTouched();
      this.userForm.get('mjoindate').markAsTouched();
      this.userForm.get('mlastsyslidt').markAsTouched();
      this.userForm.get('mregdevicemacid').markAsTouched();
      this.userForm.get('mreportinguser').markAsTouched();
      this.userForm.get('mstatus').markAsTouched();
      this.userForm.get('mreason').markAsTouched();
      this.userForm.get('msusdate').markAsTouched();
      //this.userForm.get('mpermnum').markAsTouched();
      //this.userForm.get('mlogcode').markAsTouched();
      //this.userForm.get('mreportman').markAsTouched();
      //this.userForm.get('mperinstance').markAsTouched();
      //this.userForm.get('mlogotherbranch').markAsTouched();
      //this.userForm.get('mmultibracc').markAsTouched();
      //this.userForm.get('mdaysfreq').markAsTouched();
      this.userForm.get('mcustaccesslvl').markAsTouched();
      //this.userForm.get('moldpass1').markAsTouched();
      return;
    }
  }

  ngOnInit() {

    //this.userForm.controls.mreportinguser.disable();
    //this.userForm.controls.musrbrcode.disable();
    
    this.reportingUserDropdown = this.storage.getSessionStorage('reportingUserDropdown');
    this.branchDropdownData = this.storage.getSessionStorage('branchDropdownData');

    let lookupData = this.storage.getSessionStorage('lookupData');
    this.genderLookup = lookupData[1139];
    this.statusLookup = lookupData[1010];
    this.groupCodeLookup = lookupData[1009];
    //console.log(this.genderLookup);
    setTimeout(function(){
      dtSample();
      dtSample1();
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

  proceedActionUser(){
    this.userForm.patchValue({
      mreportinguser: this.reportingUserDescription
    });
    dismissModal();
  }

  proceedActionBranch(){
    this.userForm.patchValue({
      musrbrcode: this.branchCodeDescription  
    });
    dismissModal();
  }

  // getLocationCoords(){
  //   this.apiservice.getPosition().then(pos=>
  //   {
  //       //console.log(`Positon: ${pos.lng} ${pos.lat}`);
  //       //this.latval = pos.lat;
  //       //this.longval = pos.lng;
  //       this.userForm.patchValue({
  //         mgeolatd: pos.lat,
  //         mgeologd: pos.lng 
  //         // formControlName2: myValue2 (can be omitted)
  //       });
  //   });
  // }

  onSubmit(data){
    this.validateUserMasterForm();

    data.mreportinguser = this.reportingUserSelectedVal;
    data.musrbrcode = this.branchCodeSelectedVal;

    data.mnextsyslgindt = this.apiservice.dateInIso(data.mnextsyslgindt);
    //data.mbadloginsdt = this.apiservice.dateInIso(data.mbadloginsdt);
    data.mlastpwdchgdt = this.apiservice.dateInIso(data.mlastpwdchgdt);
    data.mnextpwdchgdt = this.apiservice.dateInIso(data.mnextpwdchgdt);
    data.mjoindate = this.apiservice.dateInIso(data.mjoindate);
    data.mlastsyslidt = this.apiservice.dateInIso(data.mlastsyslidt);
    data.msusdate = this.apiservice.dateInIso(data.msusdate);

    //console.log(data);
    let code = {musrcode: Number(data.musrcode)};
    //console.log(code);
    this.apiservice.userCodeExist(code).subscribe(res => {
      //console.log(res);
      if(res.merror == 200){
        this.code_exist = false;
        this.code_exist_message = res.merrormessage;
        scrollToTop();
        //alert(res.merrormsg);
      }else{
        this.code_exist = true;

        if (this.userForm.valid) {
          //console.log("Form Submitted!");
          this.apiservice.postUserData(data).subscribe(res => {
            //console.log(res);
            if(res.merror == 200){
              //alert(res.merrormsg);
              this.addArray[0] = true;
              this.addArray[1] = res.merrormessage;
              this.addArray[2] = true;
    
              this.router.navigate(['/user-master-view'], { skipLocationChange: true, queryParams: this.addArray });
            }else{
              alert(res.merror);
            }
          });
          this.userForm.reset();
        }
      }
    });
    
    // if (this.userForm.valid && !this.code_exist) {
    //   //console.log("Form Submitted!");
    //   this.apiservice.postUserData(data).subscribe(res => {
    //     //console.log(res);
    //     if(res.merror == 200){
    //       //alert(res.merrormsg);
    //       this.addArray[0] = true;
    //       this.addArray[1] = res.merrormsg;
    //       this.addArray[2] = true;

    //       this.router.navigate(['/user-master-view'], { skipLocationChange: true, queryParams: this.addArray });
    //     }else{
    //       alert(res.merror);
    //     }
    //   });
    //   this.userForm.reset();
    // }
  }

  

}
