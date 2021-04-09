import { Component, OnInit } from '@angular/core';
import {Router, ActivatedRoute} from '@angular/router';
import {FormGroup, FormControl, Validators} from '@angular/forms';
import { ApiService } from '../../services/api.service';
import { LocalStorageService } from '../../services/local-storage.service';

@Component({
  selector: 'app-lookup-master-ind-view',
  templateUrl: './lookup-master-ind-view.component.html',
  styleUrls: ['./lookup-master-ind-view.component.scss']
})
export class LookupMasterIndViewComponent implements OnInit {

  sub:any;
  page:any;
  lookupData:any;
  editActivated:boolean = false;
  formClass:string = "form-readcontroller";
  controlMandate:string = "";
  lookupcodelist=[] ;
  lookupMasterEditForm:FormGroup;
  selectedItem = 0
  tempcond =false
  showcodetype =false;
  updaterow = false;
  editIndex =null;
  rightsData:any;

  updateArray = [];
  deleteArray = [];
  deleteData = [];

  constructor(private router: Router, private route: ActivatedRoute, private apiservice:ApiService, private storage: LocalStorageService) {
    this.lookupMasterEditForm = new FormGroup({
      mcode: new FormControl('',[Validators.required,Validators.pattern("^[0-9]*$"),Validators.maxLength(30)]),
      mcodetype: new FormControl('',[Validators.required]),
      mcodedatalen: new FormControl('',[Validators.required,Validators.pattern("^[0-9]*$"),Validators.maxLength(2)]),
      mcodedatatype: new FormControl('',[Validators.required]),
      mcodedesc: new FormControl('',[Validators.required,Validators.maxLength(100)]),
      //mcodetypedesc: new FormControl('',[Validators.required,Validators.maxLength(100)]),
      mfield1value: new FormControl('',[Validators.required])      
    })
  }

  validateForm(){
    if (this.lookupMasterEditForm.invalid) {
      this.lookupMasterEditForm.get('mcode').markAsTouched();
      this.lookupMasterEditForm.get('mcodetype').markAsTouched();
      this.lookupMasterEditForm.get('mcodedatalen').markAsTouched();
      this.lookupMasterEditForm.get('mcodedatatype').markAsTouched();
      this.lookupMasterEditForm.get('mcodedesc').markAsTouched();
      this.lookupMasterEditForm.get('mfield1value').markAsTouched();
      //this.lookupMasterEditForm.get('mcodetypedesc').markAsTouched();
      
      return;
    }
  }

  ngOnInit() {

    this.rightsData = this.storage.getSessionStorage('rights');
    //console.log(this.rightsData);
    
    this.sub = this.route
      .queryParams
      .subscribe(params => {
        console.log(params);
        this.lookupData = JSON.parse(params.first);
        console.log("LOOKUP DATA " + JSON.stringify(this.lookupData))
    });
    let data = {"mcodetype":  this.lookupData.lookupComposite.mcodetype}
    console.log('data :' + JSON.stringify(data))

    this.apiservice.getlookupcode(data).subscribe(res => {
      console.log(res);
      this.lookupcodelist = res
      
    });  

  }

