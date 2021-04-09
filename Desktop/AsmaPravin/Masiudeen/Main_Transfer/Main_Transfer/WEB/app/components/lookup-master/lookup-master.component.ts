import { Component, OnInit, ChangeDetectorRef } from '@angular/core';
import {FormGroup, FormControl, Validators} from '@angular/forms';
import { ApiService } from '../../services/api.service';
import {Router} from '@angular/router';
import { LocalStorageService } from '../../services/local-storage.service';

@Component({
  selector: 'app-lookup-master',
  templateUrl: './lookup-master.component.html',
  styleUrls: ['./lookup-master.component.scss']
})
export class LookupMasterComponent implements OnInit {
  lookuplistpreview =[]
  lookupMasterForm:FormGroup;
  categoryDisable = true
  subcode ='';
  dataTypeLookup:any;
  addArray = [];

  constructor(private apiservice:ApiService, private router: Router, private storage: LocalStorageService, private chRef: ChangeDetectorRef) {
    this.lookupMasterForm = new FormGroup({
      mcode: new FormControl('',[Validators.required,Validators.pattern("^[0-9]*$"),Validators.maxLength(30)]),
      mcodetype: new FormControl('',[Validators.required]),
      mcodedatalen: new FormControl('',[Validators.required,Validators.pattern("^[0-9]*$"),Validators.maxLength(2)]),
      mcodedatatype: new FormControl('',[Validators.required]),
      mcodedesc: new FormControl('',[Validators.required,Validators.maxLength(100)]),
      // mcodetypedesc: new FormControl('',[Validators.required,Validators.maxLength(100)]),
      mfield1value: new FormControl('',[Validators.required])
    })
  }

  validateForm(){
    if (this.lookupMasterForm.invalid) {
    
      this.lookupMasterForm.get('mcodetype').markAsTouched();
      // this.lookupMasterForm.get('mcodetypedesc').markAsTouched();
      this.lookupMasterForm.get('mcodedatalen').markAsTouched();
      this.lookupMasterForm.get('mcodedatatype').markAsTouched();
      
      this.lookupMasterForm.get('mcode').markAsTouched();
      this.lookupMasterForm.get('mcodedesc').markAsTouched();
     
      this.lookupMasterForm.get('mfield1value').markAsTouched();
      
      return;
    }
  }

  deleteRow(index){
    if(this.lookuplistpreview.length > 1){
      this.lookuplistpreview.splice(index, 1);


    }else{
      this.lookuplistpreview.splice(index, 1);
      this.lookupMasterForm.controls['mcodetype'].enable();
      // this.lookupMasterForm.controls['mcodetypedesc'].enable();
      this.lookupMasterForm.controls['mcodedatatype'].enable()
      this.lookupMasterForm.controls['mcodedatalen'].enable()
    }
    
  }
  ngOnInit() {
    
    this.categoryDisable = true;
    let lookupData = this.storage.getSessionStorage('lookupData');
    this.dataTypeLookup = lookupData[1001];
    console.log(this.dataTypeLookup);
  }

  onSubmit(data){
    this.validateForm();
    let submitdata = this.lookupMasterForm.getRawValue()

   if (this.lookupMasterForm.valid) {

    this.lookuplistpreview.push(  {
      "mcode": submitdata.mcode,
      "mcodetype": submitdata.mcodetype,
      "mcodedesc": submitdata.mcodedesc,
      "mfield1value": submitdata.mfield1value,
      "mcodedatatype": submitdata.mcodedatatype,
      "mcodedatalen": submitdata.mcodedatalen
    }); 

    this.lookupMasterForm.controls['mcode'].setValue('')
    this.lookupMasterForm.controls['mcodedesc'].setValue('')
    this.lookupMasterForm.controls['mfield1value'].setValue('')
    this.lookupMasterForm.controls['mcode'].markAsUntouched();
    this.lookupMasterForm.controls['mcodedesc'].markAsUntouched();
    this.lookupMasterForm.controls['mfield1value'].markAsUntouched();
    this.lookupMasterForm.controls['mcode'].markAsPristine();
    this.lookupMasterForm.controls['mcodedesc'].markAsPristine();
    this.lookupMasterForm.controls['mfield1value'].markAsPristine();
    this.lookupMasterForm.controls['mcodetype'].disable();
    //this.lookupMasterForm.controls['mcodetypedesc'].disable();
    this.lookupMasterForm.controls['mcodedatatype'].disable();
    this.lookupMasterForm.controls['mcodedatalen'].disable();


   }


   
  }
  SubmitFinalForm(){

    console.log("count :" + this.lookuplistpreview.length)
    for(var i=0; i< this.lookuplistpreview.length ; i++){
      let newRecordBody =  {
        "mcode": this.lookuplistpreview[i].mcode,
        "mcodetype": this.lookuplistpreview[i].mcodetype,
        "mcodedesc": this.lookuplistpreview[i].mcodedesc,
        "mfield1value": this.lookuplistpreview[i].mfield1value,
        "mcodedatatype":this.lookuplistpreview[i].mcodedatatype,
        "mcodedatalen": this.lookuplistpreview[i].mcodedatalen
      }
      this.apiservice.addLookupMaster(newRecordBody).subscribe(res => {
        console.log(res);
        //alert()
        if(res.merror == 200){
          //alert(res.merrormsg);
          this.addArray[0] = true;
          this.addArray[1] = res.merrormsg;
          this.addArray[2] = true;

          //console.log(this.addArray);
          this.router.navigate(['/lookup-master-view'], { skipLocationChange: true, queryParams: this.addArray });
        }else{
          alert(res.merror);
        }

        //this.lookuplistpreview.splice(i, 1);
        //console.log("lookuplistpreview:" + JSON.stringify( this.lookuplistpreview))
      });
   
    }

  }

   // if (this.lookupMasterForm.valid) {
    //   //console.log("Form Submitted!");
    //   this.apiservice.addLookupMaster(data).subscribe(res => {
    //     //console.log(res);
    //     alert("Look Up Master added successfully !");
    //     this.router.navigate(['/lookup-master-view']);
    //   });
    //   this.lookupMasterForm.reset();
    // }

}
