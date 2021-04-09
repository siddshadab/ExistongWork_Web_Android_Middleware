import { Component, OnInit, ChangeDetectorRef } from '@angular/core';
import { ApiService } from '../../services/api.service';
import {Router, ActivatedRoute} from '@angular/router';
import { LocalStorageService } from '../../services/local-storage.service';


declare var dtSample: any;
declare var destroydtSample: any;
declare var showPageLoader: any;
declare var hidePageLoader: any;

@Component({
  selector: 'app-loan-cycle-parameter-primary-view',
  templateUrl: './loan-cycle-parameter-primary-view.component.html',
  styleUrls: ['./loan-cycle-parameter-primary-view.component.scss']
})
export class LoanCycleParameterPrimaryViewComponent implements OnInit {

  loanCycleListArray = [];
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

    this.apiservice.getAllLoanCycleParameterPrimaryList().subscribe(res =>{
      //console.log(res);

      res.forEach(function (value) {
        //console.log(value.mgender);
        value.loanCycleDesc = api.getLookupName(909060,value.loanCycleParameterPrimaryCompositeEntity.mloancycle);
        value.groupTypeDesc = api.getLookupName(1076,value.loanCycleParameterPrimaryCompositeEntity.mgrtype);
        value.customerTypeDesc = api.getLookupName(1060,value.loanCycleParameterPrimaryCompositeEntity.mcusttype);
        value.frequencyDesc = api.getLookupName(909019,value.mfrequency);
        value.groupCycleDesc = api.getLookupName(30125,value.mgrpcycyn);
        value.logicDesc = api.getLookupName(909061,value.mlogic);
        value.ruleTypeDesc = api.getLookupName(75559,value.mruletype);
        value.genderDesc = api.getLookupName(1139,value.mgender);
        //console.log(value.mgrpcdDesc);
        //console.log(value);
      });
      this.loanCycleListArray = res;
      //this.dataArray = res;
      //console.log(this.loanCycleListArray);
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
    //console.log(list);
    if(this.rightsData.browse == 1){

      let api = this.apiservice;
      //console.log(list.loanCycleParameterPrimaryCompositeEntity);
      this.apiservice.getAllLoanCycleParameterSecondaryList(list.loanCycleParameterPrimaryCompositeEntity).subscribe(res =>{
        //console.log(res);
        res.forEach(function (value) {
          value.frequencyDesc = api.getLookupName(909019,value.loanCycleParameterSecondaryCompositeEntity.mfrequency);
          value.ruleTypeDesc = api.getLookupName(75559,value.loanCycleParameterSecondaryCompositeEntity.mruletype);
          //console.log(value);
        });
        const stringify = JSON.stringify(list);
        const secondData = JSON.stringify(res);
        this.router.navigate(['/loan-cycle-parameter-primary-ind-view'], { skipLocationChange: true, queryParams: { first: stringify, second: secondData } });
      });
      
    }
    

  }

  allCheckboxes(event) {
    const checked = event.target.checked;
    this.allCheckedEvent = event.target;
    //console.log(checked);
    if(checked){
      this.allCheckedList = [];
    }
    this.loanCycleListArray.forEach(item => 
      {
        item.selected = checked;
        if(checked){
          //this.allCheckedList = [];
          this.allCheckedList.push(item.loanCycleParameterPrimaryCompositeEntity);      
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
      
      this.allCheckedList.push(option.loanCycleParameterPrimaryCompositeEntity);
      
      if(this.allCheckedEvent){
        if(this.allCheckedList.length == this.allCheckedListLength && this.allCheckedList.length > 0){
          this.allCheckedEvent.checked = true;
        }else{
          this.allCheckedEvent.checked = false;
        }
      }
      
    }else{
      for(var i=0 ; i < this.allCheckedList.length; i++) {
        if(this.allCheckedList[i].mcusttype == option.loanCycleParameterPrimaryCompositeEntity.mcusttype && this.allCheckedList[i].meffdate == option.loanCycleParameterPrimaryCompositeEntity.meffdate && this.allCheckedList[i].mgrtype == option.loanCycleParameterPrimaryCompositeEntity.mgrtype && this.allCheckedList[i].mlbrcode == option.loanCycleParameterPrimaryCompositeEntity.mlbrcode && this.allCheckedList[i].mloancycle == option.loanCycleParameterPrimaryCompositeEntity.mloancycle && this.allCheckedList[i].mprdcd == option.loanCycleParameterPrimaryCompositeEntity.mprdcd) {
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
      //this.deleteData.push(this.primaryData.loanCycleParameterPrimaryCompositeEntity);
      //console.log(this.deleteData);
      let objCode = this.allCheckedList;
      //let objCode = {code: this.allCheckedList};
      //console.log(objCode);
      
      //console.log(objCode);
      this.apiservice.deleteLoanCycleParameterPrimary(objCode).subscribe(res => {
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
      });
    }
  }

}
