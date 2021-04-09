import { Component, OnInit, ChangeDetectorRef } from '@angular/core';
import { ApiService } from '../../services/api.service';
import {Router, ActivatedRoute} from '@angular/router';
import { LocalStorageService } from '../../services/local-storage.service';

declare var dtSample: any;
declare var destroydtSample: any;
declare var showPageLoader: any;
declare var hidePageLoader: any;

@Component({
  selector: 'app-branch-master-view',
  templateUrl: './branch-master-view.component.html',
  styleUrls: ['./branch-master-view.component.scss']
})
export class BranchMasterViewComponent implements OnInit {

  branchListArray = [];
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

    this.apiservice.getBranchList().subscribe(res =>{
      //console.log(res);
      
      res.forEach(function (value) {
        //console.log(value.mbranchtype);
        value.mbranchtypeDesc = api.getLookupName(1031,value.mbranchtype);
        value.mbranchcatDesc = api.getLookupName(78620,value.mbranchcat);
        value.mweekoff1Desc = api.getLookupName(1019,value.mweekoff1);
        value.mweekoff2Desc = api.getLookupName(1019,value.mweekoff2);
        //console.log(value.mgender);
        //console.log(value);
      });

      this.branchListArray = res;
      //console.log(this.branchListArray);
      this.chRef.detectChanges();
      dtSample();
      hidePageLoader();
    });

    this.sub = this.route
      .queryParams
      .subscribe(params => {
        //console.log(params);
        //console.log(params[0]);
        //console.log(Object.keys(params).length);
        if(Object.keys(params).length > 0){
          this.alert = params[0];
          this.alertMessage = params[1];
          this.alertSuccess = Boolean(JSON.parse(params[2]));
          //this.branchData = params;
          //console.log(this.alert);
          //console.log(this.alertMessage);
          //console.log(this.alertSuccess);

          setTimeout(()=>{
            this.alert = false;
          }, 2000);
        }
        
    });
  }

  dataNavigate(list){
    //console.log(list);
    if(this.rightsData.browse == 1){
      this.router.navigate(['/branch-master-ind-view'], { skipLocationChange: true, queryParams: list });
    }
  }

  allCheckboxes(event) {
    const checked = event.target.checked;
    this.allCheckedEvent = event.target;
    //console.log(checked);
    if(checked){
      this.allCheckedList = [];
    }
    this.branchListArray.forEach(item => 
      {
        item.selected = checked;
        if(checked){
          //this.allCheckedList = [];
          this.allCheckedList.push(String(item.mpbrcode));      
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
      
      this.allCheckedList.push(String(option.mpbrcode));
      
      if(this.allCheckedEvent){
        if(this.allCheckedList.length == this.allCheckedListLength && this.allCheckedList.length > 0){
          this.allCheckedEvent.checked = true;
        }else{
          this.allCheckedEvent.checked = false;
        }
      }
      
    }else{
      for(var i=0 ; i < this.allCheckedList.length; i++) {
        if(this.allCheckedList[i] == option.mpbrcode) {
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
      let objBrCode = {mpbrcode: this.allCheckedList};
      //console.log(objBrCode);
      
      this.apiservice.deleteBranch(objBrCode).subscribe(res => {
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
          //console.log(test);
        }else{
          alert(res.merror);
        }
        //this.router.navigate(['/branch-master-view']);
      });
    }
  }

}
