package com.infrasofttech.microfinance.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.infrasofttech.microfinance.entityBeans.master.CustomerLoanCashFlowEntity;
import com.infrasofttech.microfinance.entityBeans.master.SocialAndEnvironmentalEntity;
import com.infrasofttech.microfinance.services.SocialAndEnvironmentalService;

@RestController
@RequestMapping("/socialAndEnvironmental")
public class SocialAndEnvironmentalController {
	
	@Autowired 
	SocialAndEnvironmentalService service;
	
	
	@PostMapping(value = "/add", produces = "application/json")
	public ResponseEntity<?>  addlist(@RequestBody List<SocialAndEnvironmentalEntity> group){
		if(null != group)
			return service.addList(group);;
		return null;
	}
	
	
	 @PostMapping(value = "/getSocialEnvironmentCreatedByAndLastSyncedTiming",produces = "application/json") 
	 public ResponseEntity<?> getSocialEnvironmentList(@RequestBody SocialAndEnvironmentalEntity  socialEnvEntity){
		 
	  if(null != socialEnvEntity.getMcreatedby()) {
		  
	  System.out.println(socialEnvEntity.getMlastsynsdate()!=null?  socialEnvEntity.getMlastsynsdate():"printng yha aa gya");
	  
	  return  service.findByCreatedByAndLastSyncedTime(socialEnvEntity);
	 } 
	  return null; 
	  }
}
