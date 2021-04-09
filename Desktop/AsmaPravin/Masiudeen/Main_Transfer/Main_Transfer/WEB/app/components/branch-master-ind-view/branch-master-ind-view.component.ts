import { Component, OnInit } from '@angular/core';
import {Router, ActivatedRoute} from '@angular/router';
import {FormGroup, FormControl, Validators} from '@angular/forms';
import { ApiService } from '../../services/api.service';
import { LocalStorageService } from '../../services/local-storage.service';

declare var dtSample: any;
declare var dismissModal:any;

@Component({
  selector: 'app-branch-master-ind-view',
  templateUrl: './branch-master-ind-view.component.html',
  styleUrls: ['./branch-master-ind-view.component.scss']
})
export class BranchMasterIndViewComponent implements OnInit {

  sub:any;
  page:any;
  branchData:any;
  editActivated:boolean = false;
  formClass:string = "form-readcontroller";
  controlMandate:string = "";
  deleteData = [];

  branchViewForm:FormGroup;
  branchTypeLookup:any;
  branchCatLookup: any;
  branchWeekLookup: any;
  updateArray = [];
  deleteArray = [];
  codeCorrupt:boolean = true;
  rightsData:any;
  reportingUserDropdown:any;
  countryDropdown:any;
  stateDropdown = [];
  districtDropdown = [];
  cityDropdown = [];
  reportUsrName:any;

  highlightRow : Number;
  proceedButton:boolean = false;
  reportingUserSelectedVal:any;
  reportingUserDescription:any;
  reportUserSel:boolean = false;

  constructor(private router: Router, private route: ActivatedRoute, private apiservice:ApiService, private storage: LocalStorageService) {
    this.branchViewForm = new FormGroup({
      
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

  ngOnInit() {

    //this.branchViewForm.controls.mbrnmanager.disable();

    this.rightsData = this.storage.getSessionStorage('rights');
    //console.log(this.rightsData);

    this.sub = this.route
      .queryParams
      .subscribe(params => {
        console.log(params);
        this.branchData = params;
    });

    this.reportingUserDropdown = this.storage.getSessionStorage('reportingUserDropdown');
    //console.log(this.reportingUserDropdown);

    this.reportUsrName = this.reportingUserDropdown.find(e => e.musrcode == this.branchData.mbrnmanager);
    //console.log(this.reportUsrName);

    if(this.reportUsrName){
      this.reportUsrName = this.reportUsrName.musrName
    }else{
      this.reportUsrName = this.branchData.mbrnmanager;
    }

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
    this.reportUserSel = true;
    this.highlightRow = index;
    this.proceedButton = true;
    this.reportingUserDescription = desc;
    this.reportingUserSelectedVal = val;
  }

  proceedActionUser(){
    this.branchViewForm.patchValue({
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

  backToView(){
    this.editActivated = false;
    if(!this.editActivated){
      this.formClass = "form-readcontroller";
      this.controlMandate = "";
    }
  }

  updateInput(){
    this.branchViewForm.patchValue({
      mpbrcode: this.branchData.mpbrcode,
      madd1: this.branchData.madd1,
      madd2: this.branchData.madd2,
      madd3: this.branchData.madd3,
      mbiccode: this.branchData.mbiccode,
      mbranchcat: this.branchData.mbranchcat,
      mbranchemailid: this.branchData.mbranchemailid,
      mbranchtype: this.branchData.mbranchtype,
      mbranchtype1: this.branchData.mbranchtype1,
      mbrnmanager: this.reportUsrName,
      mcitycd: this.branchData.mcitycd,
      mcountrycd: this.branchData.mcountrycd,
      mdistrict: this.branchData.mdistrict,
      mfaxno1: this.branchData.mfaxno1,
      mformatndt: this.branchData.mformatndt,
      mlastopendate: this.branchData.mlastopendate,
      mlegacybrncd: this.branchData.mlegacybrncd,
      mmaxgroupmembers: this.branchData.mmaxgroupmembers,
      mmingroupmembers: this.branchData.mmingroupmembers,
      mname: this.branchData.mname,
      mparentbrcode: this.branchData.mparentbrcode,
      mpincode: this.branchData.mpincode,
      msector: this.branchData.msector,
      mshortname: this.branchData.mshortname,
      mstate: this.branchData.mstate,
      mswiftaddr: this.branchData.mswiftaddr,
      mtele1: this.branchData.mtele1,
      mtele2: this.branchData.mtele2,
      mweekoff1: this.branchData.mweekoff1,
      mweekoff2: this.branchData.mweekoff2
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
    if (this.branchViewForm.invalid) {
      this.branchViewForm.get('mpbrcode').markAsTouched();
      this.branchViewForm.get('mbranchcat').markAsTouched();
      this.branchViewForm.get('mbranchtype').markAsTouched();
      this.branchViewForm.get('mbranchtype1').markAsTouched();
      this.branchViewForm.get('mbrnmanager').markAsTouched();
      this.branchViewForm.get('mcitycd').markAsTouched();
      this.branchViewForm.get('mcountrycd').markAsTouched();
      this.branchViewForm.get('mformatndt').markAsTouched();
      this.branchViewForm.get('mlegacybrncd').markAsTouched();
      this.branchViewForm.get('mname').markAsTouched();
      this.branchViewForm.get('mparentbrcode').markAsTouched();
      this.branchViewForm.get('mpincode').markAsTouched();
      this.branchViewForm.get('mstate').markAsTouched();
      return;
    }
  }

  onSubmit(data){
    this.validateForm();

    if(this.reportUserSel){
      data.mbrnmanager = this.reportingUserSelectedVal;
    }else{
      data.mbrnmanager = this.branchData.mbrnmanager;
    }
    
    data.mformatndt = this.apiservice.dateInIso(data.mformatndt);
    data.mlastopendate = this.apiservice.dateInIso(data.mlastopendate);
    //console.log(data);

    if(data.mpbrcode == this.branchData.mpbrcode){
      this.codeCorrupt = true;
    }else{
      this.codeCorrupt = false;
    }
    
    if (this.branchViewForm.valid && this.codeCorrupt) {
      //console.log("Form Submitted!");
      this.apiservice.updateBranch(data).subscribe(res => {
        //console.log(res);
        if(res.merror == 200){
          //alert(res.merrormsg);
          this.updateArray[0] = true;
          this.updateArray[1] = res.merrormsg;
          this.updateArray[2] = true;

          //console.log(this.updateArray);
          this.router.navigate(['/branch-master-view'], { skipLocationChange: true, queryParams: this.updateArray });
        }else{
          alert(res.merror);
        }
        //this.router.navigate(['/branch-master-view']);
      });
      //this.userForm.reset();
     }else{
       console.log('error');
     }
  }

  delete(){
    if(confirm("Are you sure to delete ?")) {
      this.deleteData.push(this.branchData.mpbrcode);
      //console.log(this.deleteData);
      let objBrCode = {mpbrcode: this.deleteData};
      //console.log(objBrCode);
      
      this.apiservice.deleteBranch(objBrCode).subscribe(res => {
        //console.log(res);
        if(res.merror == 200){
          //alert(res.merrormessage);
          this.deleteArray[0] = true;
          this.deleteArray[1] = res.merrormsg;
          this.deleteArray[2] = false;
          //console.log(this.deleteArray);
          this.router.navigate(['/branch-master-view'], { skipLocationChange: true, queryParams: this.deleteArray });
        }else{
          alert(res.merror);
        }
        //this.router.navigate(['/branch-master-view']);
      });
    }
    
  }

}
