package com.infrasofttech.microfinance.controller;

import java.util.List;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.infrasofttech.microfinance.entityBeans.master.CustomerBusinessExpenseEntity;
import com.infrasofttech.microfinance.entityBeans.master.CustomerHouseholdExpenseEntity;
import com.infrasofttech.microfinance.servicesimpl.CustomerBusinessExpenseServiceImpl;
import com.infrasofttech.microfinance.servicesimpl.CustomerHouseholdExpenseServiceImpl;


@RestController
@RequestMapping("/customerHhExpenseDetails")
public class CustomerHouseholdExpenseController {
	
	@Autowired
	CustomerHouseholdExpenseServiceImpl customerService;
	
	
	@GetMapping(value = "/getlistOfCustomersHhExpense", produces = "application/json")
	public ResponseEntity<?> getAll(){
		return customerService.getAllCustomerHhExpenseData();
	}
	
	
	@PostMapping(value = "/add", produces = "application/json")
	public ResponseEntity<?>  addlist(@RequestBody List<CustomerHouseholdExpenseEntity> customer){
		if(null != customer)
			return customerService.addHhExpenseList(customer);
		return null;
	}


	 
	 @PostMapping("/addBnExpenseDetails/{mCustRefno}")
	 public ResponseEntity<?> addMultiLineHhExpenseDetails(@PathVariable (value = "mCustRefno") int mCustRefno ,
	                                 @Valid @RequestBody List<CustomerHouseholdExpenseEntity> entity) {
		 return customerService.addHhExpenseDetails(entity, mCustRefno)	;			
	        
	    }
	 

	 
	 
}
