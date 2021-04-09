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
import com.infrasofttech.microfinance.entityBeans.master.LoanCycleParameterPrimaryEntity;
import com.infrasofttech.microfinance.entityBeans.master.LoanCycleParameterSecondaryEntity;
import com.infrasofttech.microfinance.repository.LookupMasterRepository;
import com.infrasofttech.microfinance.servicesimpl.CountriesServiceImpl;
import com.infrasofttech.microfinance.servicesimpl.InterestOffsetServicesImpl;
import com.infrasofttech.microfinance.servicesimpl.InterestSlabServicesImpl;
import com.infrasofttech.microfinance.servicesimpl.LoanCycleParameterPrimaryServicesImpl;
import com.infrasofttech.microfinance.servicesimpl.LoanCycleParameterSecondaryServicesImpl;
import com.infrasofttech.microfinance.servicesimpl.LookupMasterServicesImpl;


@RestController
@RequestMapping("/LoanCycleParameterSecondaryController")
public class LoanCycleParameterSecondaryController {
	
	
	
	@Autowired 
	LoanCycleParameterSecondaryServicesImpl loanCycleParameterSecondaryServicesImpl;



/*	@GetMapping(value = "/get/{countryName}", produces = "application/json")
	public ResponseEntity<?> getCountries(@PathVariable String countryName){	
		return countries.getCountries(countryName);
	}*/
	
	@GetMapping(value = "/getAllLoanCycleParameterSecondary/", produces = "application/json")
	public ResponseEntity<?>  getAllInsertOffsetData() {
		return loanCycleParameterSecondaryServicesImpl.getAllLoanCycleParameterSecondaryData();
	}
	
	  @PostMapping(value = "/getLoanCycleParameterSecondaryByMlbrCode", produces =
			  "application/json")	 
			public ResponseEntity<?>  getDataByMlbrCode(@RequestBody LoanCycleParameterSecondaryEntity loanCycleParams){
				if(null != loanCycleParams) {
					return loanCycleParameterSecondaryServicesImpl.getDataByMlbrCode(loanCycleParams.getLoanCycleParameterSecondaryCompositeEntity().getmlbrcode());
				}
				return null;
			}

}
