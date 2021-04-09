import { Component, AfterViewInit, OnInit } from '@angular/core';
import { BnNgIdleService } from 'bn-ng-idle'; // import it to your component
import {Router, NavigationEnd} from '@angular/router';
import { filter } from 'rxjs/operators';
import { LocalStorageService } from './services/local-storage.service';
import { ApiService } from './services/api.service';
import { TranslateService } from '@ngx-translate/core';

//declare var pageWrapperSpacing: any;

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.scss']
})
export class AppComponent implements OnInit, AfterViewInit{
  title = 'MFI';
  headerExist:boolean = false;
  sessionExist:boolean = false;
  //dataArray = ['20','30','40','50'];
  //listData = '10';
  datas;

  constructor(private bnIdle: BnNgIdleService, private apiservice:ApiService, private router: Router, private storage: LocalStorageService, public translate: TranslateService) { // initiate it in your component constructor
    translate.addLangs(['English','French']);
    translate.setDefaultLang('English');
    const browserLang = translate.getBrowserLang();
    translate.use(browserLang.match(/English|French/) ? browserLang : 'English');
    //console.log(this.router.url);
    //console.log('constructor');

    //let item = JSON.parse(sessionStorage.getItem('key'));
    //window.sessionStorage.clear();
    //console.log(item);

    //this.storage.setSessionStorage('key','MFI');
    
    router.events.pipe(
      filter(event => event instanceof NavigationEnd)  
    ).subscribe((event: NavigationEnd) => {
      //console.log(event.url);
      if(!(event.url === '/' || event.url === '/login')){
        this.headerExist = true;
        //console.log('coming');
        this.bnIdle.startWatching(1800).subscribe((res) => {
          //console.log(res);
          if(res) {
              //console.log("session expired");
              //sessionStorage.clear();
              this.storage.clearSessionStorage();
              alert("Session Expired");
              this.router.navigate(['/login']);
              // this.router.navigate(['/login']).then(() => {
              //   window.location.reload();
              // });
              window.alert = function() {};
              this.bnIdle.stopTimer();
              //window.location.reload();
          }

        });
      }
      
    });
  }

  ngOnInit(){
    //console.log('oninit');

    this.apiservice.getAllLookup().subscribe(res => {
      //console.log(res);
      this.storage.setSessionStorage('lookupData',res);
    });

    this.apiservice.productDropdown().subscribe(res => {
      this.storage.setSessionStorage('productDropdownData',res);
    });
    this.apiservice.branchDropdown().subscribe(res => {
      //console.log(res);
      this.storage.setSessionStorage('branchDropdownData',res);
    });

    this.apiservice.getUserCodeDescription().subscribe(res => {
      console.log(res);
      this.storage.setSessionStorage('reportingUserDropdown',res);
    });

    this.apiservice.getCurrencies().subscribe(res => {
      //console.log(res);
      this.storage.setSessionStorage('currencyDropdown',res);
    });

    this.apiservice.countryList().subscribe(res => {
      //console.log(res);
      this.storage.setSessionStorage('countryDropdown',res);
    });

    this.apiservice.getAllStates().subscribe(res => {
      console.log(res);
      this.storage.setSessionStorage('stateDropdown',res);
    });

    // let stateObj = {mcountryid : "US"};
    // this.apiservice.stateListByCountry(stateObj).subscribe(res => {
    //   console.log(res);
    //   //this.storage.setSessionStorage('currencyDropdown',res);
    // });

    // let districtObj = {mstatecd : "AK"};
    // this.apiservice.districtListByState(districtObj).subscribe(res => {
    //   console.log(res);
    //   //this.storage.setSessionStorage('currencyDropdown',res);
    // });

    // let cityObj = {mdistcd : 10};
    // this.apiservice.cityListByDistrict(cityObj).subscribe(res => {
    //   console.log(res);
    //   //this.storage.setSessionStorage('currencyDropdown',res);
    // });

    // let code = {mgrpcd: 12};
    // this.apiservice.menuData(code).subscribe(res => {
    //   console.log(res);
    // });
    //console.log(this.datas);
    //console.log(this.router.url);
    //pageWrapperSpacing();
  }

  ngAfterViewInit(){
    //pageWrapperSpacing();
  }

  dateInISO(){
    console.log('working');
  }

  

}
