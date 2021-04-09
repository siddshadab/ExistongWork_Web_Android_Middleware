
import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';

import { TranslateModule, TranslateLoader } from '@ngx-translate/core';
import { TranslateHttpLoader } from '@ngx-translate/http-loader';

import { RouterModule,Routes} from '@angular/router';

import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import { LoginComponent } from './components/login/login.component';
import { HttpClientModule, HttpClient, HttpHeaders} from '@angular/common/http';
import { ReactiveFormsModule, FormsModule } from '@angular/forms';
import { DashboardComponent } from './components/dashboard/dashboard.component';

import { BnNgIdleService } from 'bn-ng-idle';
import { HomeComponent } from './components/home/home.component';
import { UserMasterComponent } from './components/user-master/user-master.component';
import { HeaderComponent } from './components/header/header.component';
import { NavBarComponent } from './components/nav-bar/nav-bar.component';
import { ChangePasswordComponent } from './components/change-password/change-password.component';
import { LookupCodeTypesComponent } from './components/lookup-code-types/lookup-code-types.component'; // import bn-ng-idle service
import { BranchMasterComponent } from './components/branch-master/branch-master.component';
import { AuthorizationCheckService } from './services/authorization-check.service';
import { CustomPipe } from './custom-pipe';
import { MainComponent } from './components/main/main.component';
import { UserMasterViewComponent } from './components/user-master-view/user-master-view.component';
import { UserMasterIndViewComponent } from './components/user-master-ind-view/user-master-ind-view.component';
import { BsDatepickerModule } from 'ngx-bootstrap/datepicker';
import { BrowserAnimationsModule } from '@angular/platform-browser/animations';
import { UserAccessRightsComponent } from './components/user-access-rights/user-access-rights.component';
import { UserAccessRightsViewComponent } from './components/user-access-rights-view/user-access-rights-view.component';
import { UserAccessRightsIndViewComponent } from './components/user-access-rights-ind-view/user-access-rights-ind-view.component';
import { ProductMasterComponent } from './components/product-master/product-master.component';
import { ProductMasterViewComponent } from './components/product-master-view/product-master-view.component';
import { ProductMasterIndViewComponent } from './components/product-master-ind-view/product-master-ind-view.component';
import { LoanLevelMasterComponent } from './components/loan-level-master/loan-level-master.component';
import { LoanLevelViewComponent } from './components/loan-level-view/loan-level-view.component';
import { LoanLevelIndViewComponent } from './components/loan-level-ind-view/loan-level-ind-view.component';
import { BranchMasterViewComponent } from './components/branch-master-view/branch-master-view.component';
import { BranchMasterIndViewComponent } from './components/branch-master-ind-view/branch-master-ind-view.component';
import { LoanApprovalLimitComponent } from './components/loan-approval-limit/loan-approval-limit.component';
import { LoanApprovalLimitViewComponent } from './components/loan-approval-limit-view/loan-approval-limit-view.component';
import { LoanApprovalLimitIndViewComponent } from './components/loan-approval-limit-ind-view/loan-approval-limit-ind-view.component';
import { LoanCycleParameterPrimaryViewComponent } from './components/loan-cycle-parameter-primary-view/loan-cycle-parameter-primary-view.component';
import { LoanCycleParameterPrimaryComponent } from './components/loan-cycle-parameter-primary/loan-cycle-parameter-primary.component';
import { LoanCycleParameterPrimaryIndViewComponent } from './components/loan-cycle-parameter-primary-ind-view/loan-cycle-parameter-primary-ind-view.component';
import { LookupMasterComponent } from './components/lookup-master/lookup-master.component';
import { LookupMasterViewComponent } from './components/lookup-master-view/lookup-master-view.component';
import { LookupMasterIndViewComponent } from './components/lookup-master-ind-view/lookup-master-ind-view.component';
import { SystemParameterComponent } from './components/system-parameter/system-parameter.component';
import { SystemParameterViewComponent } from './components/system-parameter-view/system-parameter-view.component';
import { SystemParameterIndViewComponent } from './components/system-parameter-ind-view/system-parameter-ind-view.component';
import { CountryMasterComponent } from './components/country-master/country-master.component';
import { CountryMasterViewComponent } from './components/country-master-view/country-master-view.component';
import { CountryMasterIndViewComponent } from './components/country-master-ind-view/country-master-ind-view.component';
import { StateMasterComponent } from './components/state-master/state-master.component';
import { StateMasterViewComponent } from './components/state-master-view/state-master-view.component';
import { StateMasterIndViewComponent } from './components/state-master-ind-view/state-master-ind-view.component';
import { DistrictMasterComponent } from './components/district-master/district-master.component';
import { DistrictMasterViewComponent } from './components/district-master-view/district-master-view.component';
import { DistrictMasterIndViewComponent } from './components/district-master-ind-view/district-master-ind-view.component';
import { SubDistrictMasterComponent } from './components/sub-district-master/sub-district-master.component';
import { SubDistrictMasterIndViewComponent } from './components/sub-district-master-ind-view/sub-district-master-ind-view.component';
import { SubDistrictMasterViewComponent } from './components/sub-district-master-view/sub-district-master-view.component';
import { SecondaryUserMasterIndViewComponent } from './secondary-user-master-ind-view/secondary-user-master-ind-view.component';
import { SecondaryUserMasterComponent } from './secondary-user-master/secondary-user-master.component';
import { SecondaryUserMasterViewComponent } from './secondary-user-master-view/secondary-user-master-view.component';
export function HttpLoaderFactory(http: HttpClient){
  return new TranslateHttpLoader(http);
}

