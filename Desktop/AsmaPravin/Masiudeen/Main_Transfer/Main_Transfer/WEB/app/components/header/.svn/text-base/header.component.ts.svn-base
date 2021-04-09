import { Component, OnInit } from '@angular/core';
import { LocalStorageService } from '../../services/local-storage.service';
import {Router} from '@angular/router';

@Component({
  selector: 'app-header',
  templateUrl: './header.component.html',
  styleUrls: ['./header.component.scss']
})
export class HeaderComponent implements OnInit {

  constructor(private router: Router, private storage: LocalStorageService) { }

  ngOnInit() {
  }

  logout(){
    //console.log('logout');
    this.storage.clearSessionStorage();
    this.router.navigate(['/login']);
  }

}
