import { Component, OnInit, ChangeDetectorRef } from '@angular/core';
import { ApiService } from '../../services/api.service';
import {Router, ActivatedRoute} from '@angular/router';
import { LocalStorageService } from '../../services/local-storage.service';

declare var dtSample: any;
declare var destroydtSample: any;
declare var showPageLoader: any;
declare var hidePageLoader: any;

@Component({
  selector: 'app-loan-approval-limit-view',
  templateUrl: './loan-approval-limit-view.component.html',
  styleUrls: ['./loan-approval-limit-view.component.scss']
})
export class LoanApprovalLimitViewComponent implements OnInit {

  loanApprovalLimitListArray = [];
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

    this.rightsData = this.storage.getSessionStorage('rights');
    //console.log(this.rightsData);

    this.apiservice.getAllLoanApprovalLimitList().subscribe(res =>{
      //console.log(res);
      this.loanApprovalLimitListArray = res;
      //this.dataArray = res;
      //console.log(this.loanApprovalLimitListArray);
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

  dataNavigate(list){
    const stringify = JSON.stringify(list);

    if(this.rightsData.browse == 1){
      this.router.navigate(['/loan-approval-limit-ind-view'], { skipLocationChange: true, queryParams: { first: stringify } });
    }
  }

  allCheckboxes(event) {
    const checked = event.target.checked;
    this.allCheckedEvent = event.target;
    //console.log(checked);
    if(checked){
      this.allCheckedList = [];
    }
    this.loanApprovalLimitListArray.forEach(item => 
      {
        item.selected = checked;
        if(checked){
          //this.allCheckedList = [];
          this.allCheckedList.push(item.loanApprovalLimitCompositeEntity);      
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
      
      this.allCheckedList.push(option.loanApprovalLimitCompositeEntity);
      
      if(this.allCheckedEvent){
        if(this.allCheckedList.length == this.allCheckedListLength && this.allCheckedList.length > 0){
          this.allCheckedEvent.checked = true;
        }else{
          this.allCheckedEvent.checked = false;
        }
      }
      
    }else{
      for(var i=0 ; i < this.allCheckedList.length; i++) {
        if(this.allCheckedList[i].msrno == option.loanApprovalLimitCompositeEntity.msrno && this.allCheckedList[i].mgrpcd == option.loanApprovalLimitCompositeEntity.mgrpcd && this.allCheckedList[i].mlbrcode == option.loanApprovalLimitCompositeEntity.mlbrcode && this.allCheckedList[i].musercd == option.loanApprovalLimitCompositeEntity.musercd) {
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
      
      this.apiservice.deleteLoanApprovalLimit(objCode).subscribe(res => {
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
        //this.router.navigate(['/loan-approval-limit-view']);
      });
    }
  }

}
