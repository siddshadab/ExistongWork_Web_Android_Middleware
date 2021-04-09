package com.infrasofttech.microfinance.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.infrasofttech.microfinance.entityBeans.master.CustomerLoanCPVBusinessRecordEntity;
import com.infrasofttech.microfinance.entityBeans.master.CustomerLoanCashFlowEntity;
import com.infrasofttech.microfinance.entityBeans.master.DeviationFormEntity;
import com.infrasofttech.microfinance.services.DeviationFormService;

@RestController
@RequestMapping("/deviationForm")
public class DeviationFormController {
	
	@Autowired 
	DeviationFormService service;
	
	
	@PostMapping(value = "/add", produces = "application/json")
	public ResponseEntity<?>  addlist(@RequestBody List<DeviationFormEntity> group){
		if(null != group)
			return service.addList(group);;
		return null;
	}
	
	@PostMapping(value = "/getDeviationByCreatedByAndLastSyncedTiming",produces = "application/json")
	public ResponseEntity<?>  getDeviationList(@RequestBody DeviationFormEntity  deviationEntity){
		
	System.out.println("syncing method me aa rha hai..."); 
	
	if(null != deviationEntity.getMcreatedby()) {
			
		  System.out.println(deviationEntity.getMlastsynsdate()!=null ?  deviationEntity.getMlastsynsdate():"printng yha aa gya");
		  
		  return  service.findByCreatedByAndLastSyncedTime(deviationEntity);
	  }
	
	  return null; 
 }
}
