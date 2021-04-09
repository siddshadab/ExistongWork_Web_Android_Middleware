import { Component, OnInit } from '@angular/core';
import { LocalStorageService } from '../../services/local-storage.service';
import {Router} from '@angular/router';

@Component({
  selector: 'app-dashboard',
  templateUrl: './dashboard.component.html',
  styleUrls: ['./dashboard.component.scss']
})
export class DashboardComponent implements OnInit {

  constructor(private storage: LocalStorageService, private router: Router) { }

  hasSessionKey:boolean = false;

  ngOnInit() {
    this.hasSessionKey = this.storage.hasKeySessionStorage('sessionKey');
    console.log(this.hasSessionKey);
    if (this.hasSessionKey == false) {
      //this.router.navigate(['/login']);
    } 
  }

}
