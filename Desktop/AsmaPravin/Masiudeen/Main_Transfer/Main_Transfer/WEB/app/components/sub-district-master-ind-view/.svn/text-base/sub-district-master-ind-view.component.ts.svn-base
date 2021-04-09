import { Component, OnInit } from '@angular/core';
import {Router, ActivatedRoute} from '@angular/router';
import {FormGroup, FormControl, Validators} from '@angular/forms';
import { ApiService } from '../../services/api.service';
import { LocalStorageService } from '../../services/local-storage.service';

@Component({
  selector: 'app-sub-district-master-ind-view',
  templateUrl: './sub-district-master-ind-view.component.html',
  styleUrls: ['./sub-district-master-ind-view.component.scss']
})
export class SubDistrictMasterIndViewComponent implements OnInit {

  sub:any;
  page:any;
  subDistrictData:any;
  editActivated:boolean = false;
  formClass:string = "form-readcontroller";
  controlMandate:string = "";
  updateArray = [];
  deleteData = [];
  deleteArray = [];

  subDistrictViewForm:FormGroup;
  rightsData:any;
  stateDropdownData:any;
  districtDropdownData:any;

  constructor(private router: Router, private route: ActivatedRoute, private apiservice:ApiService, private storage: LocalStorageService) {

    this.subDistrictViewForm = new FormGroup({
          
      mstatecd: new FormControl('',[Validators.required]),
      mdistcd: new FormControl('',[Validators.required]),
      mplacecd: new FormControl('',[Validators.required]),
      mplacecddesc: new FormControl('',[Validators.required])

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
        this.subDistrictData = params;

        this.getDistrictByState(this.subDistrictData.mstatecd);
    });

  }

  getDistrictByState(data){
    //console.log(data);
    let objCode = {mstatecd: data};
    this.apiservice.districtListByState(objCode).subscribe(res => {
      //console.log(res);
      this.districtDropdownData = res;
      //this.storage.setSessionStorage('stateDropdown',res);
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
    this.subDistrictViewForm.controls['mplacecd'].disable();
    this.subDistrictViewForm.patchValue({
      mstatecd: this.subDistrictData.mstatecd,
      mdistcd: this.subDistrictData.mdistcd,
      mplacecd: this.subDistrictData.mplacecd,
      mplacecddesc: this.subDistrictData.mplacecddesc,
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
    if (this.subDistrictViewForm.invalid) {
      this.subDistrictViewForm.get('mstatecd').markAsTouched();
      this.subDistrictViewForm.get('mdistcd').markAsTouched();
      this.subDistrictViewForm.get('mplacecd').markAsTouched();
      this.subDistrictViewForm.get('mplacecddesc').markAsTouched();

      return;
    }
  }

  onSubmit(data){
    data.mplacecd = this.subDistrictData.mplacecd;
    this.validateForm();
    console.log(data);
    if (this.subDistrictViewForm.valid) {
      //console.log("Form Submitted!");
      this.apiservice.editSubDistrict(data).subscribe(res => {
        console.log(res);
        if(res.merror == 200){
          //alert(res.merrormsg);
          this.updateArray[0] = true;
          this.updateArray[1] = res.merrormsg;
          this.updateArray[2] = true;

          //console.log(this.updateArray);
          this.router.navigate(['/sub-district-master-view'], { skipLocationChange: true, queryParams: this.updateArray });
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
      this.deleteData.push(this.subDistrictData.mplacecd);
      //console.log(this.deleteData);
      let objBrCode = {mplacecd: this.deleteData};
      //console.log(objBrCode);
      
      this.apiservice.deleteSubDistrict(objBrCode).subscribe(res => {
        //console.log(res);
        if(res.merror == 200){
          //alert(res.merrormessage);
          this.deleteArray[0] = true;
          this.deleteArray[1] = res.merrormsg;
          this.deleteArray[2] = false;
          //console.log(this.deleteArray);
          this.router.navigate(['/sub-district-master-view'], { skipLocationChange: true, queryParams: this.deleteArray });
        }else{
          alert(res.merror);
        }
        //this.router.navigate(['/branch-master-view']);
      });
    }
  }

}
