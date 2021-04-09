import { Component, OnInit } from '@angular/core';
import {Router, ActivatedRoute} from '@angular/router';
import {FormGroup, FormControl, Validators} from '@angular/forms';
import { ApiService } from '../../services/api.service';
import { LocalStorageService } from '../../services/local-storage.service';

@Component({
  selector: 'app-system-parameter-ind-view',
  templateUrl: './system-parameter-ind-view.component.html',
  styleUrls: ['./system-parameter-ind-view.component.scss']
})
export class SystemParameterIndViewComponent implements OnInit {

  sub:any;
  page:any;
  systemParData:any;
  editActivated:boolean = false;
  formClass:string = "form-readcontroller";
  controlMandate:string = "";
  deleteData = [];

  updateArray = [];
  deleteArray = [];
  rightsData:any;
  branchDropdownData:any;
  branchName:any;

  systemParEditForm:FormGroup;

  constructor(private router: Router, private route: ActivatedRoute, private apiservice:ApiService, private storage: LocalStorageService) {
    this.systemParEditForm = new FormGroup({
      mcode: new FormControl('',[Validators.required,Validators.maxLength(30)]),
      mlbrcode: new FormControl('',[Validators.required]),
      mcodevalue: new FormControl('',[Validators.maxLength(30)]),
      mcodedesc: new FormControl('',[Validators.maxLength(100)])
    })
  }

  validateForm(){
    if (this.systemParEditForm.invalid) {
      this.systemParEditForm.get('mcode').markAsTouched();
      this.systemParEditForm.get('mlbrcode').markAsTouched();
      
      return;
    }
  }

  ngOnInit() {

    this.rightsData = this.storage.getSessionStorage('rights');
    //console.log(this.rightsData);
    this.branchDropdownData = this.storage.getSessionStorage('branchDropdownData');

    this.sub = this.route
      .queryParams
      .subscribe(params => {
        //console.log(params);
        //console.log(JSON.parse(params.first));
        this.systemParData = JSON.parse(params.first);
        //console.log(this.systemParData);
        
      });

    this.branchName = this.branchDropdownData.find(e => e.mpbrcode == this.systemParData.systemParameterCompositeEntity.mlbrcode);
    //console.log(this.branchName);
    if(this.branchName){
      this.branchName = this.branchName.mname
    }else{
      this.branchName = this.systemParData.systemParameterCompositeEntity.mlbrcode;
    }
  }

  backToView(){
    this.editActivated = false;
    if(!this.editActivated){
      this.formClass = "form-readcontroller";
      this.controlMandate = "";
    }
  }

  updateInput(){
    this.systemParEditForm.patchValue({
      mcode: this.systemParData.systemParameterCompositeEntity.mcode,
      mlbrcode: this.systemParData.systemParameterCompositeEntity.mlbrcode,
      mcodevalue: this.systemParData.mcodevalue,
      mcodedesc: this.systemParData.mcodedesc
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

  onSubmit(data){
    this.validateForm();
    
    //console.log(data);
    data.mlbrcode = this.systemParData.systemParameterCompositeEntity.mlbrcode;
    data.mcode = this.systemParData.systemParameterCompositeEntity.mcode;
    
    if (this.systemParEditForm.valid) {
      //console.log("Form Submitted!");
      this.apiservice.editSystemParameter(data).subscribe(res => {
        //console.log(res);
        if(res.merror == 200){
          //alert(res.merrormessage);
          this.updateArray[0] = true;
          this.updateArray[1] = res.merrormsg;
          this.updateArray[2] = true;

          //console.log(this.updateArray);
          this.router.navigate(['/system-parameter-view'], { skipLocationChange: true, queryParams: this.updateArray });
        }else{
          alert(res.merror);
        }
      });
      //this.userForm.reset();
     }else{
       console.log('error');
     }
  }

  delete(){
    if(confirm("Are you sure to delete ?")) {
      this.deleteData.push(this.systemParData.systemParameterCompositeEntity);
      //console.log(this.deleteData);
      let objCode = {code: this.deleteData};
      //console.log(objUsrCode);
      this.apiservice.deleteSystemParameter(objCode).subscribe(res => {
        //console.log(res);
        if(res.merror == 200){
          //alert(res.merrormsg);
          this.deleteArray[0] = true;
          this.deleteArray[1] = res.merrormsg;
          this.deleteArray[2] = false;
          //console.log(this.deleteArray);
          this.router.navigate(['/system-parameter-view'], { skipLocationChange: true, queryParams: this.deleteArray });
        }else{
          alert(res.merror);
        }
      });
    }
  }

}
