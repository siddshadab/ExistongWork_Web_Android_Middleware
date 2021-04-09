import { Injectable } from '@angular/core';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Observable } from  'rxjs';
import { LocalStorageService } from './local-storage.service';
import * as moment from 'moment';

//const headers = new HttpHeaders().set('Content-Type', 'application/json; charset=utf-8');

@Injectable({
  providedIn: 'root'
})
export class ApiService {
  date: moment.Moment;

  constructor(private httpClient: HttpClient, private storage: LocalStorageService) { }

  //DB_API_SERVER = "http://172.25.3.92:8090";
  DB_API_SERVER = "http://172.25.3.75:8090";
  //DB_API_SERVER = "http://14.141.164.236:8090";

  // existUsers(): Observable<any>{
  //   return this.httpClient.get<any>(`http://172.25.3.92:8090/lookupMasterController/getAllLookup/`);
  // }


  menuData(data): Observable<any>{
    return this.httpClient.post<any>(`${this.DB_API_SERVER}/jsonMenu/menuByGrpCd`,data);
  }

  existUsers(data): Observable<any>{
    return this.httpClient.post<any>(`${this.DB_API_SERVER}/userDetailsMaster/loginValidation`,data);
  }

  getJsonData():Observable<any>{
    //return this.httpClient.get<any>(`https://jsonplaceholder.typicode.com/users`);
    
    return this.httpClient.get<any>(`http://dummy.restapiexample.com/api/v1/employees`);
  }

  getUserData():Observable<any>{
    //return this.httpClient.post<any>(`${this.DB_API_SERVER}/userDetailsMaster/get`,data);
    return this.httpClient.get<any>(`${this.DB_API_SERVER}/userDetailsMaster/getAllUsr`);
    //return this.httpClient.get<any>(`http://dummy.restapiexample.com/api/v1/employees`);
  }
  
  postUserData(data):Observable<any>{
    return this.httpClient.post(`${this.DB_API_SERVER}/userDetailsMaster/add`,data);
  }

  updateUserData(data):Observable<any>{
    return this.httpClient.post(`${this.DB_API_SERVER}/userDetailsMaster/update`,data);
  }

  deleteUserData(data):Observable<any>{
    return this.httpClient.post(`${this.DB_API_SERVER}/userDetailsMaster/delete`,data);
  }

  userCodeExist(data):Observable<any>{
    return this.httpClient.post<any>(`${this.DB_API_SERVER}/userDetailsMaster/findRecByUsrCd/`,data);
  }

  getUserCodeDescription():Observable<any>{
    return this.httpClient.get<any>(`${this.DB_API_SERVER}/userDetailsMaster/getUsrCdDesc`);
  }



  getPosition(): Promise<any>
  {
    return new Promise((resolve, reject) => {

      navigator.geolocation.getCurrentPosition(resp => {

          resolve({lng: resp.coords.longitude, lat: resp.coords.latitude});
        },
        err => {
          reject(err);
      });
    });

  }

  changePassword(data): Observable<any>{
    return this.httpClient.post<any>(`${this.DB_API_SERVER}/userDetailsMaster/changePassword/`,data);
  }

  existLookupCode(data): Observable<any>{
    return this.httpClient.post<any>(`${this.DB_API_SERVER}/lookupMasterController/add`,data);
  }

  dateInIso(data):any{
    //console.log(data);
    let new_data;
    if(data){
      let dates = moment.utc(data).local();
      new_data = dates.format('YYYY-MM-DDTHH:mm:ss.SSS');
      //console.log(new_data)
    }else{
      new_data = null;
    }
    
    return new_data;
  }

  getLookupName(codeType,code):any{
    //console.log('in');
    let lookupName;
    let lookupCode;
    let lookupData = this.storage.getSessionStorage('lookupData');
    let lookup = lookupData[codeType];
    //console.log(lookup);
    //console.log(code);
    lookupCode = lookup.find(e => e.lookupComposite.mcode == code);
    //console.log(lookupCode);
    if(lookupCode){
      lookupName = lookupCode.mcodedesc;
    }else{
      lookupName = code;
    }
    
    return lookupName;
  }

  //user access rights service

  //List view
  getUserRightsData():Observable<any>{
    return this.httpClient.get<any>(`${this.DB_API_SERVER}/userAccessRights/getAllUserAccessRightsFromMaster`);   
  }

