package com.infrasofttech.microfinance.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.infrasofttech.microfinance.entityBeans.master.CustomerLoanEntity;
import com.infrasofttech.microfinance.entityBeans.master.DisbursedListEntity;
import com.infrasofttech.microfinance.servicesimpl.DisbursedListServiceImpl;
import com.infrasofttech.microfinance.servicesimpl.DisbursementListServicesImpl;

@RestController
@RequestMapping("/DisbursedList")
public class DisbursedListController {

	@Autowired
	DisbursedListServiceImpl disbursedListServicesImpl;

	
	@PostMapping(value = "/add", produces = "application/json")
	public ResponseEntity<?>  addlist(@RequestBody List<DisbursedListEntity> disbursedList){
		System.out.println("dsbrs--------------------"+disbursedList.toString());
		if (null != disbursedList)
			return disbursedListServicesImpl.addList(disbursedList);
		else {
			
			return null;
		}
		
		
	}	
	
}