  backToView(){
    this.editActivated = false;
    if(!this.editActivated){
      this.formClass = "form-readcontroller";
      this.controlMandate = "";
    }
  }
  addNewRecords(data){
      let newRecordBody =  {
        "mcode": data.mcode,
        "mcodetype": this.lookupData.lookupComposite.mcodetype,
        "mcodedesc": data.mcodedesc,
        "mfield1value": data.mfield1value,
        "mcodedatatype":this.lookupData.mcodedatatype,
        "mcodedatalen": this.lookupData.mcodedatalen
      }
      this.apiservice.addLookupMaster(newRecordBody).subscribe(res => {
          console.log(res);
          alert(res.merrormsg)
            this.lookupcodelist.push({
          "lookupComposite": {
            "mcode": data.mcode,
            "mcodetype": this.lookupData.lookupComposite.mcodetype
          },
          "mcodedesc": data.mcodedesc,
          "mfield1value":data.mfield1value,
          "mcodedatatype":this.lookupData.mcodedatatype,
          "mcodedatalen": this.lookupData.mcodedatalen
        } )
        this.updateInput();
        this.lookupMasterEditForm.controls['mcode'].setValue('')
        this.lookupMasterEditForm.controls['mcodedesc'].setValue('')
        this.lookupMasterEditForm.controls['mfield1value'].setValue('');
        this.lookupMasterEditForm.controls['mcode'].markAsUntouched();
        this.lookupMasterEditForm.controls['mcodedesc'].markAsUntouched();
        this.lookupMasterEditForm.controls['mfield1value'].markAsUntouched();
        this.lookupMasterEditForm.controls['mcode'].markAsPristine();
        this.lookupMasterEditForm.controls['mcodedesc'].markAsPristine();
        this.lookupMasterEditForm.controls['mfield1value'].markAsPristine();
      });  
  }
  removeRecords(data){
    let deleteBody =  {
      "mcode": data.mcode,
        "mcodetype": this.lookupData.lookupComposite.mcodetype,
      
    }
    console.log(deleteBody)
    this.apiservice.deleteLookupMaster(deleteBody).subscribe(res => {
      console.log(res);
      
    })
    
  }
  updateRecords(data){

    let updateBody =  {
      "mcode": data.mcode,
      "mcodetype": this.lookupData.lookupComposite.mcodetype,
      "mcodedesc": data.mcodedesc,
      "mfield1value":data.mfield1value,
      "mcodedatatype":this.lookupData.mcodedatatype,
      "mcodedatalen": this.lookupData.mcodedatalen
      
    }

   
    this.apiservice.editLookupMaster(updateBody).subscribe(res => {
      console.log(res);
     
      this.lookupcodelist[this.editIndex].mcode = res.mcode;
      this.lookupcodelist[this.editIndex].mcodedesc = data.mcodedesc;
      this.lookupcodelist[this.editIndex].mfield1value = data.mfield1value;
      //alert(res.merrormsg)
      this.updateInput()
      this.editfield(false,'','')
      this.tempcond =false;

      if(res.merror == 200){
        //alert(res.merrormsg);
        this.updateArray[0] = true;
        this.updateArray[1] = res.merrormsg;
        this.updateArray[2] = true;
  
        //console.log(this.updateArray);
        this.router.navigate(['/lookup-master-view'], { skipLocationChange: true, queryParams: this.updateArray });
      }else{
        //console.log('in');
        alert(res.merror);
      }

    })
    
  }

  updateInput(){
    this.showcodetype =true;
    this.lookupMasterEditForm.controls['mcodetype'].disable();
    //this.lookupMasterEditForm.controls['mcodetypedesc'].disable();
    this.lookupMasterEditForm.controls['mcodedatalen'].disable();
    this.lookupMasterEditForm.controls['mcodedatatype'].disable();
    this.lookupMasterEditForm.patchValue({
      mcode: '',
      mcodetype: this.lookupData.lookupComposite.mcodetype,
      mcodedatalen: this.lookupData.mcodedatalen,
      mcodedatatype: this.lookupData.mcodedatatype,
      mcodedesc: '',
      mfield1value:'',
      mcodetypedesc: ''
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
  editfield(val, list , index ){
    console.log("val :" + val)
    if(val){
      this.editIndex = index;
      this.updaterow = true;
      this.tempcond =true;
      this.selectedItem = list.lookupComposite.mcode;
          this.lookupMasterEditForm.patchValue({
            mcode: list.lookupComposite.mcode,
            mcodedesc: list.mcodedesc,
            mfield1value: list.mfield1value,
          
          });
    }else{
      this.editIndex = null;
      this.updaterow = false
      this.tempcond =false;
      this.selectedItem = 0
      this.lookupMasterEditForm.patchValue({
        mcode: '',
        mcodedesc: '',
        mfield1value: '',
      
      });

    }
 


  }
  // onSubmit(data){
  //   this.validateForm();
    
  //   //console.log(data);
    
  //   if (this.lookupMasterEditForm.valid) {
  //     //console.log("Form Submitted!");
  //     this.apiservice.editLookupMaster(data).subscribe(res => {
  //       //console.log(res);
  //       if(res.merror == 200){
  //         alert(res.merrormessage);
  //       }else{
  //         alert(res.merror);
  //       }
  //       this.router.navigate(['/lookup-master-view']);
  //     });
  //     //this.userForm.reset();
  //    }else{
  //      console.log('error');
  //    }
  // }

  delete(){
    if(confirm("Are you sure to delete ?")) {
      this.deleteData.push(this.lookupData.lookupComposite);
      //console.log(this.deleteData);
      let objCode = this.deleteData;
      //let objCode = {mcode: this.lookupData.mcode};
      //console.log(objUsrCode);
      //console.log(this.userData.musrcode);
      this.apiservice.deleteLookupMaster(objCode).subscribe(res => {
        //console.log(res);
        if(res.merror == 200){
          //alert(res.merrormsg);
          this.deleteArray[0] = true;
          this.deleteArray[1] = res.merrormsg;
          this.deleteArray[2] = false;
    
          //console.log(this.updateArray);
          this.router.navigate(['/lookup-master-view'], { skipLocationChange: true, queryParams: this.deleteArray });
        }else{
          //console.log('in');
          alert(res.merror);
        }

      });
    }
  }

}
