import { Component, OnInit, ViewChild, AfterViewInit, ChangeDetectorRef, ElementRef } from '@angular/core';
import { Router, ActivatedRoute } from '@angular/router';
import { LocalStorageService } from '../../services/local-storage.service';
import { ApiService } from '../../services/api.service';


declare var dtSample: any;
declare var destroydtSample: any;
declare var showPageLoader: any;
declare var hidePageLoader: any;
declare var $;

@Component({
  selector: 'app-product-master-view',
  templateUrl: './product-master-view.component.html',
  styleUrls: ['./product-master-view.component.scss']
})


export class ProductMasterViewComponent implements OnInit,AfterViewInit {

  dataArray = ['test','best','rest'];
  userDataFetched:boolean = false;
  testobj = {mockup_id: "123", project_id: "456", module_id: "678", release_id: "890", requirement_id: "432"};

  @ViewChild('dataTable', {static: false}) table: ElementRef;

  dataTable:any;
  dtOptions:any;
  curUserCode:any;
  ProductArray = [];
  checkedList = [];
  allCheckedList = [];
  allCheckedListLength: any = 0;
  selectedAll:any;
  allCheckedEvent:any;
  multipleDelete:boolean = false;

  sub:any;
  alert:boolean = false;
  alertMessage: any;
  alertSuccess:boolean = false;
  rightsData:any;

  constructor(private apiservice:ApiService, private router: Router, private route: ActivatedRoute, private storage: LocalStorageService, private chRef: ChangeDetectorRef) { }

  ngOnInit() {

    showPageLoader();

    let api = this.apiservice;

    this.rightsData = this.storage.getSessionStorage('rights');
    //console.log(this.rightsData);

     this.apiservice.getProductList().subscribe(res =>{
      res.forEach(function (value) {
        //console.log(value.mbranchtype);
        value.mmoduletypeDesc = api.getLookupName(1053,value.mmoduletype);
        value.mdivisiontypeDesc = api.getLookupName(2121,value.mdivisiontype);
        
        //console.log(value.mgender);
        //console.log(value);
      });
     
       this.ProductArray = res;
       //this.dataArray = res;
       //console.log(this.ProductArray);
       this.chRef.detectChanges();
       dtSample();
       hidePageLoader();
      
     });

     this.sub = this.route
      .queryParams
      .subscribe(params => {
        
        if(Object.keys(params).length > 0){
          this.alert = params[0];
          this.alertMessage = params[1];
          this.alertSuccess = Boolean(JSON.parse(params[2]));

          setTimeout(()=>{
            this.alert = false;
          }, 2000);
        }
        
    });

  }

  ngAfterViewInit(){
  
  }

  productAdd(){
    this.router.navigate(['/product-master']);
  }

  dataNavigate(list){
    //console.log(list);
    const stringify = JSON.stringify(list);
    //const parse = JSON.parse(stringify);
    //console.log(stringify);
    //console.log(parse);
    if(this.rightsData.browse == 1){
      this.router.navigate(['/product-master-ind-view'], { skipLocationChange: true, queryParams: { first: stringify } });
    }
  }

  allCheckboxes(event) {
    const checked = event.target.checked;
    this.allCheckedEvent = event.target;
    //console.log(checked);
    if(checked){
      this.allCheckedList = [];
    }
    this.ProductArray.forEach(item => 
      {
        item.selected = checked;
        //console.log(item);
        if(checked){
          //this.allCheckedList = [];
          this.allCheckedList.push(item.productComposieEntity);      
        }else{
          this.allCheckedList = [];
          //event.target.checked = false;
        }
      }
    );
    //console.log(this.allCheckedList);
    this.allCheckedListLength = this.allCheckedList.length;
    if(this.allCheckedList.length > 0){
      this.multipleDelete = true;
    }else{
      this.multipleDelete = false;
    }
    //console.log(this.multipleDelete);
  }

  toggleVisibility(option,e){
    //console.log(option);
    //console.log(e);
    //console.log(e.target.checked);
    if(e.target.checked) {
      
      this.allCheckedList.push(option.productComposieEntity);
      //console.log(this.allCheckedList);
      
      if(this.allCheckedEvent){
        if(this.allCheckedList.length == this.allCheckedListLength && this.allCheckedList.length > 0){
          this.allCheckedEvent.checked = true;
        }else{
          this.allCheckedEvent.checked = false;
        }
      }
      
    }else{
      for(var i=0 ; i < this.allCheckedList.length; i++) {
        //console.log(this.allCheckedList[i]);
        if(this.allCheckedList[i].mprdcd == option.productComposieEntity.mprdcd && this.allCheckedList[i].mlbrcode == option.productComposieEntity.mlbrcode) {
          this.allCheckedList.splice(i,1);
       }
      //this.checkedList.splice(option.mpbrcode,1);
      }
      if(this.allCheckedEvent){
        if(this.allCheckedList.length == this.allCheckedListLength && this.allCheckedList.length > 0){
          this.allCheckedEvent.checked = true;
        }else{
          this.allCheckedEvent.checked = false;
        }
      }
    }
    //console.log(this.allCheckedList);
    if(this.allCheckedList.length > 0){
      this.multipleDelete = true;
    }else{
      this.multipleDelete = false;
    }
    //console.log(this.multipleDelete);
  }

  multipleDeleteCheckboxes(){
    if(confirm("Are you sure to delete ?")) {
      let objCode = {code: this.allCheckedList};
      //console.log(objCode);
      
      this.apiservice.deleteProduct(objCode).subscribe(res => {
        //console.log(res);
        if(res.merror == 200){
          destroydtSample();
          //alert(res.merrormsg);
          this.multipleDelete = false;
          this.ngOnInit();
          this.alert = true;
          this.alertMessage = res.merrormsg;
          this.alertSuccess = false;
          this.allCheckedList = [];
          setTimeout(()=>{
            this.alert = false;
          }, 2000);
        }else{
          alert(res.merror);
        }
        //this.router.navigate(['/product-master-view']);
      });
    }
  }
}
