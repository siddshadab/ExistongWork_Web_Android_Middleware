import { Component, OnInit } from '@angular/core';
import { ApiService } from '../../services/api.service';
import { Router } from '@angular/router';
import { AppComponent } from '../../app.component';
import { LocalStorageService } from '../../services/local-storage.service';
import { FormGroup, Validators, FormControl } from '@angular/forms';

declare var dtSample: any;
declare var dismissModal:any;

@Component({
  selector: 'app-user-access-rights',
  templateUrl: './user-access-rights.component.html',
  styleUrls: ['./user-access-rights.component.scss']
})
export class UserAccessRightsComponent implements OnInit {

  userAccessRightsForm:FormGroup;
  addArray = [];
  groupCodeLookup:any;
  reportingUserDropdown:any;

  highlightRow : Number;
  proceedButton:boolean = false;
  reportingUserSelectedVal:any;
  reportingUserDescription:any;

  constructor(private apiservice:ApiService, private router: Router, private storage: LocalStorageService, public myapp: AppComponent) {

    
    this.userAccessRightsForm = new FormGroup({

      menuid: new FormControl('',[Validators.required,Validators.pattern("^[0-9]*$"),Validators.maxLength(8)]),
      mgrpcd: new FormControl('',[Validators.required]),
      musrcode: new FormControl('',[Validators.required]),
      authoritye: new FormControl('',[Validators.required]),
      createe: new FormControl('',[Validators.required]),
      deletee: new FormControl('',[Validators.required]),
      browsee: new FormControl('',[Validators.required]),
      modifye: new FormControl('',[Validators.required])

    })  
  }

  validateuserAccessRightsForm(){
    
    if (this.userAccessRightsForm.invalid) {
      this.userAccessRightsForm.get('menuid').markAsTouched();
      this.userAccessRightsForm.get('mgrpcd').markAsTouched();
      this.userAccessRightsForm.get('musrcode').markAsTouched();
      this.userAccessRightsForm.get('authoritye').markAsTouched();
      this.userAccessRightsForm.get('createe').markAsTouched();
      this.userAccessRightsForm.get('browsee').markAsTouched();      
      this.userAccessRightsForm.get('deletee').markAsTouched();    
      this.userAccessRightsForm.get('modifye').markAsTouched();   
      return;
    }
  }

  ngOnInit() {
    //this.userAccessRightsForm.controls.musrcode.disable();

    let lookupData = this.storage.getSessionStorage('lookupData');
    this.groupCodeLookup = lookupData[1009];

    this.reportingUserDropdown = this.storage.getSessionStorage('reportingUserDropdown');

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
    this.userAccessRightsForm.patchValue({
      musrcode: this.reportingUserDescription
    });
    dismissModal();
  }


  onSubmit(data){
    this.validateuserAccessRightsForm();
    //console.log(data); 
    data.musrcode = this.reportingUserSelectedVal;

    if (this.userAccessRightsForm.valid) {     
      this.apiservice.addUserRightsData(data).subscribe(res => {
        //console.log(res);
        if(res.merror == 200){
          //alert(res.merrormsg);
          this.addArray[0] = true;
          this.addArray[1] = res.merrormsg;
          this.addArray[2] = true;

          //console.log(this.addArray);
          this.router.navigate(['/user-access-rights-view'], { skipLocationChange: true, queryParams: this.addArray });
        }else{
          alert(res.merror);
        }    
      });
      
    }
  }


  
  
}
