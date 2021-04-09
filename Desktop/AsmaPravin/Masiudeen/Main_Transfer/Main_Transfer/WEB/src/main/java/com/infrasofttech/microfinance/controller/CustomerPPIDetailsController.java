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

import com.infrasofttech.microfinance.entityBeans.master.CustomerCompositePrimaryEntity;
import com.infrasofttech.microfinance.entityBeans.master.CustomerFamilyDetailsEntity;
import com.infrasofttech.microfinance.entityBeans.master.CustomerPPIDetailsEntity;
import com.infrasofttech.microfinance.servicesimpl.CustomerPPIDetailsServiceImpl;


@RestController
@RequestMapping("/customerPPIDetails")
public class CustomerPPIDetailsController {
	
	@Autowired
	CustomerPPIDetailsServiceImpl customerService;
	
	
	@GetMapping(value = "/getlistOfCustomersPPI", produces = "application/json")
	public ResponseEntity<?> getAll(){
		return customerService.getAllCustomerPPIData();
	}
	
	
	@PostMapping(value = "/add", produces = "application/json")
	public ResponseEntity<?>  addlist(@RequestBody List<CustomerPPIDetailsEntity> customer){
		if(null != customer)
			return customerService.addPPIList(customer);
		return null;
	}
	
	 
	 @PostMapping("/addPPIDetails/{mCustRefno}")
	 public ResponseEntity<?> addMultiLinePPIDetails(@PathVariable (value = "mCustRefno") int mCustRefno ,
	                                 @Valid @RequestBody List<CustomerPPIDetailsEntity> entity) {		 
/*		 CustomerCompositePrimaryEntity compositeCustomerEntity = new CustomerCompositePrimaryEntity();
		 compositeCustomerEntity.setCustomerNumberOfTab(customerIdOfTab);
		 compositeCustomerEntity.setUsrCode(customerUsrCode);*/
		 return customerService.addPPIDetails(entity, mCustRefno)	;			
	        
	    }
	 
	 
	 
}
