package com.infrasofttech.microfinance.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.infrasofttech.microfinance.entityBeans.CountriesEntity;
import com.infrasofttech.microfinance.repository.LookupMasterRepository;
import com.infrasofttech.microfinance.servicesimpl.CountriesServiceImpl;
import com.infrasofttech.microfinance.servicesimpl.InterestSlabServicesImpl;
import com.infrasofttech.microfinance.servicesimpl.LookupMasterServicesImpl;
import com.infrasofttech.microfinance.servicesimpl.TDInterestSlabServicesImpl;


@RestController
@RequestMapping("/TDInterestSlabController")
public class TDInterestSlabController {
	
	
	
	@Autowired 
	TDInterestSlabServicesImpl tdInterestSlabServicesImpl;


	@GetMapping(value = "/getAllTDInterestSlab/", produces = "application/json")
	public ResponseEntity<?>  getAllTDInterestSlabData() {
		return tdInterestSlabServicesImpl.getAllTDInterestSlabData();
	}
	

}
