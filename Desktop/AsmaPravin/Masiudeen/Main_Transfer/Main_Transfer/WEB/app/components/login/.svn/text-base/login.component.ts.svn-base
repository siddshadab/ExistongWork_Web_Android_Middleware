import { Component, OnInit } from '@angular/core';
import {FormGroup, FormControl, Validators} from '@angular/forms';
import {Router} from '@angular/router';
import { ApiService } from '../../services/api.service';
import { LocalStorageService } from '../../services/local-storage.service';
import { TranslateService } from '@ngx-translate/core';

declare var loginPromoSlider: any;

@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.scss']
})
export class LoginComponent implements OnInit {

  headers: { 'Access-Control-Allow-Origin': '*' }

  myForm:FormGroup;

  constructor(private apiService:ApiService, private router: Router, private storage: LocalStorageService, public translate: TranslateService) {
    
    this.myForm=new FormGroup({
      musrcode: new FormControl('',[Validators.required]),
      musrpass: new FormControl('',[Validators.required,Validators.minLength(4),Validators.maxLength(15)])
      //mregdevicemacid: new FormControl('',[Validators.required])
    })

   }

   validateLoginForm(){
    if (this.myForm.invalid) {
      this.myForm.get('musrcode').markAsTouched();
      this.myForm.get('musrpass').markAsTouched();
      //this.myForm.get('mregdevicemacid').markAsTouched();
      return;
    }
   }

  ngOnInit() {
    //console.log(this.router.url);
    loginPromoSlider();

    
    // Create item:
    //let key = "";
    //let myObj = { name: 'Skip', breed: 'Labrador' };
    //sessionStorage.setItem('key', JSON.stringify(myObj));

    //let item = JSON.parse(sessionStorage.getItem('key'));
    //console.log(item);

    // Read item:
    // let item = JSON.parse(sessionStorage.getItem('key'));
    // console.log(item);
    // if (sessionStorage.length > 0) {
    //   console.log('We have items');
    // } else {
    //   console.log('No items');
    // }
  }

  onlogin(data){
    this.validateLoginForm();
    //console.log(data);
    this.apiService.existUsers(data).subscribe(res =>
    {
      console.log(res);
      // this.userloginarray = res;
      if(res.merrormessage == "Sucessfully LoggedIn"){
        this.storage.setSessionStorage('sessionKey','MFI');
        this.storage.setSessionStorage('usrcode',res.musrcode);
        this.storage.setSessionStorage('grpcd',res.mgrpcd);
        this.storage.setSessionStorage('regDeviceMacId',res.mregdevicemacid);
        this.router.navigate(['/dashboard']);
      }else{
        alert(res.merrormessage);
      }
    });
    
  }

}
