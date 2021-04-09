import { Component, OnInit, Input } from '@angular/core';
import { FormGroup, Validators, FormControl } from '@angular/forms';
import { ApiService } from '../../services/api.service';
import { Router, ActivatedRoute } from '@angular/router';
import { AppComponent } from '../../app.component';
import { LocalStorageService } from '../../services/local-storage.service';
import { map } from 'rxjs/operators';

@Component({
  selector: 'app-user-access-rights-ind-view',
  templateUrl: './user-access-rights-ind-view.component.html',
  styleUrls: ['./user-access-rights-ind-view.component.scss']
})


export class UserAccessRightsIndViewComponent implements OnInit {

  sub:any;
  page:any;
  userList:any;
  userRightsData:any;
  editActivated:boolean = false;
  formClass:string = "form-readcontroller";
  controlMandate:string = "";
  deleteData = [];

  updateArray = [];
  deleteArray = [];
  rightsData:any;
  groupCodeLookup:any;
  reportingUserDropdown:any;
  reportUsrName:any;

  @Input() listData:[];

  userAccessRightsForm:FormGroup;
  constructor(private router: Router, private route: ActivatedRoute, private apiservice:ApiService, private storage: LocalStorageService) {

    
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

  updateInput(){
    this.userAccessRightsForm.controls['menuid'].disable();
    this.userAccessRightsForm.controls['mgrpcd'].disable();
    this.userAccessRightsForm.controls['musrcode'].disable();
    this.userAccessRightsForm.patchValue({
      menuid:this.userRightsData.userAccressRightsCompositeEntity.menuid,
      mgrpcd:this.userRightsData.userAccressRightsCompositeEntity.mgrpcd,
      musrcode:this.userRightsData.userAccressRightsCompositeEntity.usrcode,
      authoritye:this.userRightsData.authoritye,
      createe:this.userRightsData.createe,
      deletee:this.userRightsData.deletee,
      browsee:this.userRightsData.browsee,
      modifye:this.userRightsData.modifye,
    });
  }

  backToView(){
    this.editActivated = false;
    if(!this.editActivated){
      this.formClass = "form-readcontroller";
      this.controlMandate = "";
    }
  }

  ngOnInit() {

    this.rightsData = this.storage.getSessionStorage('rights');
    //console.log(this.rightsData);
    let lookupData = this.storage.getSessionStorage('lookupData');
    this.groupCodeLookup = lookupData[1009];

    this.reportingUserDropdown = this.storage.getSessionStorage('reportingUserDropdown');
    
    this.sub = this.route
      .queryParams
      .subscribe(params => {
        //console.log(params);
        //console.log(JSON.parse(params.first));
        this.userRightsData = JSON.parse(params.first);
        //console.log(this.userRightsData);
        
      });
      this.reportUsrName = this.reportingUserDropdown.find(e => e.musrcode == this.userRightsData.userAccressRightsCompositeEntity.usrcode);
      //console.log(this.reportUsrName);
      if(this.reportUsrName){
        this.reportUsrName = this.reportUsrName.musrName;
      }else{
        this.reportUsrName = this.userRightsData.userAccressRightsCompositeEntity.usrcode;
      }
  }

  edit(){
    this.editActivated = true;
    //console.log(this.editActivated);
    //console.log("data"+this.userRightsData.userAccressRightsCompositeEntity.menuid);
    this.updateInput();
    if(this.editActivated){
      this.formClass = "form-controller";
      this.controlMandate = "control-mandatory";
    }
  }


  onSubmit(data){
    //console.log(data);
    data.menuid = this.userRightsData.userAccressRightsCompositeEntity.menuid,
    data.mgrpcd = this.userRightsData.userAccressRightsCompositeEntity.mgrpcd,
    data.musrcode = this.userRightsData.userAccressRightsCompositeEntity.usrcode  
    if (this.userAccessRightsForm.valid) {
      //console.log("Form Submitted!");
      this.apiservice.editUserRightsData(data).subscribe(res => {
        //console.log(res);
        if(res.merror == 200){
          //alert(res.merrormsg);
          this.updateArray[0] = true;
          this.updateArray[1] = res.merrormsg;
          this.updateArray[2] = true;

          //console.log(this.updateArray);
          this.router.navigate(['/user-access-rights-view'], { skipLocationChange: true, queryParams: this.updateArray });
        }else{
          alert(res.merror);
        }        
      });      
    }
  }

  delete(){
    if(confirm("Are you sure to delete ?")) { 
      this.deleteData.push(this.userRightsData.userAccressRightsCompositeEntity);
      //console.log(this.deleteData);
      let objCode = {code: this.deleteData};
      //console.log(objCode);
      this.apiservice.deleteUserRightsData(objCode).subscribe(res => {
        //console.log(res);
        if(res.merror == 200){
          //alert(res.merrormessage);
          this.deleteArray[0] = true;
          this.deleteArray[1] = res.merrormsg;
          this.deleteArray[2] = false;
          //console.log(this.deleteArray);
          this.router.navigate(['/user-access-rights-view'], { skipLocationChange: true, queryParams: this.deleteArray });
        }else{
          alert(res.merror);
        }
      });
    }
  }

}
