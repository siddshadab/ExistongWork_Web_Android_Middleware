import { Component, OnInit, Input } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { FormGroup, Validators, FormControl } from '@angular/forms';
import { LocalStorageService } from '../../services/local-storage.service';
import { ApiService } from '../../services/api.service';
import { JsonPipe } from '@angular/common';

declare var dtSample1: any;
declare var dismissModal:any;

@Component({
  selector: 'app-product-master-ind-view',
  templateUrl: './product-master-ind-view.component.html',
  styleUrls: ['./product-master-ind-view.component.scss']
})
export class ProductMasterIndViewComponent implements OnInit {

  sub:any;
  page:any;
  productList:any;
  productData:any;
  editActivated:boolean = false;
  formClass:string = "form-readcontroller";
  controlMandate:string = "";
  ProductArray = [];
  deleteData = [];
  @Input() listData:[];

  productForm:FormGroup;
  moduleTypeLookup:any;
  divisionTypeLookup:any;

  updateArray = [];
  deleteArray = [];
  codeCorrupt:boolean = true;
  rightsData:any;
  branchDropdownData:any;
  currencyDropdown:any;
  branchName:any;


  constructor(private router: Router, private route: ActivatedRoute, private apiservice:ApiService, private storage: LocalStorageService) {
    this.productForm = new FormGroup({

      mlbrcode: new FormControl('',[Validators.required,Validators.pattern("^[0-9]*$"),Validators.maxLength(8)]),
      mprdcd: new FormControl('',[Validators.required,Validators.maxLength(8)]),
      mcurcd: new FormControl('',[Validators.required]),
      mdivisiontype: new FormControl('',[Validators.required]),
      mintrate: new FormControl('',[Validators.required,Validators.maxLength(10)]),
      mmoduletype: new FormControl('',[Validators.required]),
      mname: new FormControl('',[Validators.required]),
      mnoofguaranter: new FormControl('',[Validators.required,Validators.maxLength(8)]),
     
      // mgeolatd: new FormControl('',[Validators.required]),
      // mgeologd: new FormControl('',[Validators.required]),
      // mcreatedby: new FormControl('',[Validators.required]),
      // mcreateddt: new FormControl('',[Validators.required]),
      // mgeolocation: new FormControl('',[Validators.required]),
      // missynctocoresys: new FormControl('',[Validators.required]),
      // mlastsyncdate: new FormControl('',[Validators.required]),
      // mlasteupdatedby: new FormControl('',[Validators.required]),
      // mlastupdateddt: new FormControl('',[Validators.required])
    })  
  }

  updateInput(){
    this.productForm.patchValue({
      mlbrcode:this.productData.productComposieEntity.mlbrcode,
      mprdcd:this.productData.productComposieEntity.mprdcd,
      mcurcd:this.productData.mcurcd,
      mdivisiontype:this.productData.mdivisiontype,
      mintrate:this.productData.mintrate,
      mmoduletype:this.productData.mmoduletype,
      mname:this.productData.mname,
      mnoofguaranter:this.productData.mnoofguaranter      
    });
  }

  backToView(){
    this.editActivated = false;
    if(!this.editActivated){
      this.formClass = "form-readcontroller";
      this.controlMandate = "";
    }
  }

  ngOnInit() {

    //this.productForm.controls.mlbrcode.disable();
    //this.productForm.controls.mprdcd.disable();

    this.rightsData = this.storage.getSessionStorage('rights');
    //console.log(this.rightsData);

    this.sub = this.route
      .queryParams
      .subscribe(params => {
        //console.log(params);
        //console.log(JSON.parse(params.first));
        this.productData = JSON.parse(params.first);
        //console.log(this.productData);
        
    });

    this.branchDropdownData = this.storage.getSessionStorage('branchDropdownData');
    this.currencyDropdown = this.storage.getSessionStorage('currencyDropdown');

    let lookupData = this.storage.getSessionStorage('lookupData');
    this.moduleTypeLookup = lookupData[1053];
    //console.log(this.moduleTypeLookup);
    this.divisionTypeLookup = lookupData[2121];

  }

   
  
  edit(){
    this.editActivated = true;
    //console.log(this.editActivated);
    this.updateInput();
    if(this.editActivated){
      this.formClass = "form-controller";
      this.controlMandate = "control-mandatory";
    }
  }

  delete(){
    if(confirm("Are you sure to delete ?")) { 
      //console.log(this.productData);
      this.deleteData.push(this.productData.productComposieEntity);
      //console.log(this.deleteData);
      let objCode = {code: this.deleteData};
      //console.log(objCode);
      
      this.apiservice.deleteProduct(objCode).subscribe(res => {
        //console.log(res);
        if(res.merror == 200){
          //alert(res.merrormsg);
          this.deleteArray[0] = true;
          this.deleteArray[1] = res.merrormsg;
          this.deleteArray[2] = false;
          //console.log(this.deleteArray);
          this.router.navigate(['/product-master-view'], { skipLocationChange: true, queryParams: this.deleteArray });
        }else{
          alert(res.merror);
        }
      });
    }
  }

  updateProduct(data){
    //console.log(data);
    data.mlbrcode = this.productData.productComposieEntity.mlbrcode;
    data.mprdcd = this.productData.productComposieEntity.mprdcd;

    if(data.mlbrcode == this.productData.productComposieEntity.mlbrcode && data.mprdcd == this.productData.productComposieEntity.mprdcd){
      this.codeCorrupt = true;
    }else{
      this.codeCorrupt = false;
    }

    if (this.productForm.valid && this.codeCorrupt) {
      //console.log("Form Submitted!");
      this.apiservice.updateProduct(data).subscribe(res => {
        //console.log(res);
        if(res.merror == 200){
          //alert(res.merrormsg);
          this.updateArray[0] = true;
          this.updateArray[1] = res.merrormsg;
          this.updateArray[2] = true;

          //console.log(this.updateArray);
          this.router.navigate(['/product-master-view'], { skipLocationChange: true, queryParams: this.updateArray });
        }else{
          alert(res.merror);
        }
      });      
    }
  }

}
