import { Component, OnInit, Input, ChangeDetectorRef } from '@angular/core';
import {FormGroup, FormControl, Validators} from '@angular/forms';
import { ApiService } from '../../services/api.service';
import {Router} from '@angular/router';
import { LocalStorageService } from '../../services/local-storage.service';

declare var scrollToTop: any;

@Component({
  selector: 'app-sub-district-master',
  templateUrl: './sub-district-master.component.html',
  styleUrls: ['./sub-district-master.component.scss']
})
export class SubDistrictMasterComponent implements OnInit {

  subDistrictForm: FormGroup;
  addArray = [];
  code_exist:boolean = true;
  code_exist_message:any;
  stateDropdownData:any;
  districtDropdownData:any;

  constructor(private apiservice:ApiService, private router: Router, private storage: LocalStorageService, private chRef: ChangeDetectorRef) {

    this.subDistrictForm = new FormGroup({
          
      mstatecd: new FormControl('',[Validators.required]),
      mdistcd: new FormControl('',[Validators.required]),
      mplacecd: new FormControl('',[Validators.required]),
      mplacecddesc: new FormControl('',[Validators.required])

    });

  }

  ngOnInit() {

    this.stateDropdownData = this.storage.getSessionStorage('stateDropdown');

  }

  validateForm(){
    if (this.subDistrictForm.invalid) {
      this.subDistrictForm.get('mstatecd').markAsTouched();
      this.subDistrictForm.get('mdistcd').markAsTouched();
      this.subDistrictForm.get('mplacecd').markAsTouched();
      this.subDistrictForm.get('mplacecddesc').markAsTouched();
      return;
    }
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

  onSubmit(data){
    this.validateForm();

    console.log(data);

    
    //console.log(code);
    if(this.subDistrictForm.valid) {
      
      this.apiservice.addSubDistrict(data).subscribe(res => {
        console.log(res);
        if(res.merror == 409){
          this.code_exist = false;
          this.code_exist_message = res.merrormsg;
          scrollToTop();  
        }else{
          this.code_exist = true;
  
          this.addArray[0] = true;
          this.addArray[1] = res.merrormsg;
          this.addArray[2] = true;

          //console.log(this.addArray);
          this.router.navigate(['/sub-district-master-view'], { skipLocationChange: true, queryParams: this.addArray });
            
          this.subDistrictForm.reset();
          
        }
      });
    }
    
    
    
  }

}
