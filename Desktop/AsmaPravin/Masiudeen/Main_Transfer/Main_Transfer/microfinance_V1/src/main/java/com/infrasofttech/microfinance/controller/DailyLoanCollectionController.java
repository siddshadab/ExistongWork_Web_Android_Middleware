package com.infrasofttech.microfinance.controller;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.infrasofttech.microfinance.entityBeans.CountriesEntity;
import com.infrasofttech.microfinance.entityBeans.master.CustomerEntity;
import com.infrasofttech.microfinance.entityBeans.master.DailyLoanCollectionEntity;
import com.infrasofttech.microfinance.repository.LookupMasterRepository;
import com.infrasofttech.microfinance.servicesimpl.CountriesServiceImpl;
import com.infrasofttech.microfinance.servicesimpl.DailyLoanCollectionImpl;
import com.infrasofttech.microfinance.servicesimpl.LookupMasterServicesImpl;
import com.infrasofttech.microfinance.servicesimpl.SystemParameterServicesImpl;


@RestController
@RequestMapping("/DailyLoanCollectionController")
public class DailyLoanCollectionController {
	
	
	
	@Autowired 
	DailyLoanCollectionImpl dailyLoanCollectionImplServices;




	@GetMapping(value = "/getAllLoanCollectionData/", produces = "application/json")
	public ResponseEntity<?>  getAllLoanCollectionData() {
		return dailyLoanCollectionImplServices.getAllLoanCollectionData();
	}


	
	@PostMapping(value = "/getDailyLoanbyCreatedByAndLbr/", produces = "application/json")
	public ResponseEntity<?>  getDailyLoanbyCreatedByAndLbr(@RequestBody DailyLoanCollectionEntity dailyLoanCollectionEntity){
		if(null != dailyLoanCollectionEntity.getMcreatedby()) {
			//System.out.println(customerEntity.getMlastsynsdate()!=null?customerEntity.getMlastsynsdate():"printng chu ");
			return dailyLoanCollectionImplServices.findByCreatedByAndLbr(dailyLoanCollectionEntity);
		}
		return null;
	}
	
	
}
