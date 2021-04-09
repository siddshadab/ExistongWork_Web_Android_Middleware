package com.infrasofttech.microfinance.controller;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.infrasofttech.microfinance.entityBeans.master.DeviationFormEntity;
import com.infrasofttech.microfinance.entityBeans.master.GuarantorEntity;
import com.infrasofttech.microfinance.services.GuarantorServices;
import com.infrasofttech.microfinance.servicesimpl.GuarantorServicesImpl;


@RestController
@RequestMapping("/GuarantorController")
public class GuarantorController {


	@Autowired
	GuarantorServicesImpl guarantorServicesImpl;
	
	@Autowired
	GuarantorServices service;

	
	  @PostMapping(value = "/add", produces = "application/json") 
	  public ResponseEntity<?> addlist(@RequestBody List<GuarantorEntity> grntr) {
	  System.out.println("grntr--------------------"+grntr.toString());
	  if (null != grntr) 
		  return guarantorServicesImpl.addList(grntr); 
	  return null; 
	  
	  }
	 
	
	/*
	 * @PostMapping(value ="/add", produces ="application/json") public
	 * ResponseEntity<?> add(@RequestBody GuarantorEntity grntrEntity){ if (null !=
	 * grntrEntity) return service.add1List(grntrEntity);
	 * System.out.println("guarantorzzzzzzzzzzzzzzzzz"+grntrEntity); return null;
	 * 
	 * 
	 * }
	 */
	 
	
	@PostMapping(value = "/getGuarantorByCreatedByAndLastSyncedTiming",produces = "application/json")
	public ResponseEntity<?>  getGuarantorList(@RequestBody GuarantorEntity guaranatorEntity){
		
	
	
	if(null != guaranatorEntity.getMcreatedby()) {
		 
		  System.out.println(guaranatorEntity.getMlastsynsdate()!=null ?  guaranatorEntity.getMlastsynsdate():"printng yha aa gya");
		  
		  return  service.findByCreatedByAndLastSyncedTime(guaranatorEntity);
	  }
	
	  return null; 
 }
	
	 
}
