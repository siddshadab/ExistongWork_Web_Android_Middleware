package com.infrasofttech.microfinance.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.infrasofttech.microfinance.entityBeans.master.LoanCycleParameterSecondaryEntity;
import com.infrasofttech.microfinance.entityBeans.master.holder.LoanCycleParameterSecondaryHolder;
import com.infrasofttech.microfinance.services.LoanCycleParameterSecondaryServices;
import com.infrasofttech.microfinance.servicesimpl.LoanCycleParameterSecondaryServicesImpl;

@CrossOrigin(origins = "*", allowedHeaders = "*")
@RestController
@RequestMapping("/LoanCycleParameterSecondaryController")
public class LoanCycleParameterSecondaryController {
	
	
	
	@Autowired 
	LoanCycleParameterSecondaryServicesImpl loanCycleParameterSecondaryServicesImpl;

	@Autowired
	LoanCycleParameterSecondaryServices loanService;

/*	@GetMapping(value = "/get/{countryName}", produces = "application/json")
	public ResponseEntity<?> getCountries(@PathVariable String countryName){	
		return countries.getCountries(countryName);
	}*/
	
	@GetMapping(value = "/getAllLoanCycleParameterSecondary", produces = "application/json")
	public ResponseEntity<?>  getAllInsertOffsetData() {
		return loanCycleParameterSecondaryServicesImpl.getAllLoanCycleParameterSecondaryData();
	}
	
	  @PostMapping(value = "/getLoanCycleParameterSecondaryByMlbrCode", produces ="application/json")	 
			public ResponseEntity<?>  getDataByMlbrCode(@RequestBody LoanCycleParameterSecondaryEntity loanCycleParams){
				if(null != loanCycleParams) {
					return loanCycleParameterSecondaryServicesImpl.getDataByMlbrCode(loanCycleParams.getLoanCycleParameterSecondaryCompositeEntity().getmlbrcode());
				}
				return null;
			}
	  
	  @PostMapping(value ="/add",produces="application/json")
	  public ResponseEntity<?> addData(@RequestBody LoanCycleParameterSecondaryHolder loanCycleSecondary){
		  System.out.println("xxxxxxxxxxxxxxxxxxxxxx"+loanCycleSecondary);
		  if(null !=loanCycleSecondary) {
			  return loanService.addData(loanCycleSecondary);
		  }
		return null;
	  }
	  
	  @PostMapping(value ="/edit",produces="application/json")
	  public ResponseEntity<?> editData(@RequestBody LoanCycleParameterSecondaryHolder loanCycleSecondary){
		  System.out.println("xxxxxxxxxxxxxxxxxxxxxx"+loanCycleSecondary);
		  if(null !=loanCycleSecondary) {
			  return loanService.editData(loanCycleSecondary);
		 }
		return null;
	  }
	  
	  @PostMapping(value ="/editNewRecord",produces="application/json")
	  public ResponseEntity<?> editNewRecord(@RequestBody LoanCycleParameterSecondaryHolder loanCycleSecondary){
		  System.out.println("xxxxxxxxxxxxxxxxxxxxxx"+loanCycleSecondary);
		  if(null !=loanCycleSecondary) {
			  return loanService.editData(loanCycleSecondary);
		 }
		return null;
	  }
	  
	  @PostMapping(value ="/delete",produces="application/json")
	  public ResponseEntity<?> deleteData(@RequestBody LoanCycleParameterSecondaryHolder loanCycleSecondary){
		  System.out.println("xxxxxxxxxxxxxxxxxxxxxx"+loanCycleSecondary);
		  if(null !=loanCycleSecondary) {
			  return loanService.deleteData(loanCycleSecondary);
		  }
		return null;
	  }
	  
	  @PostMapping(value ="/findByPrmKey",produces="application/json")
	  public ResponseEntity<?> FindByPrmKey(@RequestBody LoanCycleParameterSecondaryHolder loanCycleSecondary){
		  System.out.println("xxxxxxxxxxxxxxxxxxxxxx"+loanCycleSecondary);
		  if(null !=loanCycleSecondary) {
			  return loanService.findByPrmKey(loanCycleSecondary);
		  }
		return null;
	  }
	  
	  @PostMapping(value="/getLoanCycle",produces="application/json")
	  public ResponseEntity<?> getLoanCycle(@RequestBody LoanCycleParameterSecondaryHolder loanCycleSecondary){
		  if(loanCycleSecondary !=null) {
			  return loanService.getLoanCycleSecondary(loanCycleSecondary);
		  }
		  return null;
	  }
}
