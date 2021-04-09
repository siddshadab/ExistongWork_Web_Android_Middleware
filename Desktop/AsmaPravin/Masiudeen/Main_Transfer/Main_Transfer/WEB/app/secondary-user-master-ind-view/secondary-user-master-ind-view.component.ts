import { LocalStorageService } from './../services/local-storage.service';
import { ApiService } from './../services/api.service';
import { Router, ActivatedRoute } from '@angular/router';
import { FormGroup, FormControl, Validators } from '@angular/forms';
import { Component, OnInit, Input } from '@angular/core';
declare var getDate: any;
@Component({
  selector: 'app-secondary-user-master-ind-view',
  templateUrl: './secondary-user-master-ind-view.component.html',
  styleUrls: ['./secondary-user-master-ind-view.component.scss']
})
export class SecondaryUserMasterIndViewComponent implements OnInit {
  sub:any;
  page:any;
  userList:any;
  userData:any;
  editActivated:boolean = false;
  formClass:string = "form-readcontroller";
  controlMandate:string = "";
  genderLookup:any;
  statusLookup:any;
  groupCodeLookup:any;
  deleteData = [];

  updateArray = [];
  deleteArray = [];
  codeCorrupt:boolean = false;
  rightsData:any;
  branchDropdownData:any;
  reportingUserDropdown:any;

  @Input() listData:[];

  userViewForm:FormGroup;

  constructor(private router: Router, private route: ActivatedRoute, private apiservice:ApiService, private storage: LocalStorageService) {
    this.userViewForm = new FormGroup({
      musrcode: new FormControl('',[Validators.required,Validators.maxLength(8)]),
     //// musrname: new FormControl('',[Validators.required,Validators.maxLength(35)]),
      //musrshortname: new FormControl('',[Validators.required,Validators.maxLength(10)]),
    //  mgender: new FormControl('',[Validators.required]),
      //musrdesignation: new FormControl('',[Validators.required]),
     // memailid: new FormControl('',[Validators.required]),
     // mmobile: new FormControl('',[Validators.required]),
     // musrbrcode: new FormControl('',[Validators.required]),
    //  mautologoutperiod: new FormControl('',[Validators.required]),
    //  mmaxbadlginperday: new FormControl('',[Validators.required]),
    //  mnextsyslgindt: new FormControl(''),
     // mmaxbadlginperinst: new FormControl('',[Validators.required]),
    //  mnoofbadlogins: new FormControl('',[Validators.required]),
      moldpass1: new FormControl('',[Validators.required]),
      moldpass2: new FormControl('',[Validators.required]),
      moldpass3: new FormControl('',[Validators.required]),
      musrpass: new FormControl('',[Validators.required]),
      mlastpwdchgdt: new FormControl(''),
     // mpwdchgperioddays: new FormControl('',[Validators.required,Validators.maxLength(8)]),
     // mpwdchgforcedyn: new FormControl('',[Validators.required]),
      mnextpwdchgdt: new FormControl(''),
    //  mgrpcd: new FormControl('',[Validators.required]),
    //  mjoindate: new FormControl(''),
    //  mlastsyslidt: new FormControl(''),
      mregdevicemacid: new FormControl('',[Validators.required]),
   //   mreportinguser: new FormControl('',[Validators.required]),
      mstatus: new FormControl('',[Validators.required]),
    //  mreason: new FormControl('',[Validators.required]),
    //  msusdate: new FormControl('',[Validators.required]),
    //  mpermnum: new FormControl(''),
    //  mlogcode: new FormControl(''),
    //  mreportman: new FormControl(''),
     // mperinstance: new FormControl(''),
   //   mlogotherbranch: new FormControl(''),
    //  mmultibracc: new FormControl(''),
    //  mdaysfreq: new FormControl(''),
    //  mcustaccesslvl: new FormControl('',[Validators.required])   
    })
  }

  ngOnInit() {

    this.rightsData = this.storage.getSessionStorage('rights');
    //console.log(this.rightsData);

    this.reportingUserDropdown = this.storage.getSessionStorage('reportingUserDropdown');

    this.branchDropdownData = this.storage.getSessionStorage('branchDropdownData');

    this.sub = this.route
      .queryParams
      .subscribe(params => {
        //console.log(params);
        this.userData = params;
    });

    let lookupData = this.storage.getSessionStorage('lookupData');
    //this.genderLookup = lookupData[1139];
    this.statusLookup = lookupData[1010];
  //  this.groupCodeLookup = lookupData[1009];
  }

