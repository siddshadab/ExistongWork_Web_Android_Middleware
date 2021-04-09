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

import com.infrasofttech.microfinance.entityBeans.master.CreditBereauLoanEntity;
import com.infrasofttech.microfinance.entityBeans.master.CustomerCompositePrimaryEntity;
import com.infrasofttech.microfinance.entityBeans.master.CustomerFamilyDetailsEntity;
import com.infrasofttech.microfinance.entityBeans.master.CustomerLoanEntity;
import com.infrasofttech.microfinance.entityBeans.master.ProspectCompositePrimaryEntity;
import com.infrasofttech.microfinance.servicesimpl.CreditBereauLoanServiceImpl;
import com.infrasofttech.microfinance.servicesimpl.CustomerLoanServiceImpl;

@RestController
@RequestMapping("/creditBereauLoanData")
public class CreditBereauLoanController {
	
	@Autowired
	CreditBereauLoanServiceImpl CreditBereauLoanService;
	
	
	
	
	@GetMapping(value = "/getlistOfCustomersLoan", produces = "application/json")
	public ResponseEntity<?> getAll(){
		return CreditBereauLoanService.getAllCreditBereauLoanData();
	}
	
	
	@PostMapping(value = "/add", produces = "application/json")
	public ResponseEntity<?>  addlist(@RequestBody CreditBereauLoanEntity prospect){
		if(null != prospect) {
			System.out.println("inside add");
			return CreditBereauLoanService.addList(prospect);
			
		}
			
		return null;
	}
	
	@PostMapping("/addLoanDetails/{adhaarNo}/{agentUserName}")
    public ResponseEntity<?> createComment(@PathVariable (value = "adhaarNo") long adhaarNo ,@PathVariable (value = "agentUserName") String agentUserName ,
                                 @Valid @RequestBody List<CreditBereauLoanEntity> entity) {		 
	 ProspectCompositePrimaryEntity compositeProspectEntity = new ProspectCompositePrimaryEntity();
	 
	 compositeProspectEntity.setAdhaarNo(adhaarNo);
	 compositeProspectEntity.setAgentUserName(agentUserName);
	 return CreditBereauLoanService.addLoanDetails(entity,compositeProspectEntity);			
        
    }
	
	
	
	/*@PostMapping("/addFamilyDetails/{customerIdOfTab}/{customerUsrCode}")
    public ResponseEntity<?> createComment(@PathVariable (value = "customerIdOfTab") long customerIdOfTab ,@PathVariable (value = "customerUsrCode") String customerUsrCode ,
                                 @Valid @RequestBody List<CustomerFamilyDetailsEntity> entity) {		 
	 CustomerCompositePrimaryEntity compositeCustomerEntity = new CustomerCompositePrimaryEntity();
	 compositeCustomerEntity.setCustomerNumberOfTab(customerIdOfTab);
	 compositeCustomerEntity.setUsrCode(customerUsrCode);
	 return customerService.addFamilyDetails(entity, compositeCustomerEntity)	;			
        
    }*/
	


}
