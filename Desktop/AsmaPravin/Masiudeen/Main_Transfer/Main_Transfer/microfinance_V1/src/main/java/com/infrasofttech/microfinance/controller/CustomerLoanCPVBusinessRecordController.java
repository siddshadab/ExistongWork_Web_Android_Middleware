package com.infrasofttech.microfinance.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.infrasofttech.microfinance.entityBeans.master.CustomerLoanCPVBusinessRecordEntity;
import com.infrasofttech.microfinance.entityBeans.master.KycMasterEntity;
import com.infrasofttech.microfinance.services.CustomerLoanCPVBusinessRecordService;

@RestController
@RequestMapping("/cpvBusinessRecord")
public class CustomerLoanCPVBusinessRecordController {
	
	@Autowired 
	CustomerLoanCPVBusinessRecordService service;
	
	
	@PostMapping(value = "/add", produces = "application/json")
	public ResponseEntity<?>  addlist(@RequestBody List<CustomerLoanCPVBusinessRecordEntity> group){
		if(null != group)
			return service.addList(group);
		return null;
	}
	
	@PostMapping(value = "/getCpvByCreatedByAndLastSyncedTiming",produces = "application/json")
	public ResponseEntity<?>  getCpvList(@RequestBody CustomerLoanCPVBusinessRecordEntity  cpvEntity){
		
	System.out.println("syncing method me aa rha hai..."); 
	
	if(null != cpvEntity.getMcreatedby()) {
			
		  System.out.println(cpvEntity.getMlastsynsdate()!=null ?  cpvEntity.getMlastsynsdate():"printng yha aa gya");
		  
		  return  service.findByCreatedByAndLastSyncedTime(cpvEntity);
	  }
	
	  return null; 
 }
}
