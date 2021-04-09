import { Component, OnInit } from '@angular/core';
import {Router, ActivatedRoute} from '@angular/router';
import {FormGroup, FormControl, Validators} from '@angular/forms';
import { ApiService } from '../../services/api.service';
import { LocalStorageService } from '../../services/local-storage.service';

@Component({
  selector: 'app-state-master-ind-view',
  templateUrl: './state-master-ind-view.component.html',
  styleUrls: ['./state-master-ind-view.component.scss']
})
export class StateMasterIndViewComponent implements OnInit {

  sub:any;
  page:any;
  stateData:any;
  editActivated:boolean = false;
  formClass:string = "form-readcontroller";
  controlMandate:string = "";
  updateArray = [];
  deleteData = [];
  deleteArray = [];

  stateViewForm:FormGroup;
  rightsData:any;
  countryDropdownData:any;

  constructor(private router: Router, private route: ActivatedRoute, private apiservice:ApiService, private storage: LocalStorageService) {
    this.stateViewForm = new FormGroup({
          
      mcountryid: new FormControl('',[Validators.required]),
      mstatecd: new FormControl('',[Validators.required]),
      mstatedesc: new FormControl('',[Validators.required])

    });
  }

  ngOnInit() {
    
    this.rightsData = this.storage.getSessionStorage('rights');

    this.countryDropdownData = this.storage.getSessionStorage('countryDropdown');

    this.sub = this.route
      .queryParams
      .subscribe(params => {
        //console.log(params);
        this.stateData = params;
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
    this.stateViewForm.patchValue({
      mcountryid: this.stateData.mcountryid,
      mstatecd: this.stateData.mstatecd,
      mstatedesc: this.stateData.mstatedesc
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
    if (this.stateViewForm.invalid) {
      this.stateViewForm.get('mcountryid').markAsTouched();
      this.stateViewForm.get('mstatecd').markAsTouched();
      this.stateViewForm.get('mstatedesc').markAsTouched();
      return;
    }
  }

  onSubmit(data){
    this.validateForm();
    
    if (this.stateViewForm.valid) {
      //console.log("Form Submitted!");
      this.apiservice.editState(data).subscribe(res => {
        //console.log(res);
        if(res.merror == 200){
          //alert(res.merrormsg);
          this.updateArray[0] = true;
          this.updateArray[1] = res.merrormsg;
          this.updateArray[2] = true;

          //console.log(this.updateArray);
          this.router.navigate(['/state-master-view'], { skipLocationChange: true, queryParams: this.updateArray });
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
      this.deleteData.push(this.stateData.mstatecd);
      //console.log(this.deleteData);
      let objBrCode = {mstatecd: this.deleteData};
      //console.log(objBrCode);
      
      this.apiservice.deleteState(objBrCode).subscribe(res => {
        //console.log(res);
        if(res.merror == 200){
          //alert(res.merrormessage);
          this.deleteArray[0] = true;
          this.deleteArray[1] = res.merrormsg;
          this.deleteArray[2] = false;
          //console.log(this.deleteArray);
          this.router.navigate(['/state-master-view'], { skipLocationChange: true, queryParams: this.deleteArray });
        }else{
          alert(res.merror);
        }
        //this.router.navigate(['/branch-master-view']);
      });
    }
  }

}
