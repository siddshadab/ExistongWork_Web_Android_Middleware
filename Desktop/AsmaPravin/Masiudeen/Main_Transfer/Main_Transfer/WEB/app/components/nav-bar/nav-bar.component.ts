import { Component, OnInit } from '@angular/core';
import { LocalStorageService } from '../../services/local-storage.service';
import { ApiService } from '../../services/api.service';
import {Router} from '@angular/router';

declare var newTest: any;

@Component({
  selector: 'app-nav-bar',
  templateUrl: './nav-bar.component.html',
  styleUrls: ['./nav-bar.component.scss']
})
export class NavBarComponent implements OnInit {

  navMenuData:any;
  currentGrpCd:any;

  constructor(private router: Router,private apiservice:ApiService, private storage: LocalStorageService) {
  }

  ngOnInit() {
    //newTest();
    this.currentGrpCd = this.storage.getSessionStorage('grpcd');
    let objCode = {mgrpcd: this.currentGrpCd};
    //let objCode = {mgrpcd: 12};
    //console.log(objCode);
    this.apiservice.menuData(objCode).subscribe(res => {
      console.log(res);
      this.navMenuData = res;
      //console.log("preview:" + JSON.stringify(res))
    });
  }

  userAccessRightsData(data){
    //console.log(data);
    
    // data = {"menu": "Dashboard",
    //           "url": "",
    //           "create": "1",
    //           "browse": "1",
    //           "delete": "1",
    //           "authoritye": "1",
    //           "sub menu": {}
    //         }
    this.storage.setSessionStorage('rights',data);
  }

}
