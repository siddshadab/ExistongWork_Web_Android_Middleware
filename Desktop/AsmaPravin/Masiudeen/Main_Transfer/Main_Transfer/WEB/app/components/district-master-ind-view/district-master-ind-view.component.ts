import { Component, OnInit } from '@angular/core';
import {Router, ActivatedRoute} from '@angular/router';
import {FormGroup, FormControl, Validators} from '@angular/forms';
import { ApiService } from '../../services/api.service';
import { LocalStorageService } from '../../services/local-storage.service';

@Component({
  selector: 'app-district-master-ind-view',
  templateUrl: './district-master-ind-view.component.html',
  styleUrls: ['./district-master-ind-view.component.scss']
})
export class DistrictMasterIndViewComponent implements OnInit {

  sub:any;
  page:any;
  districtData:any;
  editActivated:boolean = false;
  formClass:string = "form-readcontroller";
  controlMandate:string = "";
  updateArray = [];
  deleteData = [];
  deleteArray = [];

  districtViewForm:FormGroup;
  rightsData:any;
  stateDropdownData:any;

  constructor(private router: Router, private route: ActivatedRoute, private apiservice:ApiService, private storage: LocalStorageService) {
    
    this.districtViewForm = new FormGroup({
          
      mstatecd: new FormControl('',[Validators.required]),
      mdistcd: new FormControl('',[Validators.required]),
      mdistdesc: new FormControl('',[Validators.required])

    });

  }

  ngOnInit() {
    
    this.rightsData = this.storage.getSessionStorage('rights');

    this.stateDropdownData = this.storage.getSessionStorage('stateDropdown');
    //console.log(this.stateDropdownData);

    this.sub = this.route
      .queryParams
      .subscribe(params => {
        //console.log(params);
        this.districtData = params;
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
    this.districtViewForm.patchValue({
      mstatecd: this.districtData.mstatecd,
      mdistcd: this.districtData.mdistcd,
      mdistdesc: this.districtData.mdistdesc
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
    if (this.districtViewForm.invalid) {
      this.districtViewForm.get('mstatecd').markAsTouched();
      this.districtViewForm.get('mdistcd').markAsTouched();
      this.districtViewForm.get('mdistdesc').markAsTouched();
      return;
    }
  }

  onSubmit(data){
    this.validateForm();
    
    if (this.districtViewForm.valid) {
      //console.log("Form Submitted!");
      this.apiservice.editDistrict(data).subscribe(res => {
        //console.log(res);
        if(res.merror == 200){
          //alert(res.merrormsg);
          this.updateArray[0] = true;
          this.updateArray[1] = res.merrormsg;
          this.updateArray[2] = true;

          //console.log(this.updateArray);
          this.router.navigate(['/district-master-view'], { skipLocationChange: true, queryParams: this.updateArray });
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
      this.deleteData.push(this.districtData.mdistcd);
      //console.log(this.deleteData);
      let objBrCode = {mdistcd: this.deleteData};
      console.log(objBrCode);
      
      this.apiservice.deleteDistrict(objBrCode).subscribe(res => {
        //console.log(res);
        if(res.merror == 200){
          //alert(res.merrormessage);
          this.deleteArray[0] = true;
          this.deleteArray[1] = res.merrormsg;
          this.deleteArray[2] = false;
          //console.log(this.deleteArray);
          this.router.navigate(['/district-master-view'], { skipLocationChange: true, queryParams: this.deleteArray });
        }else{
          alert(res.merror);
        }
        //this.router.navigate(['/branch-master-view']);
      });
    }
  }

}
