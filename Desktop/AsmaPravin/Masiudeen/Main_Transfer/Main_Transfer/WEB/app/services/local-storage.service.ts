import { Inject, Injectable } from '@angular/core';
import { LOCAL_STORAGE, StorageService, SESSION_STORAGE } from 'ngx-webstorage-service';

@Injectable({
  providedIn: 'root'
})
export class LocalStorageService {

  constructor(@Inject (LOCAL_STORAGE) private localStorage: StorageService, @Inject (SESSION_STORAGE) private sessionStorage : StorageService) { }

  setLocalStorage(key,value){
    this.localStorage.set(key, value);
  }

  getLocalStorage(key){
    return this.localStorage.get(key);
  }

  removeFromLocalStorage(key){
    this.localStorage.remove(key);
  }

  clearLocalStorage(){
    this.localStorage.clear();
  }

  hasKeyLocalStorage(key){
    return this.localStorage.has(key);
  }

  setSessionStorage(key,value){
    this.sessionStorage.set(key,value);
  }

  getSessionStorage(key){
    return this.sessionStorage.get(key);
  }

  hasKeySessionStorage(key){
    return this.sessionStorage.has(key);
  }

  removeFromSessionStorage(key){
    this.sessionStorage.remove(key);
  }

  clearSessionStorage(){
    this.sessionStorage.clear();
  }
}
