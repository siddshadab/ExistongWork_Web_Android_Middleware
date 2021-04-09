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
import com.infrasofttech.microfinance.entityBeans.master.CustomerLoanEntity;
import com.infrasofttech.microfinance.entityBeans.master.DailyLoanCollectedEntity;
import com.infrasofttech.microfinance.entityBeans.master.DailyLoanCollectionEntity;
import com.infrasofttech.microfinance.repository.LookupMasterRepository;
import com.infrasofttech.microfinance.servicesimpl.CountriesServiceImpl;
import com.infrasofttech.microfinance.servicesimpl.DailyLoanCollectedImpl;
import com.infrasofttech.microfinance.servicesimpl.DailyLoanCollectionImpl;
import com.infrasofttech.microfinance.servicesimpl.LookupMasterServicesImpl;
import com.infrasofttech.microfinance.servicesimpl.SystemParameterServicesImpl;


@RestController
@RequestMapping("/DailyLoanCollectedController")
public class DailyLoanCollectedController {
	
	
	
	@Autowired 
	DailyLoanCollectedImpl dailyLoanCollectedImplServices;




	@PostMapping(value = "/add", produces = "application/json")
	public ResponseEntity<?>  addlist(@RequestBody List<DailyLoanCollectedEntity> dailyLoanCollected){
		if(null != dailyLoanCollected) {
			System.out.println("inside add");
			return dailyLoanCollectedImplServices.addList(dailyLoanCollected);
			
		}
			
		return null;
	}

	//TODO Change this to missync to core sys method
	
	
	
}
