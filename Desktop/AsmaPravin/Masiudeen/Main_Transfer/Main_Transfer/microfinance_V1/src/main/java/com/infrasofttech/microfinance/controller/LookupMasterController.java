package com.infrasofttech.microfinance.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.infrasofttech.microfinance.servicesimpl.LookupMasterServicesImpl;

@CrossOrigin(origins = "*", allowedHeaders = "*")
@RestController
@RequestMapping("/lookupMasterController")
public class LookupMasterController {
	
	
	
	@Autowired 
	LookupMasterServicesImpl lookupMasterServicesImpl;



/*	@GetMapping(value = "/get/{countryName}", produces = "application/json")
	public ResponseEntity<?> getCountries(@PathVariable String countryName){	
		return countries.getCountries(countryName);
	}*/
	
	@GetMapping(value = "/getAllLookup/", produces = "application/json")
	public ResponseEntity<?>  getAllLookupData() {
		return lookupMasterServicesImpl.getAllLookupData();
	}
/*	@GetMapping(value = "/getAllSubLookup/", produces = "application/json")
	public ResponseEntity<?>  getAllSubLookupData() {
		return lookupMasterServicesImpl.getAllSubLookupData();
	}*/

}
