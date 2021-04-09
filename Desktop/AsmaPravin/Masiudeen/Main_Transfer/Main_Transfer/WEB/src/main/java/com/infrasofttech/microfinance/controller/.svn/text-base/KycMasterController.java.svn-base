package com.infrasofttech.microfinance.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.infrasofttech.microfinance.entityBeans.master.KycMasterEntity;
import com.infrasofttech.microfinance.entityBeans.master.SavingsListEntity;
import com.infrasofttech.microfinance.repository.KycMasterRepository;
import com.infrasofttech.microfinance.servicesimpl.KycMasterServiceImpl;

@RestController
@RequestMapping("/kycMasterData")
public class KycMasterController {
	
	

	@Autowired
	KycMasterServiceImpl kycMasterServiceImpl;
	
	

	//Getting Kyc Details	
	@GetMapping(value = "/getKycMaster", produces = "application/json")
	public ResponseEntity<?> getAll() {
		return kycMasterServiceImpl.getAllKycMasterData();
	}

	//Adding Kyc Details	
	@PostMapping(value = "/add", produces = "application/json")
	public ResponseEntity<?>  addList(@RequestBody List<KycMasterEntity> kycMasterEntity){
		System.out.print("aaya hai idhr");
		System.out.println(kycMasterEntity);
		if(null != kycMasterEntity)
			return kycMasterServiceImpl.addList(kycMasterEntity);
		return null;
	}	
	
	@PostMapping(value = "/getKycListbyCreatedByAndLastSyncedTiming",produces = "application/json")
	public ResponseEntity<?>  getKycList(@RequestBody KycMasterEntity  kycMasterEntity){
		
	System.out.println("syncing method me aa rha hai..."); 
	
	if(null != kycMasterEntity.getMcreatedby()) {
			
		  System.out.println(kycMasterEntity.getMlastsynsdate()!=null ?  kycMasterEntity.getMlastsynsdate():"printng yha aa gya");
		  
		  return  kycMasterServiceImpl.findByCreatedByAndLastSyncedTime(kycMasterEntity);
	  }
	
	  return null; 
 }
	
}
