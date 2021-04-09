import { Component, OnInit } from '@angular/core';
import {FormGroup, FormControl, Validators} from '@angular/forms';
import { ApiService } from '../../services/api.service';
import { LocalStorageService } from '../../services/local-storage.service';
import {Router} from '@angular/router';


declare var pageWrapperSpacing: any;

@Component({
  selector: 'app-change-password',
  templateUrl: './change-password.component.html',
  styleUrls: ['./change-password.component.scss']
})
export class ChangePasswordComponent implements OnInit {

  chPassForm:FormGroup;

  constructor(private apiservice:ApiService, private router: Router, private storage: LocalStorageService) {
    this.chPassForm = new FormGroup({
      musrcode: new FormControl(''),
      mregdevicemacid: new FormControl(''),
      moldpass1: new FormControl('',[Validators.required]),
      musrpass: new FormControl('',[Validators.required]),
      mconfpass: new FormControl('',[Validators.required])
      
    })
  }

  ngOnInit() {
    pageWrapperSpacing();
    this.chPassForm.patchValue({
      musrcode: this.storage.getSessionStorage('usrcode'),
      mregdevicemacid: this.storage.getSessionStorage('regDeviceMacId')
    });
  }

  validateChangePassForm(){
    if (this.chPassForm.invalid) {
      this.chPassForm.get('moldpass1').markAsTouched();
      this.chPassForm.get('musrpass').markAsTouched();
      this.chPassForm.get('mconfpass').markAsTouched();
      return;
    }
  }

  onSubmit(data){
    this.validateChangePassForm();
    //console.log(data);
    
    if(this.chPassForm.valid){
      this.apiservice.changePassword(data).subscribe(res => {
        
        //console.log(res);
        if(res.merrormessage == "Password Changed"){
          alert("Password changed successfully");
        }else{
          alert(res.merrormessage);
        }
      });
    }
  }

}
