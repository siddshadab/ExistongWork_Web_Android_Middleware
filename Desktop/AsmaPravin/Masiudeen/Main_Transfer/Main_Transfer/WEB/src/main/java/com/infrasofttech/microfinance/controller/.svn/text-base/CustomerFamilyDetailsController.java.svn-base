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

import com.infrasofttech.microfinance.entityBeans.master.CustomerBorrowingDetailsEntity;
import com.infrasofttech.microfinance.entityBeans.master.CustomerCompositePrimaryEntity;
import com.infrasofttech.microfinance.entityBeans.master.CustomerFamilyDetailsEntity;
import com.infrasofttech.microfinance.services.CustomerFamilyDetailsService;
import com.infrasofttech.microfinance.servicesimpl.CustomerFamilyDetailsServiceImpl;


@RestController
@RequestMapping("/customerFamilyDetails")
public class CustomerFamilyDetailsController {
	
	@Autowired
	CustomerFamilyDetailsServiceImpl customerService;
	
	
	@GetMapping(value = "/getlistOfCustomersFamily", produces = "application/json")
	public ResponseEntity<?> getAll(){
		return customerService.getAllCustomerFamilyData();
	}
	
	
	@PostMapping(value = "/add", produces = "application/json")
	public ResponseEntity<?>  addlist(@RequestBody List<CustomerFamilyDetailsEntity> customer){
		if(null != customer)
			return customerService.addFamilyList(customer);
		return null;
	}
	


	 
	 @PostMapping("/addFamilyDetails/{mCustRefno}")
	 public ResponseEntity<?> addMultiLineFamilyDetails(@PathVariable (value = "mCustRefno") int mCustRefno ,
	                                 @Valid @RequestBody List<CustomerFamilyDetailsEntity> entity) {		 
	/*	 CustomerCompositePrimaryEntity compositeCustomerEntity = new CustomerCompositePrimaryEntity();
		 compositeCustomerEntity.setCustomerNumberOfTab(customerIdOfTab);
		 compositeCustomerEntity.setUsrCode(customerUsrCode);*/
		 return customerService.addFamilyDetails(entity, mCustRefno)	;			
	        
	    }
	 

	 
	 
}
