package com.infrasofttech.microfinance.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.infrasofttech.microfinance.entityBeans.master.CustomerEntity;
import com.infrasofttech.microfinance.entityBeans.master.CustomerLoanEntity;
import com.infrasofttech.microfinance.entityBeans.master.DisbursedListEntity;
import com.infrasofttech.microfinance.entityBeans.master.SavingsListEntity;
import com.infrasofttech.microfinance.servicesimpl.DisbursedListServiceImpl;
import com.infrasofttech.microfinance.servicesimpl.DisbursementListServicesImpl;

@RestController
@RequestMapping("/DisbursedListController")
public class DisbursedListController {

	@Autowired
	DisbursedListServiceImpl disbursedListServicesImpl;

	
	@PostMapping(value = "/add", produces = "application/json")
	public ResponseEntity<?>  addlist(@RequestBody List<DisbursedListEntity> disbursedList){
		System.out.println("dsbrs--------------------"+disbursedList.toString());
		if (null != disbursedList)
			return disbursedListServicesImpl.addList(disbursedList);
		else {
			
			return null;
		}
		
		
	}
	
	
	
	
	
	@PostMapping(value = "/getDisbursedListbyCreatedByAndLastSyncedTiming/",produces = "application/json") public ResponseEntity<?>
	  getSavingsListbyAgentUserName(@RequestBody DisbursedListEntity  disbursedEntity){
	  if(null != disbursedEntity.getMcreatedby()) {
	  System.out.println(disbursedEntity.getMlastsynsdate()!=null?  disbursedEntity.getMlastsynsdate():"Disursed List k lie aya");
	  return  disbursedListServicesImpl.findByCreatedByOrRouteTo(disbursedEntity.getMcreatedby(),disbursedEntity.getMlastsynsdate());
	  } 
	  return null; }
	
	
	
	
	@PostMapping(value = "/addlistandSync", produces = "application/json")
	public ResponseEntity<?>  addlistandSync(@RequestBody List<DisbursedListEntity> disbursedList){
		System.out.println("dsbrs--------------------"+disbursedList.toString());
		//if (null != disbursedList) {
			ResponseEntity<List<DisbursedListEntity>> responseEntity = disbursedListServicesImpl.addList(disbursedList);
		
		
		
		if(disbursedList.size()==1) {   	   
	    	   
	    	   List<DisbursedListEntity> addEntity= responseEntity.getBody();
				if(addEntity.get(0).getMissynctocoresys()!=1) {	
					disbursedListServicesImpl.synchronizeDisbursedListToOmni(addEntity);
					responseEntity = new ResponseEntity<List<DisbursedListEntity>>(addEntity,new HttpHeaders(),HttpStatus.CREATED);				
					
				}
				
				System.out.println("is Sync to core sys is 1");
					
					
			}
			
		
		else {
			
			System.out.println("Size hai "+disbursedList.size());
			
			return null;
		}
		
		
		return responseEntity;
	}
	
	
	
}