  //Submiting form 
  addUserRightsData(data):Observable<any>{
    return this.httpClient.post<any>(`${this.DB_API_SERVER}/userAccessRights/add`,data);
  }

  //edit page
  editUserRightsData(data):Observable<any>{
    return this.httpClient.post<any>(`${this.DB_API_SERVER}/userAccessRights/update`,data);
  }

  //delete page
  deleteUserRightsData(data):Observable<any>{
    return this.httpClient.post<any>(`${this.DB_API_SERVER}/userAccessRights/delete`,data);
  }
 

  //product master

  //add product
  addProductData(data):Observable<any>{
    return this.httpClient.post<any>(`${this.DB_API_SERVER}/productData/addPrd`,data);
  }

  //list product
  getProductList():Observable<any>{
    return this.httpClient.get<any>(`${this.DB_API_SERVER}/productData/getlistOfproduct`);   
  }

  //delete product
  deleteProduct(data):Observable<any>{
    return this.httpClient.post<any>(`${this.DB_API_SERVER}/productData/delete`,data);  
  }

  //update product
  updateProduct(data):Observable<any>{
    return this.httpClient.post<any>(`${this.DB_API_SERVER}/productData/update`,data);  
  }

  productCompositeEntityExist(data):Observable<any>{
    return this.httpClient.post<any>(`${this.DB_API_SERVER}/productData/findByMlbrcode/`,data);
  }

  productDropdown(){
    return this.httpClient.get<any>(`${this.DB_API_SERVER}/productData/getPrdCdDesc`);
  }

  getCurrencies():Observable<any>{
    return this.httpClient.get<any>(`${this.DB_API_SERVER}/currencyMaster/getAll`);   
  }

  // Branch Master Related services

  getBranchList():Observable<any>{
    return this.httpClient.get<any>(`${this.DB_API_SERVER}/branchMaster/branchMasterAll`);
  }

  postBranchData(data):Observable<any>{
    //console.log("post brnach data");
    return this.httpClient.post(`${this.DB_API_SERVER}/branchMaster/add`,data);
  }

  deleteBranch(data):Observable<any>{
    return this.httpClient.post<any>(`${this.DB_API_SERVER}/branchMaster/delete`,data);  
  }

  updateBranch(data):Observable<any>{
    return this.httpClient.post<any>(`${this.DB_API_SERVER}/branchMaster/update`,data);  
  }

  branchCodeExist(data):Observable<any>{
    return this.httpClient.post<any>(`${this.DB_API_SERVER}/branchMaster/findRecByLbrCode/`,data);
  }

  branchDropdown():Observable<any>{
    return this.httpClient.get<any>(`${this.DB_API_SERVER}/branchMaster/getBranchCdDesc`);
  }


  // Loan approval limit services

  getAllLoanApprovalLimitList():Observable<any>{
    return this.httpClient.get<any>(`${this.DB_API_SERVER}/LoanApprovalLimitController/getAll`);
  }

  postLoanApprovalLimit(data):Observable<any>{
    return this.httpClient.post<any>(`${this.DB_API_SERVER}/LoanApprovalLimitController/add`,data);  
  }

  updateLoanApprovalLimit(data):Observable<any>{
    return this.httpClient.post<any>(`${this.DB_API_SERVER}/LoanApprovalLimitController/update`,data);  
  }

  deleteLoanApprovalLimit(data):Observable<any>{
    return this.httpClient.post<any>(`${this.DB_API_SERVER}/LoanApprovalLimitController/delete`,data);  
  }

  // Loan cycle parameter primary services
  getAllLoanCycleParameterPrimaryList():Observable<any>{
    return this.httpClient.get<any>(`${this.DB_API_SERVER}/LoanCycleParameterPrimaryController/getAllLoanCycleParameterPrimary/`);
  }
  
  postLoanCycleParameterPrimary(data):Observable<any>{
    //return this.httpClient.post<any>(`${this.DB_API_SERVER}/LoanCycleParameterPrimaryController/add`,data);  
    //return this.httpClient.post<any>(`${this.DB_API_SERVER}/loanCycle/addLoanCycle`,data);
    return this.httpClient.post<any>(`${this.DB_API_SERVER}/LoanCycleParameterPrimaryController/add`,data);   
  }