  backToView(){
    this.editActivated = false;
    if(!this.editActivated){
      this.formClass = "form-readcontroller";
      this.controlMandate = "";
    }
  }

  updateInput(){
    this.userViewForm.patchValue({
      musrcode: this.userData.musrcode,
    //  musrname: this.userData.musrname,
    //  musrshortname: this.userData.musrshortname,
    //  mgender: this.userData.mgender,
      //musrdesignation: this.userData.musrdesignation,
     // memailid: this.userData.memailid,
     // mmobile: this.userData.mmobile,
    //  musrbrcode: this.userData.musrbrcode,
    //  mautologoutperiod: this.userData.mautologoutperiod,
     // mmaxbadlginperday: this.userData.mmaxbadlginperday,
     // mnextsyslgindt: this.userData.mnextsyslgindt,
     // mmaxbadlginperinst: this.userData.mmaxbadlginperinst,
     // mnoofbadlogins: this.userData.mnoofbadlogins,
     moldpass1: this.userData.moldpass1,
     moldpass2: this.userData.moldpass2,
     moldpass3: this.userData.moldpass3,
      musrpass: this.userData.musrpass,
      mlastpwdchgdt: this.userData.mlastpwdchgdt,
    //  mpwdchgperioddays: this.userData.mpwdchgperioddays,
    //  mpwdchgforcedyn: this.userData.mpwdchgforcedyn,
      mnextpwdchgdt: this.userData.mnextpwdchgdt,
    //  mgrpcd: this.userData.mgrpcd,
    //  mjoindate: this.userData.mjoindate,
    //  mlastsyslidt: this.userData.mlastsyslidt,
      mregdevicemacid: this.userData.mregdevicemacid,
     // mreportinguser: this.userData.mreportinguser,
      mstatus: this.userData.mstatus,
     // mreason: this.userData.mreason,
     // msusdate: this.userData.msusdate,
    //  mpermnum: this.userData.mpermnum,
     // mlogcode: this.userData.mlogcode,
      //mreportman: this.userData.mreportman,
      //mperinstance: this.userData.mperinstance,
    //  mlogotherbranch: this.userData.mlogotherbranch,
    //  mmultibracc: this.userData.mmultibracc,
    //  mdaysfreq: this.userData.mdaysfreq,
    //  mcustaccesslvl: this.userData.mcustaccesslvl
    });
  }
  userEdit(){
    this.editActivated = true;
    //console.log(this.editActivated);
    if(this.editActivated){
      this.formClass = "form-controller";
      this.controlMandate = "control-mandatory";
    }
    this.updateInput();
    
    // setTimeout(function(){
    //   getDate(".datepicker");
    // },1000);
  }

