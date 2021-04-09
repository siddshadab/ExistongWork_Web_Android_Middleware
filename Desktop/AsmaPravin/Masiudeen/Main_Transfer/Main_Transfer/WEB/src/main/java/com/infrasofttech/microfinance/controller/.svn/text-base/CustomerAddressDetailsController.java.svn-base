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

import com.infrasofttech.microfinance.entityBeans.master.CustomerAddressDetailsEntity;
import com.infrasofttech.microfinance.entityBeans.master.CustomerBorrowingDetailsEntity;
import com.infrasofttech.microfinance.entityBeans.master.CustomerCompositePrimaryEntity;
import com.infrasofttech.microfinance.servicesimpl.CustomerAddressDetailsServicesImpl;
import com.infrasofttech.microfinance.servicesimpl.CustomerBorrowingDetailsServiceImpl;

	


@RestController
@RequestMapping("/CustomerAddressDetails")
public class CustomerAddressDetailsController {
	
	@Autowired
	CustomerAddressDetailsServicesImpl customerService;
	
	
	@GetMapping(value = "/getlistOfCustomerAddress", produces = "application/json")
	public ResponseEntity<?> getAll(){
		return customerService.getAllCustomerAddressDetailsData();
	}
	
	
	@PostMapping(value = "/add", produces = "application/json")
	public ResponseEntity<?>  addlist(@RequestBody CustomerAddressDetailsEntity customer){
		if(null != customer)
			return customerService.addList(customer);
		return null;
	}
	

	
	 @PostMapping("/addAddressDetails/{mCustRefno}")
	    public ResponseEntity<?> addMultiLineAddressDetails(@PathVariable (value = "mCustRefno") int mCustRefno ,
	                                 @Valid @RequestBody List<CustomerAddressDetailsEntity> entity) {		 
		 /*CustomerCompositePrimaryEntity compositeCustomerEntity = new CustomerCompositePrimaryEntity();
		 compositeCustomerEntity.setCustomerNumberOfTab(customerIdOfTab);
		 compositeCustomerEntity.setUsrCode(customerUsrCode);*/
		 return customerService.addCustomerAddressDetails(entity, mCustRefno)	;				
	        
	    }

	
}
