import { Component, OnInit } from '@angular/core';
import { ApiService } from '../../services/api.service';

@Component({
  selector: 'app-home',
  templateUrl: './home.component.html',
  styleUrls: ['./home.component.scss']
})
export class HomeComponent implements OnInit {

  employeeArray:any = [];

  constructor(private apiService:ApiService) { }

  ngOnInit() {
    this.apiService.getJsonData().subscribe(res =>
    {
      console.log(res);
      this.employeeArray = res;
      console.log(this.employeeArray);
      //console.log(this.employeeArray.employee_salary);
      // this.userloginarray = res;
    });

  }

}
