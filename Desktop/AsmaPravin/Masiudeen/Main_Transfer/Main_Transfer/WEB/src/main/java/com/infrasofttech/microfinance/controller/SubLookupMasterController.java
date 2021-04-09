package com.infrasofttech.microfinance.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.infrasofttech.microfinance.entityBeans.master.CustomerEntity;
import com.infrasofttech.microfinance.entityBeans.master.SubLookupMasterEntity;
import com.infrasofttech.microfinance.services.SubLookupMasterServices;

@RestController
@RequestMapping("/SubLookupData")
public class SubLookupMasterController {

	@Autowired
	SubLookupMasterServices subLookup;
	

/*	@GetMapping(value = "/get/{countryName}", produces = "application/json")
	public ResponseEntity<?> getCountries(@PathVariable String countryName){	
		return countries.getCountries(countryName);
	}*/
	
	@GetMapping(value = "/getAllSubLookup/", produces = "application/json")
	public ResponseEntity<?>  getAllLookupData() {
		return subLookup.getAllLookupData();
	}
}
