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
import com.infrasofttech.microfinance.servicesimpl.CustomerBusinessExpenseServiceImpl;


@RestController
@RequestMapping("/customerBnExpenseDetails")
public class CustomerBusinessExpenseController {
	
	@Autowired
	CustomerBusinessExpenseServiceImpl customerService;
	
	
	@GetMapping(value = "/getlistOfCustomersBnExpense", produces = "application/json")
	public ResponseEntity<?> getAll(){
		return customerService.getAllCustomerBnExpenseData();
	}
	
	
	@PostMapping(value = "/add", produces = "application/json")
	public ResponseEntity<?>  addlist(@RequestBody List<CustomerBusinessExpenseEntity> customer){
		if(null != customer)
			return customerService.addBnExpenseList(customer);
		return null;
	}
	


	 
	 @PostMapping("/addBnExpenseDetails/{mCustRefno}")
	 public ResponseEntity<?> addMultiLineBnExpenseDetails(@PathVariable (value = "mCustRefno") int mCustRefno ,
	                                 @Valid @RequestBody List<CustomerBusinessExpenseEntity> entity) {
		 return customerService.addBnExpenseDetails(entity, mCustRefno)	;			
	        
	    }
	 

	 
	 
}
