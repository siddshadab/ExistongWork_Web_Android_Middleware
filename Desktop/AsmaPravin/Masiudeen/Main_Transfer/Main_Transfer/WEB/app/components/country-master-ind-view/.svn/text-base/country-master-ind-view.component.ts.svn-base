import { Component, OnInit } from '@angular/core';
import {Router, ActivatedRoute} from '@angular/router';
import {FormGroup, FormControl, Validators} from '@angular/forms';
import { ApiService } from '../../services/api.service';
import { LocalStorageService } from '../../services/local-storage.service';

@Component({
  selector: 'app-country-master-ind-view',
  templateUrl: './country-master-ind-view.component.html',
  styleUrls: ['./country-master-ind-view.component.scss']
})
export class CountryMasterIndViewComponent implements OnInit {

  sub:any;
  page:any;
  countryData:any;
  editActivated:boolean = false;
  formClass:string = "form-readcontroller";
  controlMandate:string = "";
  updateArray = [];
  deleteData = [];
  deleteArray = [];

  countryViewForm:FormGroup;
  rightsData:any;

  constructor(private router: Router, private route: ActivatedRoute, private apiservice:ApiService, private storage: LocalStorageService) {
    this.countryViewForm = new FormGroup({
          
      mcountryid: new FormControl('',[Validators.required]),
      mcountryname: new FormControl('',[Validators.required]) 

    })
  }

  ngOnInit() {

    this.rightsData = this.storage.getSessionStorage('rights');

    this.sub = this.route
      .queryParams
      .subscribe(params => {
        //console.log(params);
        this.countryData = params;
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
    this.countryViewForm.patchValue({
      mcountryid: this.countryData.mcountryid,
      mcountryname: this.countryData.mcountryname
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
    if (this.countryViewForm.invalid) {
      this.countryViewForm.get('mcountryid').markAsTouched();
      this.countryViewForm.get('mcountryname').markAsTouched();
      return;
    }
  }

  onSubmit(data){
    this.validateForm();
    
    if (this.countryViewForm.valid) {
      //console.log("Form Submitted!");
      this.apiservice.editCountry(data).subscribe(res => {
        //console.log(res);
        if(res.merror == 200){
          //alert(res.merrormsg);
          this.updateArray[0] = true;
          this.updateArray[1] = res.merrormsg;
          this.updateArray[2] = true;

          //console.log(this.updateArray);
          this.router.navigate(['/country-master-view'], { skipLocationChange: true, queryParams: this.updateArray });
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
      this.deleteData.push(this.countryData.mcountryid);
      //console.log(this.deleteData);
      let objBrCode = {mcountryid: this.deleteData};
      //console.log(objBrCode);
      
      this.apiservice.deleteCountry(objBrCode).subscribe(res => {
        //console.log(res);
        if(res.merror == 200){
          //alert(res.merrormessage);
          this.deleteArray[0] = true;
          this.deleteArray[1] = res.merrormsg;
          this.deleteArray[2] = false;
          //console.log(this.deleteArray);
          this.router.navigate(['/country-master-view'], { skipLocationChange: true, queryParams: this.deleteArray });
        }else{
          alert(res.merror);
        }
        //this.router.navigate(['/branch-master-view']);
      });
    }
  }

}