  postLoanCycleParameterSecondary(data):Observable<any>{
    return this.httpClient.post<any>(`${this.DB_API_SERVER}/LoanCycleParameterSecondaryController/add`,data);   
  }

  updateLoanCycleSecondary(data):Observable<any>{
    //return this.httpClient.post<any>(`${this.DB_API_SERVER}/loanCycle/editLoanCyclePrimary`,data);
    return this.httpClient.post<any>(`${this.DB_API_SERVER}/loanCycle/editLoanCycleSecondary`,data);
  }

  updateLoanCycleParameterPrimary(data):Observable<any>{
    //return this.httpClient.post<any>(`${this.DB_API_SERVER}/LoanCycleParameterPrimaryController/update`,data);  
    //return this.httpClient.post<any>(`${this.DB_API_SERVER}/loanCycle/editLoanCycle`,data);
    return this.httpClient.post<any>(`${this.DB_API_SERVER}/loanCycle/editLoanCyclePrimary`,data);  
  }

  deleteLoanCycleParameterSecondary(data):Observable<any>{
    //return this.httpClient.post<any>(`${this.DB_API_SERVER}/loanCycle/deleteLoanCycle`,data); 
    return this.httpClient.post<any>(`${this.DB_API_SERVER}/LoanCycleParameterSecondaryController/delete`,data); 
  }

  deleteLoanCycleParameterPrimary(data):Observable<any>{
    //return this.httpClient.post<any>(`${this.DB_API_SERVER}/LoanCycleParameterPrimaryController/delete`,data); 
    return this.httpClient.post<any>(`${this.DB_API_SERVER}/loanCycle/bulkDelete`,data); 
  }

  getAllLoanCycleParameterSecondaryList(data):Observable<any>{
    return this.httpClient.post<any>(`${this.DB_API_SERVER}/LoanCycleParameterSecondaryController/getLoanCycle`,data);
  }

  //loan level master
  
  //loan list
  getLoanLvlList():Observable<any>{
    return this.httpClient.get<any>(`${this.DB_API_SERVER}/loanlevel/getloanlevel`);
  }

  //add loan level
  addLoanLvl(data):Observable<any>{
    return this.httpClient.post<any>(`${this.DB_API_SERVER}/loanlevel/add`,data);
  }

  //update loan level
  editLoanLvl(data):Observable<any>{
    return this.httpClient.post<any>(`${this.DB_API_SERVER}/loanlevel/update`,data);
  }

  //delete loan level
  deleteLoanLvl(data):Observable<any>{
    return this.httpClient.post<any>(`${this.DB_API_SERVER}/loanlevel/delete`,data);
  }

  mrefnoExist(data):Observable<any>{
    return this.httpClient.post<any>(`${this.DB_API_SERVER}/loanlevel/findByRecByMref/`,data);
  }

  // Lookup Master services

  getAllLookup():Observable<any>{
    return this.httpClient.get<any>(`${this.DB_API_SERVER}/lookupMasterController/getAllLookup/`);
  }

  getLookupMaster():Observable<any>{
    return this.httpClient.get<any>(`${this.DB_API_SERVER}/lookupMasterController/findAll/`);
  }

  addLookupMaster(data):Observable<any>{
    return this.httpClient.post<any>(`${this.DB_API_SERVER}/lookupMasterController/add`,data);
  }

  editLookupMaster(data):Observable<any>{
    return this.httpClient.post<any>(`${this.DB_API_SERVER}/lookupMasterController/edit`,data);
  }

  deleteLookupMaster(data):Observable<any>{
    //return this.httpClient.post<any>(`${this.DB_API_SERVER}/lookupMasterController/delete`,data);
    return this.httpClient.post<any>(`${this.DB_API_SERVER}/lookupMasterController/deleteByBulk`,data);
  }

  getlookupcode(data):Observable<any>{
    return this.httpClient.post<any>(`${this.DB_API_SERVER}/lookupMasterController/findByCodeType`,data);  
  }

  //System Parameter

  getAllSystemParameter():Observable<any>{
    return this.httpClient.get<any>(`${this.DB_API_SERVER}/systemParam/getAllSystemParameter/`);
  }

  addSystemParameter(data):Observable<any>{
    return this.httpClient.post<any>(`${this.DB_API_SERVER}/systemParam/addSys`,data);
  }

  editSystemParameter(data):Observable<any>{
    return this.httpClient.post<any>(`${this.DB_API_SERVER}/systemParam/editSys`,data);
  }

