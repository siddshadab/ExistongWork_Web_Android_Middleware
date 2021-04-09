import { Component, OnInit, Input, ChangeDetectorRef } from '@angular/core';
import {FormGroup, FormControl, Validators} from '@angular/forms';
import { ApiService } from '../../services/api.service';
import {Router} from '@angular/router';
import { LocalStorageService } from '../../services/local-storage.service';


declare var scrollToTop: any;

@Component({
  selector: 'app-country-master',
  templateUrl: './country-master.component.html',
  styleUrls: ['./country-master.component.scss']
})
export class CountryMasterComponent implements OnInit {

  countryForm: FormGroup;
  addArray = [];
  code_exist:boolean = true;
  code_exist_message:any;

  constructor(private apiservice:ApiService, private router: Router, private storage: LocalStorageService, private chRef: ChangeDetectorRef) {
    this.countryForm = new FormGroup({
          
      mcountryid: new FormControl('',[Validators.required]),
      mcountryname: new FormControl('',[Validators.required]) 

    })

  }

  ngOnInit() {
  }

  validateForm(){
    if (this.countryForm.invalid) {
      this.countryForm.get('mcountryid').markAsTouched();
      this.countryForm.get('mcountryname').markAsTouched();
      return;
    }
  }

  
  onSubmit(data){
    this.validateForm();

    console.log(data);

    
    //console.log(code);
    if (this.countryForm.valid) {
      
      this.apiservice.addCountry(data).subscribe(res => {
        console.log(res);
        if(res.merror == 409){
          this.code_exist = false;
          this.code_exist_message = res.merrormsg;
          scrollToTop();  
        }else{
          this.code_exist = true;
  
           //console.log("idhr aaaya"+data);
          //this.apiservice.addCountry(data).subscribe(res => {
            //console.log(res);
            //if(res.merror == 200){
              this.addArray[0] = true;
              this.addArray[1] = res.merrormsg;
              this.addArray[2] = true;
    
              //console.log(this.addArray);
              this.router.navigate(['/country-master-view'], { skipLocationChange: true, queryParams: this.addArray });
            //}else{
            //  alert(res.merror);
            //}
          //});
          this.countryForm.reset();
          
        }
      });
    }
    
    
    
  }

}