  validateUserMasterForm(){
    if (this.userViewForm.invalid) {
      this.userViewForm.get('musrcode').markAsTouched();
     // this.userViewForm.get('musrname').markAsTouched();
     // this.userViewForm.get('musrshortname').markAsTouched();
     // this.userViewForm.get('mgender').markAsTouched();
      //this.userViewForm.get('musrdesignation').markAsTouched();
     // this.userViewForm.get('memailid').markAsTouched();
     // this.userViewForm.get('mmobile').markAsTouched();
     // this.userViewForm.get('musrbrcode').markAsTouched();
     // this.userViewForm.get('mautologoutperiod').markAsTouched();
     // this.userViewForm.get('mmaxbadlginperday').markAsTouched();
     // this.userViewForm.get('mnextsyslgindt').markAsTouched();
    //  this.userViewForm.get('mmaxbadlginperinst').markAsTouched();
    //  this.userViewForm.get('mnoofbadlogins').markAsTouched();
    this.userViewForm.get('moldpass1').markAsTouched();  
    this.userViewForm.get('moldpass2').markAsTouched();  
    this.userViewForm.get('moldpass3').markAsTouched();  
    this.userViewForm.get('musrpass').markAsTouched();
      this.userViewForm.get('mlastpwdchgdt').markAsTouched();
    //  this.userViewForm.get('mpwdchgperioddays').markAsTouched();
     // this.userViewForm.get('mpwdchgforcedyn').markAsTouched();
      this.userViewForm.get('mnextpwdchgdt').markAsTouched();
     // this.userViewForm.get('mgrpcd').markAsTouched();
    //  this.userViewForm.get('mjoindate').markAsTouched();
     // this.userViewForm.get('mlastsyslidt').markAsTouched();
      this.userViewForm.get('mregdevicemacid').markAsTouched();
    //  this.userViewForm.get('mreportinguser').markAsTouched();
      this.userViewForm.get('mstatus').markAsTouched();
     // this.userViewForm.get('mreason').markAsTouched();
     // this.userViewForm.get('msusdate').markAsTouched();
     // this.userViewForm.get('mpermnum').markAsTouched();
     // this.userViewForm.get('mlogcode').markAsTouched();
    //  this.userViewForm.get('mreportman').markAsTouched();
    //  this.userViewForm.get('mperinstance').markAsTouched();
     // this.userViewForm.get('mlogotherbranch').markAsTouched();
    //  this.userViewForm.get('mmultibracc').markAsTouched();
     // this.userViewForm.get('mdaysfreq').markAsTouched();
    //  this.userViewForm.get('mcustaccesslvl').markAsTouched();
      return;
    }
  }

  onSubmit(data){
    this.validateUserMasterForm();
    // this.userViewForm.patchValue({
    //   mnextsyslgindt: new Date(this.userData.mnextsyslgindt).toISOString().slice(0,23),
    //   mlastpwdchgdt: new Date(this.userData.mlastpwdchgdt).toISOString().slice(0,23),
    //   mnextpwdchgdt: new Date(this.userData.mnextpwdchgdt).toISOString().slice(0,23),
    //   mjoindate: new Date(this.userData.mjoindate).toISOString().slice(0,23),
    //   mlastsyslidt: new Date(this.userData.mlastsyslidt).toISOString().slice(0,23),
    //   msusdate: new Date(this.userData.msusdate).toISOString().slice(0,23),
    // });
  //  data.mnextsyslgindt = this.apiservice.dateInIso(data.mnextsyslgindt);
    data.mlastpwdchgdt = this.apiservice.dateInIso(data.mlastpwdchgdt);
    data.mnextpwdchgdt = this.apiservice.dateInIso(data.mnextpwdchgdt);
   // data.mjoindate = this.apiservice.dateInIso(data.mjoindate);
   // data.mlastsyslidt = this.apiservice.dateInIso(data.mlastsyslidt);
  //  data.msusdate = this.apiservice.dateInIso(data.msusdate);
    //console.log(data);

    if(data.musrcode != this.userData.musrcode){
      this.codeCorrupt = true;
    }else{
      this.codeCorrupt = false;
    }
    
    if (this.userViewForm.valid && !this.codeCorrupt) {
      //console.log("Form Submitted!");
      this.apiservice.editSecondaryUser(data).subscribe(res => {
        //console.log(res);
        if(res.merror == 200){
          //alert(res.merrormessage);
          this.updateArray[0] = true;
          this.updateArray[1] = res.merrormessage;
          this.updateArray[2] = true;

          //console.log(this.updateArray);
          this.router.navigate(['/secondary-user-master-view'], { skipLocationChange: true, queryParams: this.updateArray });
        }else{
          alert(res.merror);
        }
      });
      //this.userForm.reset();
     }else{
       console.log('error');
     }
  }

  
  userDelete(){
    this.deleteData.push(this.userData.musrcode);

    let objUsrCode = {musrcode: this.deleteData};
    //console.log(objUsrCode);
    //console.log(this.userData.musrcode);
    this.apiservice.deleteSecondaryUser(objUsrCode).subscribe(res => {
      //console.log(res);
      if(res.merror == 200){
        //alert(res.merrormessage);
        this.deleteArray[0] = true;
        this.deleteArray[1] = res.merrormessage;
        this.deleteArray[2] = false;
        //console.log(this.deleteArray);
        this.router.navigate(['/secondary-user-master-view'], { skipLocationChange: true, queryParams: this.deleteArray });
      }else{
        alert(res.merror);
      }
    });
  }

}
