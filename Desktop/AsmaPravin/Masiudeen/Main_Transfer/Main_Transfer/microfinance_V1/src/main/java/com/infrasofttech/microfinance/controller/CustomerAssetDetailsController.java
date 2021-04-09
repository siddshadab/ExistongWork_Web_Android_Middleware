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

import com.infrasofttech.microfinance.entityBeans.master.CustomerAssetDetailsEntity;
import com.infrasofttech.microfinance.entityBeans.master.CustomerBusinessExpenseEntity;
import com.infrasofttech.microfinance.servicesimpl.CustomerAssetDetailsServiceImpl;
import com.infrasofttech.microfinance.servicesimpl.CustomerBusinessExpenseServiceImpl;


@RestController
@RequestMapping("/customerAssetDetails")
public class CustomerAssetDetailsController {
	
	@Autowired
	CustomerAssetDetailsServiceImpl customerService;
	
	
	@GetMapping(value = "/getlistOfCustomersAsset", produces = "application/json")
	public ResponseEntity<?> getAll(){
		return customerService.getAllCustomerAssetData();
	}
	
	
	@PostMapping(value = "/add", produces = "application/json")
	public ResponseEntity<?>  addlist(@RequestBody List<CustomerAssetDetailsEntity> customer){
		if(null != customer)
			return customerService.addAssetList(customer);
		return null;
	}
	


	 
	 @PostMapping("/addAssetDetails/{mCustRefno}")
	 public ResponseEntity<?> addMultiLineAssetDetails(@PathVariable (value = "mCustRefno") int mCustRefno ,
	                                 @Valid @RequestBody List<CustomerAssetDetailsEntity> entity) {
		 return customerService.addAssetDetails(entity, mCustRefno)	;			
	        
	    }
	 

	 
	 
}
