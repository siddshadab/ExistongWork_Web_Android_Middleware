import { LocalStorageService } from './../services/local-storage.service';
import { ApiService } from './../services/api.service';
import { Component, OnInit, ViewChild, ElementRef, ChangeDetectorRef } from '@angular/core';
import { Router, ActivatedRoute } from '@angular/router';


declare var dtSample: any;
declare var destroydtSample: any;
declare var $;
@Component({
  selector: 'app-secondary-user-master-view',
  templateUrl: './secondary-user-master-view.component.html',
  styleUrls: ['./secondary-user-master-view.component.scss']
})
export class SecondaryUserMasterViewComponent implements OnInit {


  userListArray = [];
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

  //dataArray = ['test','best','rest'];
  //userDataFetched:boolean = false;
  //testobj = {mockup_id: "123", project_id: "456", module_id: "678", release_id: "890", requirement_id: "432"};

  @ViewChild('dataTable', {static: false}) table: ElementRef;
  dataTable:any;
  dtOptions:any;
  curUserCode:any;

  constructor(private apiservice:ApiService, private router: Router,private route: ActivatedRoute, private storage: LocalStorageService, private chRef: ChangeDetectorRef) { }

  fetchUserList() { 
    // return new Promise((resolve, reject) => {
    //     const usrcode_data = this.storage.getSessionStorage('usrcode');
    //     console.log(usrcode_data);
    //     const userList = {"musrcode":usrcode_data};
    //     console.log(this.userDataFetched);
    //     console.log('f1');
    //     this.apiservice.getUserData(userList).subscribe(res =>{
    //       this.userListArray = res;
    //       if(res){
    //         //dtSample();
    //       }
          
    //       resolve();
    //     },
    //     err => {
    //       reject(err);
    //     });
    // });
  }
  ngOnInit() {
    
    //console.log(this.storage.getSessionStorage('usrcode'));
    let api = this.apiservice;

    this.rightsData = this.storage.getSessionStorage('rights');
    //console.log(this.rightsData);

    //const usrcode_data = this.storage.getSessionStorage('usrcode');
    //console.log(usrcode_data);
    //const userList = {"musrcode":usrcode_data};
    //this.apiservice.getUserData(userList).subscribe(res =>{
    this.apiservice.getAllSeondaryUser().subscribe(res =>{
      console.log(res);
      
      //this.dataArray = res;
      //console.log(this.userListArray);
      res.forEach(function (value) {
        //console.log(value.mgender);
       // value.mgenderDesc = api.getLookupName(1139,value.mgender);
        value.mstatusDesc = api.getLookupName(1010,value.mstatus);
       // value.mgrpcdDesc = api.getLookupName(1009,value.mgrpcd);
        //console.log(value.mgrpcdDesc);
        //console.log(value);
      });
      //console.log(res);
      this.userListArray = res;
      this.chRef.detectChanges();
      dtSample();
    });

    //let lookup = this.apiservice.getLookupName(1139,'M');
    //console.log(lookup);
    
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

  dataNavigate(list){
    //if(this.rightsData.browse == 1){
      this.router.navigate(['/secondary-user-master-ind-view'], { skipLocationChange: true, queryParams: list });
  //  }
    
  }

  allCheckboxes(event) {
    const checked = event.target.checked;
    this.allCheckedEvent = event.target;
    //console.log(checked);
    if(checked){
      this.allCheckedList = [];
    }
    this.userListArray.forEach(item => 
      {
        item.selected = checked;
        //console.log(item);
        if(checked){
          //this.allCheckedList = [];
          this.allCheckedList.push(String(item.musrcode));      
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
      
      this.allCheckedList.push(String(option.musrcode));
      
      if(this.allCheckedEvent){
        if(this.allCheckedList.length == this.allCheckedListLength && this.allCheckedList.length > 0){
          this.allCheckedEvent.checked = true;
        }else{
          this.allCheckedEvent.checked = false;
        }
      }
      
    }else{
      for(var i=0 ; i < this.allCheckedList.length; i++) {
        if(this.allCheckedList[i] == option.musrcode) {
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
    let objCode = {musrcode: this.allCheckedList};
    //console.log(objCode);
    
    this.apiservice.deleteSecondaryUser(objCode).subscribe(res => {
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
      //this.router.navigate(['/user-master-view']);
    });
  }

}