const appRoutes:Routes=[
  {path:'',component:LoginComponent},
  {path:'login',component:LoginComponent},
  {path:'',component:MainComponent,
  children: [
    {path:'dashboard',component:DashboardComponent, canActivate: [AuthorizationCheckService]},
    {path:'home',component:HomeComponent, canActivate: [AuthorizationCheckService]},
    {path:'user-master',component:UserMasterComponent, canActivate: [AuthorizationCheckService]},
    {path:'user-master-view',component:UserMasterViewComponent, canActivate: [AuthorizationCheckService]},
    {path:'user-master-ind-view',component:UserMasterIndViewComponent, canActivate: [AuthorizationCheckService]},
    {path:'change-password',component:ChangePasswordComponent, canActivate: [AuthorizationCheckService]},
    {path:'lookup-code-type',component:LookupCodeTypesComponent},
    {path:'branch-master',component:BranchMasterComponent, canActivate: [AuthorizationCheckService]},
    {path:'branch-master-view',component:BranchMasterViewComponent, canActivate: [AuthorizationCheckService]},
    {path:'branch-master-ind-view',component:BranchMasterIndViewComponent, canActivate: [AuthorizationCheckService]},
    {path:'user-access-rights',component:UserAccessRightsComponent, canActivate: [AuthorizationCheckService]},
    {path:'user-access-rights-ind-view',component:UserAccessRightsIndViewComponent, canActivate: [AuthorizationCheckService]},
    {path:'user-access-rights-view',component:UserAccessRightsViewComponent, canActivate: [AuthorizationCheckService]},
    {path:'product-master',component:ProductMasterComponent, canActivate: [AuthorizationCheckService]},
    {path:'product-master-view',component:ProductMasterViewComponent, canActivate: [AuthorizationCheckService]},
    {path:'product-master-ind-view',component:ProductMasterIndViewComponent, canActivate: [AuthorizationCheckService]},
    {path:'loan-approval-limit',component:LoanApprovalLimitComponent, canActivate: [AuthorizationCheckService]},
    {path:'loan-approval-limit-view',component:LoanApprovalLimitViewComponent, canActivate: [AuthorizationCheckService]},
    {path:'loan-approval-limit-ind-view',component:LoanApprovalLimitIndViewComponent, canActivate: [AuthorizationCheckService]},
    {path:'loan-cycle-parameter-primary',component:LoanCycleParameterPrimaryComponent, canActivate: [AuthorizationCheckService]},
    {path:'loan-cycle-parameter-primary-view',component:LoanCycleParameterPrimaryViewComponent, canActivate: [AuthorizationCheckService]},
    {path:'loan-cycle-parameter-primary-ind-view',component:LoanCycleParameterPrimaryIndViewComponent, canActivate: [AuthorizationCheckService]},
    {path:'lookup-master',component:LookupMasterComponent, canActivate: [AuthorizationCheckService]},
    {path:'lookup-master-view',component:LookupMasterViewComponent, canActivate: [AuthorizationCheckService]},
    {path:'lookup-master-ind-view',component:LookupMasterIndViewComponent, canActivate: [AuthorizationCheckService]},
    {path:'loan-level-master',component:LoanLevelMasterComponent, canActivate: [AuthorizationCheckService]},
    {path:'loan-level-view',component:LoanLevelViewComponent, canActivate: [AuthorizationCheckService]},
    {path:'loan-level-ind-view',component:LoanLevelIndViewComponent, canActivate: [AuthorizationCheckService]},
    {path:'system-parameter',component:SystemParameterComponent, canActivate: [AuthorizationCheckService]},
    {path:'system-parameter-view',component:SystemParameterViewComponent, canActivate: [AuthorizationCheckService]},
    {path:'system-parameter-ind-view',component:SystemParameterIndViewComponent, canActivate: [AuthorizationCheckService]},
    {path:'country-master',component:CountryMasterComponent, canActivate: [AuthorizationCheckService]},
    {path:'country-master-view',component:CountryMasterViewComponent, canActivate: [AuthorizationCheckService]},
    {path:'country-master-ind-view',component:CountryMasterIndViewComponent, canActivate: [AuthorizationCheckService]},
    {path:'state-master-view',component:StateMasterViewComponent, canActivate: [AuthorizationCheckService]},
    {path:'state-master',component:StateMasterComponent, canActivate: [AuthorizationCheckService]},
    {path:'state-master-ind-view',component:StateMasterIndViewComponent, canActivate: [AuthorizationCheckService]},
    {path:'district-master-view',component:DistrictMasterViewComponent, canActivate: [AuthorizationCheckService]},
    {path:'district-master',component:DistrictMasterComponent, canActivate: [AuthorizationCheckService]},
    {path:'district-master-ind-view',component:DistrictMasterIndViewComponent, canActivate: [AuthorizationCheckService]},
    {path:'sub-district-master-view',component:SubDistrictMasterViewComponent, canActivate: [AuthorizationCheckService]},
    {path:'sub-district-master',component:SubDistrictMasterComponent, canActivate: [AuthorizationCheckService]},
    {path:'sub-district-master-ind-view',component:SubDistrictMasterIndViewComponent, canActivate: [AuthorizationCheckService]},
    {path:'secondary-user-master-view',component:SecondaryUserMasterViewComponent,canActivate: [AuthorizationCheckService]},
    {path:'secondary-user-master-ind-view',component:SecondaryUserMasterIndViewComponent,canActivate: [AuthorizationCheckService]},
    {path:'secondary-user-master',component:SecondaryUserMasterComponent,canActivate: [AuthorizationCheckService]}
  ]}
];
@NgModule({
  declarations: [
    AppComponent,
    LoginComponent,
    DashboardComponent,
    HomeComponent,
    LookupMasterComponent,
    UserMasterComponent,
    HeaderComponent,
    NavBarComponent,
    ChangePasswordComponent,
    LookupCodeTypesComponent,
    BranchMasterComponent,
    CustomPipe,
    MainComponent,
    UserMasterViewComponent,
    UserMasterIndViewComponent,
    UserAccessRightsComponent,
    UserAccessRightsViewComponent,
    UserAccessRightsIndViewComponent,
    ProductMasterComponent,
    ProductMasterViewComponent,
    ProductMasterIndViewComponent,
    LoanLevelMasterComponent,
    LoanLevelViewComponent,
    LoanLevelIndViewComponent,
    BranchMasterViewComponent,
    BranchMasterIndViewComponent,
    LoanApprovalLimitComponent,
    LoanApprovalLimitViewComponent,
    LoanApprovalLimitIndViewComponent,
    LoanCycleParameterPrimaryViewComponent,
    LoanCycleParameterPrimaryComponent,
    LoanCycleParameterPrimaryIndViewComponent,
    LookupMasterViewComponent,
    LookupMasterIndViewComponent,
    SystemParameterComponent,
    SystemParameterViewComponent,
    SystemParameterIndViewComponent,
    CountryMasterComponent,
    CountryMasterViewComponent,
    CountryMasterIndViewComponent,
    StateMasterComponent,
    StateMasterViewComponent,
    StateMasterIndViewComponent,
    DistrictMasterComponent,
    DistrictMasterViewComponent,
    DistrictMasterIndViewComponent,
    SubDistrictMasterComponent,
    SubDistrictMasterIndViewComponent,
    SubDistrictMasterViewComponent,
    SecondaryUserMasterComponent,
    SecondaryUserMasterIndViewComponent,
    SecondaryUserMasterViewComponent
  ],
  imports: [
    BrowserModule,FormsModule,RouterModule.forRoot(appRoutes),HttpClientModule,ReactiveFormsModule,
    AppRoutingModule,BsDatepickerModule.forRoot(),BrowserAnimationsModule,
    TranslateModule.forRoot({
      loader: {
        provide: TranslateLoader,
        useFactory: HttpLoaderFactory,
        deps: [HttpClient]
      }
    })
  ],
  providers: [BnNgIdleService, AppComponent, CustomPipe],
  bootstrap: [AppComponent]
})
export class AppModule { }
