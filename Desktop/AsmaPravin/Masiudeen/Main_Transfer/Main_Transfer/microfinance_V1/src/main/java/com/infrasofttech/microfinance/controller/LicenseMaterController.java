package com.infrasofttech.microfinance.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.infrasofttech.microfinance.entityBeans.master.GuarantorEntity;
import com.infrasofttech.microfinance.entityBeans.master.LicenseMasterEntity;
import com.infrasofttech.microfinance.services.GuarantorServices;
import com.infrasofttech.microfinance.services.LicenseMasterService;

@RestController
@RequestMapping("/LicenseController")
public class LicenseMaterController {

	@Autowired
	LicenseMasterService licenseMasterService;
	
	
	 @PostMapping(value = "/add", produces = "application/json") 
	  public ResponseEntity<?> addlist(@RequestBody LicenseMasterEntity licenseEntity) {
	 
	  if (null != licenseEntity) 
		  return licenseMasterService.add(licenseEntity); 
	  
	  
	 return null;
	  
	  }
	
	
	
}
