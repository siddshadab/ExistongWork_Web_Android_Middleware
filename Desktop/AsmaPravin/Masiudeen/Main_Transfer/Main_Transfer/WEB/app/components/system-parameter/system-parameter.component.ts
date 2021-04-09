import { Component, OnInit } from '@angular/core';
import {FormGroup, FormControl, Validators} from '@angular/forms';
import { ApiService } from '../../services/api.service';
import {Router} from '@angular/router';
import { LocalStorageService } from '../../services/local-storage.service';

declare var dtSample1: any;
declare var dismissModal:any;
declare var scrollToTop: any;

@Component({
  selector: 'app-system-parameter',
  templateUrl: './system-parameter.component.html',
  styleUrls: ['./system-parameter.component.scss']
})
export class SystemParameterComponent implements OnInit {

  systemParForm:FormGroup;
  addArray = [];
  code_exist:boolean = true;
  code_exist_message:any;
  branchDropdownData:any;

  highlightRowBranch : Number;
  proceedButtonBranch :boolean = false;
  branchCodeDescription:any;
  branchCodeSelectedVal:any;

  constructor(private apiservice:ApiService, private router: Router, private storage: LocalStorageService) {
    this.systemParForm = new FormGroup({
      mcode: new FormControl('',[Validators.required,Validators.maxLength(30)]),
      mlbrcode: new FormControl('',[Validators.required]),
      mcodevalue: new FormControl('',[Validators.maxLength(30)]),
      mcodedesc: new FormControl('',[Validators.maxLength(100)])
    })
  }

  validateForm(){
    if (this.systemParForm.invalid) {
      this.systemParForm.get('mcode').markAsTouched();
      this.systemParForm.get('mlbrcode').markAsTouched();
      
      return;
    }
  }

  ngOnInit() {
    this.branchDropdownData = this.storage.getSessionStorage('branchDropdownData');

    setTimeout(function(){
      dtSample1();
    },1000);

  }

  branchCodeSelected(val, desc, index){
    //console.log(val);
    this.highlightRowBranch = index;
    this.proceedButtonBranch = true;
    this.branchCodeDescription = desc;
    this.branchCodeSelectedVal = val;
  }

  proceedActionBranch(){
    this.systemParForm.patchValue({
      mlbrcode: this.branchCodeDescription  
    });
    dismissModal();
  }

  onSubmit(data){
    this.validateForm();
    //console.log(data);

    data.mlbrcode = this.branchCodeSelectedVal;

    let code = {mlbrcode: Number(data.mlbrcode), mcode: Number(data.mcode)};
    //console.log(code);

    this.apiservice.systemParameterCompositeEntityCodeExist(code).subscribe(res => {
      //console.log(res);
      if(res.merror == 200){
        this.code_exist = false;
        this.code_exist_message = res.merrormsg;
        scrollToTop();  
      }else{
        this.code_exist = true;

        if (this.systemParForm.valid) {
          //console.log("Form Submitted!");
          this.apiservice.addSystemParameter(data).subscribe(res => {
            //console.log(res);
            if(res.merror == 200){
              //alert(res.merrormsg);
              this.addArray[0] = true;
              this.addArray[1] = res.merrormsg;
              this.addArray[2] = true;
    
              //console.log(this.addArray);
              this.router.navigate(['/system-parameter-view'], { skipLocationChange: true, queryParams: this.addArray });
            }else{
              alert(res.merror);
            }
            //alert("System parameter added successfully !");
          });
          this.systemParForm.reset();
        }
        
      }
    });



    
    
  }

}
