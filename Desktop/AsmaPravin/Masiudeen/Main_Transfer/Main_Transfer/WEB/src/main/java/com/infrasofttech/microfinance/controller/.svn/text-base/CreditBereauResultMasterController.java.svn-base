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
import com.infrasofttech.microfinance.entityBeans.master.CreditBereauResultMasterEntity;
import com.infrasofttech.microfinance.entityBeans.master.CustomerLoanEntity;
import com.infrasofttech.microfinance.entityBeans.master.ProspectCompositePrimaryEntity;
import com.infrasofttech.microfinance.servicesimpl.CreditBereauResultMasterServiceImpl;
import com.infrasofttech.microfinance.servicesimpl.CustomerLoanServiceImpl;

@RestController
@RequestMapping("/creditBereauResultData")
public class CreditBereauResultMasterController {
	
	@Autowired
	CreditBereauResultMasterServiceImpl CreditBereauResultMasterService;
	
	
	@GetMapping(value = "/getlistOfCreditBereauResultMaster", produces = "application/json")
	public ResponseEntity<?> getAll(){
		return CreditBereauResultMasterService.getAllCreditBereauResultData();
	}
	
	
	@PostMapping(value = "/add", produces = "application/json")
	public ResponseEntity<?>  addlist(@RequestBody List<CreditBereauResultMasterEntity> prospect){
		if(null != prospect) {
			System.out.println("inside add");
			return CreditBereauResultMasterService.addList(prospect);
			
		}
			
		return null;
	}

	
	@PostMapping(value = "/findByRoutedTo", produces = "application/json")
	public ResponseEntity<?>  getAssignedProspect(String userName){			
		    ResponseEntity<?> entity =  CreditBereauResultMasterService.getByRoutedTo(userName);
			/*if(entity == null) {
				entity = new ArrayList<CustomerEntity>();
			}
			*/
			return entity;
	}
	
	
	
	@PostMapping("/addCreditBereauResult/{adhaarNo}/{agentUserName}")
    public ResponseEntity<?> createComment(@PathVariable (value = "adhaarNo") long adhaarNo ,@PathVariable (value = "agentUserName") String agentUserName ,
                                 @Valid @RequestBody CreditBereauResultMasterEntity entity) {		
		
		System.out.println(adhaarNo);
		System.out.println(agentUserName);
	 ProspectCompositePrimaryEntity compositeProspectEntity = new ProspectCompositePrimaryEntity();
	 
	 compositeProspectEntity.setAdhaarNo(adhaarNo);
	 compositeProspectEntity.setAgentUserName(agentUserName);
	 return CreditBereauResultMasterService.addResultDetails(entity,compositeProspectEntity);			
        
    }



}
