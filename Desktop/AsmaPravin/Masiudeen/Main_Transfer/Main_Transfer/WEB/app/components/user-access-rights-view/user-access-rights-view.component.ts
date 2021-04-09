import { Component, OnInit, ChangeDetectorRef, ViewChild, ElementRef } from '@angular/core';
import { LocalStorageService } from '../../services/local-storage.service';
import { Router, ActivatedRoute } from '@angular/router';
import { ApiService } from '../../services/api.service';


declare var dtSample: any;
declare var destroydtSample: any;
declare var showPageLoader: any;
declare var hidePageLoader: any;
declare var $;

@Component({
  selector: 'app-user-access-rights-view',
  templateUrl: './user-access-rights-view.component.html',
  styleUrls: ['./user-access-rights-view.component.scss']
})
export class UserAccessRightsViewComponent implements OnInit {

  dataArray = ['test','best','rest'];
  userDataFetched:boolean = false;
  testobj = {mockup_id: "123", project_id: "456", module_id: "678", release_id: "890", requirement_id: "432"};

  @ViewChild('dataTable', {static: false}) table: ElementRef;

  dataTable:any;
  dtOptions:any;
  curUserCode:any;
  accessRightsListArray = [];
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
  reportingUserDropdown:any;
  reportUsrName:any;

  constructor(private apiservice:ApiService, private router: Router, private route: ActivatedRoute, private storage: LocalStorageService, private chRef: ChangeDetectorRef) { }

  ngOnInit() {

    showPageLoader();

    let api = this.apiservice;

    this.rightsData = this.storage.getSessionStorage('rights');
    //console.log(this.rightsData);

     this.apiservice.getUserRightsData().subscribe(res =>{
       //console.log(res);
       this.accessRightsListArray = res;
       this.dataArray = res;
       res.forEach(function (value) {
        
        value.mgrpcdDesc = api.getLookupName(1009,value.userAccressRightsCompositeEntity.mgrpcd);
        //console.log(value.mgrpcdDesc);
        //console.log(value);
      });
       //console.log(this.accessRightsListArray);
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

  userRightsAdd(){
    this.router.navigate(['/user-access-rights']);
  }

  dataNavigate(list){
    //console.log(list);
    const stringify = JSON.stringify(list);
    //const parse = JSON.parse(stringify);
    //console.log(stringify);
    //console.log(parse);
    if(this.rightsData.browse == 1){
      this.router.navigate(['/user-access-rights-ind-view'], { skipLocationChange: true, queryParams: { first: stringify } });
    }
  }

  allCheckboxes(event) {
    const checked = event.target.checked;
    this.allCheckedEvent = event.target;
    //console.log(checked);
    if(checked){
      this.allCheckedList = [];
    }
    this.accessRightsListArray.forEach(item => 
      {
        item.selected = checked;
        if(checked){
          //this.allCheckedList = [];
          this.allCheckedList.push(item.userAccressRightsCompositeEntity);      
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
    
    //console.log(e);
    //console.log(e.target.checked);
    if(e.target.checked) {
      
      this.allCheckedList.push(option.userAccressRightsCompositeEntity);
      
      if(this.allCheckedEvent){
        if(this.allCheckedList.length == this.allCheckedListLength && this.allCheckedList.length > 0){
          this.allCheckedEvent.checked = true;
        }else{
          this.allCheckedEvent.checked = false;
        }
      }
      
    }else{
      for(var i=0 ; i < this.allCheckedList.length; i++) {
        if(this.allCheckedList[i].menuid == option.userAccressRightsCompositeEntity.menuid && this.allCheckedList[i].mgrpcd == option.userAccressRightsCompositeEntity.mgrpcd && this.allCheckedList[i].usrcode == option.userAccressRightsCompositeEntity.usrcode) {
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
      
      this.apiservice.deleteUserRightsData(objCode).subscribe(res => {
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
        //this.router.navigate(['/user-access-rights-view']);
      });
    }
  }

}
