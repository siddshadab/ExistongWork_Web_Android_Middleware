import { Component, OnInit } from '@angular/core';
import { FormGroup, FormControl, Validators, AbstractControl } from '@angular/forms';
import { ApiService } from '../../services/api.service';

declare var pageWrapperSpacing: any;
//declare var openModal: any;

@Component({
  selector: 'app-lookup-code-types',
  templateUrl: './lookup-code-types.component.html',
  styleUrls: ['./lookup-code-types.component.scss']
})
export class LookupCodeTypesComponent implements OnInit {

  lookupCodeTypeForm: FormGroup;
  lookupCodeForm: FormGroup;
  hideElement: boolean = false;
  superData= [];

  //@ViewChild('element') element: ElementRef;

  constructor(private apiservice:ApiService) {
    this.lookupCodeTypeForm = new FormGroup({
      musrcode: new FormControl(''),
      mregdevicemacid: new FormControl(''),
      mcode: new FormControl('',[Validators.required,Validators.pattern("^[0-9]*$")]),
      mcodedatatype: new FormControl('',[Validators.required,selectInputValidator]),
      mcodedatalen: new FormControl('',[Validators.required,Validators.pattern("^[0-9]*$")]),
      mcodetype: new FormControl('',[Validators.required,selectInputValidator]),
      secured: new FormControl(''),
      mfieldvalue: new FormControl('',[Validators.required]),
      name: new FormControl(''),
      type: new FormControl(''),
      length: new FormControl(''),
      decimal_length: new FormControl(''),
      remarks: new FormControl('')
    });

    this.lookupCodeForm = new FormGroup({
      mcode: new FormControl('',[Validators.required,Validators.pattern("^[0-9]*$")]),
      description: new FormControl('',[Validators.required])
    });
  }

  validateUserMasterForm(){
    if (this.lookupCodeTypeForm.invalid) {
      this.lookupCodeTypeForm.get('mcode').markAsTouched();
      this.lookupCodeTypeForm.get('mcodedatatype').markAsTouched();
      this.lookupCodeTypeForm.get('mcodedatalen').markAsTouched();
      this.lookupCodeTypeForm.get('mcodetype').markAsTouched();
      this.lookupCodeTypeForm.get('mfieldvalue').markAsTouched();
      return;
    }
  }

  ngOnInit() {
    pageWrapperSpacing();
    //openModal();

    this.superData = [
      {id:1,Name:"First Man"},
      {id:2,Name:"Second Man"},
      {id:3,Name:"Third Man"},
      {id:4,Name:"Fourth Man"},
    ];
    console.log(this.superData);
  }

  setField1(e){
    //console.log(e);
    if(e==0){
      this.hideElement = true;
    }else{
      this.hideElement = false;
    }
  }

  verifyLookupCode(data){
    console.log(data);
    const jsonData = {"mcodetype":data};
    console.log(jsonData);
    this.apiservice.existLookupCode(jsonData).subscribe(res => {
      console.log(res);
    });
  }

  onSubmit(data){
    this.validateUserMasterForm();
    console.log(data);
  }

}

function selectInputValidator(control: AbstractControl): { [key: string]: boolean } | null {
  //console.log(control.value);
  if (control.value == "Select") {
      return { 'selectInput': true };
  }
  return null;
}
