import { Component, OnInit, Input, ChangeDetectorRef } from '@angular/core';
import {FormGroup, FormControl, Validators} from '@angular/forms';
import { ApiService } from '../../services/api.service';
import {Router} from '@angular/router';
import { LocalStorageService } from '../../services/local-storage.service';

declare var scrollToTop: any;

@Component({
  selector: 'app-district-master',
  templateUrl: './district-master.component.html',
  styleUrls: ['./district-master.component.scss']
})
export class DistrictMasterComponent implements OnInit {

  districtForm: FormGroup;
  addArray = [];
  code_exist:boolean = true;
  code_exist_message:any;
  stateDropdownData:any;

  constructor(private apiservice:ApiService, private router: Router, private storage: LocalStorageService, private chRef: ChangeDetectorRef) {
    this.districtForm = new FormGroup({
          
      mstatecd: new FormControl('',[Validators.required]),
      mdistcd: new FormControl('',[Validators.required]),
      mdistdesc: new FormControl('',[Validators.required])

    });
  }

  ngOnInit() {

    this.stateDropdownData = this.storage.getSessionStorage('stateDropdown');
  }

  validateForm(){
    if (this.districtForm.invalid) {
      this.districtForm.get('mstatecd').markAsTouched();
      this.districtForm.get('mdistcd').markAsTouched();
      this.districtForm.get('mdistdesc').markAsTouched();
      return;
    }
  }

  onSubmit(data){
    this.validateForm();

    console.log(data);

    
    //console.log(code);
    if (this.districtForm.valid) {
      
      this.apiservice.addDistrict(data).subscribe(res => {
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
          this.router.navigate(['/district-master-view'], { skipLocationChange: true, queryParams: this.addArray });
            
          this.districtForm.reset();
          
        }
      });
    }
    
    
    
  }

}
