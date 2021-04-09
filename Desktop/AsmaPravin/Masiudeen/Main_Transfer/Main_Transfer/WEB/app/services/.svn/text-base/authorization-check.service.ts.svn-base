import { Injectable } from '@angular/core';
import { Router, CanActivate, ActivatedRouteSnapshot, RouterStateSnapshot } from '@angular/router';
import { LocalStorageService } from './local-storage.service';

@Injectable({
  providedIn: 'root'
})
export class AuthorizationCheckService implements CanActivate {

  constructor(private router: Router, private storage: LocalStorageService) { }

  canActivate(route: ActivatedRouteSnapshot, state: RouterStateSnapshot){
    if(this.storage.hasKeySessionStorage('sessionKey')){
      //this.router.navigate(['/login']);
      return true;
    }

    //this.router.navigate(['/login'], { queryParams: { returnUrl: state.url } });
    this.router.navigate(['/login']);
    return false;
  }
}
