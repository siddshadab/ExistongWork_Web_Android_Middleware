import { Component, OnInit, Input, ChangeDetectorRef } from '@angular/core';
import {FormGroup, FormControl, Validators} from '@angular/forms';
import { ApiService } from '../../services/api.service';
import {Router} from '@angular/router';
import { LocalStorageService } from '../../services/local-storage.service';


declare var scrollToTop: any;

@Component({
  selector: 'app-state-master',
  templateUrl: './state-master.component.html',
  styleUrls: ['./state-master.component.scss']
})
export class StateMasterComponent implements OnInit {

  stateForm: FormGroup;
  addArray = [];
  code_exist:boolean = true;
  code_exist_message:any;
  countryDropdownData:any;

  constructor(private apiservice:ApiService, private router: Router, private storage: LocalStorageService, private chRef: ChangeDetectorRef) { 
    this.stateForm = new FormGroup({
          
      mcountryid: new FormControl('',[Validators.required]),
      mstatecd: new FormControl('',[Validators.required]),
      mstatedesc: new FormControl('',[Validators.required])

    });
  }

  ngOnInit() {
    this.countryDropdownData = this.storage.getSessionStorage('countryDropdown');
    //console.log(this.countryDropdownData);
    
  }

  validateForm(){
    if (this.stateForm.invalid) {
      this.stateForm.get('mcountryid').markAsTouched();
      this.stateForm.get('mstatecd').markAsTouched();
      this.stateForm.get('mstatedesc').markAsTouched();
      return;
    }
  }


  onSubmit(data){
    this.validateForm();

    console.log(data);

    
    //console.log(code);
    if (this.stateForm.valid) {
      
      this.apiservice.addState(data).subscribe(res => {
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
          this.router.navigate(['/state-master-view'], { skipLocationChange: true, queryParams: this.addArray });
            
          this.stateForm.reset();
          
        }
      });
    }
    
    
    
  }

}
