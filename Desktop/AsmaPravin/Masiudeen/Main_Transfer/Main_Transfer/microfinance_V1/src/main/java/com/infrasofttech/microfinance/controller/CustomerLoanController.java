package com.infrasofttech.microfinance.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.infrasofttech.microfinance.entityBeans.master.CustomerLoanEntity;
import com.infrasofttech.microfinance.entityBeans.master.holder.CIFHolderBean;
import com.infrasofttech.microfinance.entityBeans.master.holder.GrtAdditionalDetailsHolder;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.servicesImpl.GrtAdditionalDetailsServiceImpl;
import com.infrasofttech.microfinance.servicesimpl.CustomerLoanServiceImpl;

@RestController
@RequestMapping("/customerLoanData")
public class CustomerLoanController {
	
	@Autowired
	CustomerLoanServiceImpl customerLoanService;
	
	@Autowired
	GrtAdditionalDetailsServiceImpl grtAdditionalServiceImpl;
	
	
	@GetMapping(value = "/getlistOfCustomersLoan", produces = "application/json")
	public ResponseEntity<?> getAll(){
		return customerLoanService.getAllCustomerLoanData();
	}
	
	
	@PostMapping(value = "/add", produces = "application/json")
	public ResponseEntity<?>  addlist(@RequestBody List<CustomerLoanEntity> customerLoan){
		ResponseEntity<List<CustomerLoanEntity>> responseEntity = null;
		if(null != customerLoan) {
			System.out.println("inside add");
		
			 responseEntity = (ResponseEntity<List<CustomerLoanEntity>>)customerLoanService.addList(customerLoan);
			
		
			 
			 
			 if(customerLoan.size()==1) {
				
				System.out.println("Inside Single Loan Sync");
				List<CustomerLoanEntity> addEntity;
		for(CustomerLoanEntity loanEntity:responseEntity.getBody()) {
			
			
			if(loanEntity.getMissynctocoresys()==9&&loanEntity.getMcustmrefno()>0) {
				addEntity = new ArrayList<CustomerLoanEntity>();
				
				customerLoanService.synchronizeLoanToOmni(loanEntity);
				
				
				addEntity.add(loanEntity);
				
				
				responseEntity = new ResponseEntity<List<CustomerLoanEntity>>(addEntity,new HttpHeaders(),HttpStatus.CREATED);
				
			}
			
		
			
			
			
			
			
		}
		
		
			System.out.println("returning entity is "+responseEntity);
			return responseEntity;
			}
			else {
				System.out.println("returning entity is "+responseEntity);
				return responseEntity;
			}
			
					
					//customerLoanService.addList(customer);
			
		}
		System.out.println("returning nulllllllll ");
			
		return null;
	}
	
	
	@PostMapping(value = "/getCustomerbyAgentUserName/", produces = "application/json")	
	public ResponseEntity<?>  getCustomerbyCreatedByOrRouteTo(@RequestBody CustomerLoanEntity customerLoanEntity){
		if(null != customerLoanEntity.getMcreatedby())
			return customerLoanService.findByCreatedByOrRouteTo(customerLoanEntity.getMcreatedby(),customerLoanEntity.getMrouteto());
		return null;
	}
	
	
	@PostMapping(value =  "/getCustomerLoansbyCreatedByORrouteAndLastSyncedTiming/", produces = "application/json")
	public ResponseEntity<?>  getCustomerbyAgentUserName(@RequestBody CustomerLoanEntity customerLoanEntity){
		if(null != customerLoanEntity.getMcreatedby()) {
			System.out.println(customerLoanEntity.getMlastsynsdate()!=null?customerLoanEntity.getMlastsynsdate():"printng chu ");
			return customerLoanService.findByCreatedByOrMrouteToAndLastSyncedTime(customerLoanEntity);
		}
		return null;
	}
	
	
	
	@PostMapping(value =  "/getGrtAdditionalDetails/", produces = "application/json")
	public ResponseEntity<?>  getCustomerbyAgentUserName(@RequestBody GrtAdditionalDetailsHolder additionalDetailsHolder){
		System.out.println(additionalDetailsHolder.getMleadsid());

		try {
			if(additionalDetailsHolder.getMleadsid()!=null && !"".equals(additionalDetailsHolder.getMleadsid())) {
				System.out.println("either custno or nid value is present");
				GrtAdditionalDetailsHolder  bean = grtAdditionalServiceImpl.getGrtAdditionalDetails(additionalDetailsHolder);
				return new ResponseEntity<GrtAdditionalDetailsHolder>(bean,new HttpHeaders(),HttpStatus.OK);}
		}

		catch(Exception e) {
			return new  ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY);
		}

		return null;
	}
	
	
	
	
	

}
