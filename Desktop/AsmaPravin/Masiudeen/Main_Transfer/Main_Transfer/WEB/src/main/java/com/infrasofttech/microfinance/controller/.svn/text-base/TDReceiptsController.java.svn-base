package com.infrasofttech.microfinance.controller;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.infrasofttech.microfinance.entityBeans.CountriesEntity;
import com.infrasofttech.microfinance.entityBeans.master.CustomerEntity;
import com.infrasofttech.microfinance.entityBeans.master.CustomerLoanEntity;
import com.infrasofttech.microfinance.entityBeans.master.SavingsListEntity;
import com.infrasofttech.microfinance.entityBeans.master.SpeedoMeterEntity;
import com.infrasofttech.microfinance.entityBeans.master.TDReceiptsEntity;
import com.infrasofttech.microfinance.repository.LookupMasterRepository;
import com.infrasofttech.microfinance.services.SavingsListServices;
import com.infrasofttech.microfinance.servicesimpl.CountriesServiceImpl;
import com.infrasofttech.microfinance.servicesimpl.LookupMasterServicesImpl;
import com.infrasofttech.microfinance.servicesimpl.SavingsListServicesImpl;
import com.infrasofttech.microfinance.servicesimpl.SpeedoMeterServiceImpl;
import com.infrasofttech.microfinance.servicesimpl.SystemParameterServicesImpl;
import com.infrasofttech.microfinance.servicesimpl.TDReceiptsServicesImpl;

@RestController
@RequestMapping("/TDReceiptsController")
public class TDReceiptsController {


	@Autowired
	TDReceiptsServicesImpl tDReceiptsServicesImpl;

	@PostMapping(value = "/add", produces = "application/json")
	public ResponseEntity<?> addlist(@RequestBody List<TDReceiptsEntity> TDList) {
		
		ResponseEntity<List<TDReceiptsEntity>> responseEntity = null;
		if (null != TDList) {
			
		
		
		responseEntity = (ResponseEntity<List<TDReceiptsEntity>>)tDReceiptsServicesImpl.addList(TDList);
		
		 if(TDList.size()==1) {
				
				System.out.println("Inside Single Loan Sync");
				List<TDReceiptsEntity> addEntity;
		for(TDReceiptsEntity TDEntity:responseEntity.getBody()) {
			
			
			if(TDEntity.getMprdacctid()==null||TDEntity.getMprdacctid().trim()==""||
					TDEntity.getMprdacctid().trim()=="0"||
					TDEntity.getMprdacctid().toUpperCase().trim()=="NULL"
					) {
				addEntity = new ArrayList<TDReceiptsEntity>();
				
				tDReceiptsServicesImpl.synchronizeTDToOmni(TDEntity);
				
				addEntity.add(TDEntity);
				
				
				responseEntity = new ResponseEntity<List<TDReceiptsEntity>>(addEntity,new HttpHeaders(),HttpStatus.CREATED);
				
			}		
			
			
		}
		
		
			System.out.println(responseEntity);
			return responseEntity;
			}
			else {
				return responseEntity;
			}
		
		
		}
		
		
		
		return null;
	}

	  @PostMapping(value = "/getTDReceiptstbyCreatedByAndLastSyncedTiming/",
	  produces = "application/json") public ResponseEntity<?>
	  getSavingsListbyAgentUserName(@RequestBody TDReceiptsEntity
			  tDReceiptsEntity)
	  { 
		  if(null != tDReceiptsEntity.getMcreatedby()) 
		  {
			  System.out.println(tDReceiptsEntity.getMlastsynsdate()!=null?
					  tDReceiptsEntity.getMlastsynsdate():"printng yha aa gya");
			  return tDReceiptsServicesImpl.findByCreatedByAndLastSyncedTime(tDReceiptsEntity);
	  } return null; }
	 
}