  deleteSystemParameter(data):Observable<any>{
    return this.httpClient.post<any>(`${this.DB_API_SERVER}/systemParam/deleteSys`,data);
  }

  systemParameterCompositeEntityCodeExist(data):Observable<any>{
    return this.httpClient.post<any>(`${this.DB_API_SERVER}/systemParam/findByMcodeMlbrcd/`,data);
  }

  //Address master Dropdown

  countryList():Observable<any>{
    return this.httpClient.get<any>(`${this.DB_API_SERVER}/countries/getlistOfData`);
  }

  stateListByCountry(data):Observable<any>{
    return this.httpClient.post<any>(`${this.DB_API_SERVER}/states/getListofState`,data);
  }

  districtListByState(data):Observable<any>{
    return this.httpClient.post<any>(`${this.DB_API_SERVER}/districts/getAllDistrict`,data);
  }

  cityListByDistrict(data):Observable<any>{
    return this.httpClient.post<any>(`${this.DB_API_SERVER}/subdistricts/getDistricts`,data);
  }

  //Country Master

  getAllCountries():Observable<any>{
    return this.httpClient.get<any>(`${this.DB_API_SERVER}/countries/getlistOfData`);
  }

  addCountry(data):Observable<any>{
    return this.httpClient.post<any>(`${this.DB_API_SERVER}/countries/add`,data);
  }

  editCountry(data):Observable<any>{
    return this.httpClient.post<any>(`${this.DB_API_SERVER}/countries/edit`,data);
  }

  deleteCountry(data):Observable<any>{
    return this.httpClient.post<any>(`${this.DB_API_SERVER}/countries/delete`,data);
  }

  //State Master

  getAllStates():Observable<any>{
    return this.httpClient.get<any>(`${this.DB_API_SERVER}/states/getlistOfData`);
  }

  addState(data):Observable<any>{
    return this.httpClient.post<any>(`${this.DB_API_SERVER}/states/addStates`,data);
  }

  editState(data):Observable<any>{
    return this.httpClient.post<any>(`${this.DB_API_SERVER}/states/editStates`,data);
  }

  deleteState(data):Observable<any>{
    return this.httpClient.post<any>(`${this.DB_API_SERVER}/states/deleteStates`,data);
  }

  //District Master

  getAllDistricts():Observable<any>{
    return this.httpClient.get<any>(`${this.DB_API_SERVER}/districts/getlistOfData`);
  }

  addDistrict(data):Observable<any>{
    return this.httpClient.post<any>(`${this.DB_API_SERVER}/districts/addDistricts`,data);
  }

  editDistrict(data):Observable<any>{
    return this.httpClient.post<any>(`${this.DB_API_SERVER}/districts/editDistricts`,data);
  }

  deleteDistrict(data):Observable<any>{
    return this.httpClient.post<any>(`${this.DB_API_SERVER}/districts/deleteDistricts`,data);
  }

  //Sub District Master

  getAllSubDistricts():Observable<any>{
    return this.httpClient.get<any>(`${this.DB_API_SERVER}/subdistricts/getlistOfData`);
  }

  addSubDistrict(data):Observable<any>{
    return this.httpClient.post<any>(`${this.DB_API_SERVER}/subdistricts/addSubDist`,data);
  }

  editSubDistrict(data):Observable<any>{
    return this.httpClient.post<any>(`${this.DB_API_SERVER}/subdistricts/editSubDist`,data);
  }

  deleteSubDistrict(data):Observable<any>{
    return this.httpClient.post<any>(`${this.DB_API_SERVER}/subdistricts/deleteSubDist`,data);
  }

//secondary user master

  getAllSeondaryUser():Observable<any>{
    return this.httpClient.get<any>(`${this.DB_API_SERVER}/secondaryUserMaster/getAll`);
  }

  addSecondaryUser(data):Observable<any>{
    return this.httpClient.post<any>(`${this.DB_API_SERVER}/secondaryUserMaster/add`,data);
  }

  editSecondaryUser(data):Observable<any>{
    return this.httpClient.post<any>(`${this.DB_API_SERVER}/secondaryUserMaster/edit`,data);
  }

  deleteSecondaryUser(data):Observable<any>{
    return this.httpClient.post<any>(`${this.DB_API_SERVER}/secondaryUserMaster/delete`,data);
  }

}
