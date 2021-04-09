package com.infrasofttech.microfinance.controller;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.infrasofttech.microfinance.entityBeans.CountriesEntity;
import com.infrasofttech.microfinance.entityBeans.master.CustomerEntity;
import com.infrasofttech.microfinance.entityBeans.master.SavingsListEntity;
import com.infrasofttech.microfinance.entityBeans.master.SpeedoMeterEntity;
import com.infrasofttech.microfinance.entityBeans.master.holder.AckHolder;
import com.infrasofttech.microfinance.repository.LookupMasterRepository;
import com.infrasofttech.microfinance.schedular.ScheduledServicesToCoreSystem;
import com.infrasofttech.microfinance.services.SavingsListServices;
import com.infrasofttech.microfinance.servicesimpl.CountriesServiceImpl;
import com.infrasofttech.microfinance.servicesimpl.LookupMasterServicesImpl;
import com.infrasofttech.microfinance.servicesimpl.SavingsListServicesImpl;
import com.infrasofttech.microfinance.servicesimpl.SpeedoMeterServiceImpl;
import com.infrasofttech.microfinance.servicesimpl.SystemParameterServicesImpl;

@RestController
@RequestMapping("/SavingsListController")
public class SavingsListController {


	@Autowired
	SavingsListServicesImpl savingsListServicesImpl;
	
	 private static final Logger LOGGER=LoggerFactory.getLogger(SavingsListController.class);
	
	

	@PostMapping(value = "/add", produces = "application/json")
	public ResponseEntity<?> addlist(@RequestBody List<SavingsListEntity> svng) {
		System.out.println("svng--------------------"+svng.toString());
		if (null != svng)
			return savingsListServicesImpl.addList(svng);
		return null;
	}

	  @PostMapping(value = "/getSavingsListbyCreatedByAndLastSyncedTiming/",produces = "application/json") public ResponseEntity<?>
	  getSavingsListbyAgentUserName(@RequestBody SavingsListEntity  savingsListEntity){
	  if(null != savingsListEntity.getMcreatedby()) {
	  System.out.println(savingsListEntity.getMlastsynsdate()!=null?  savingsListEntity.getMlastsynsdate():"printng yha aa gya");
	  return  savingsListServicesImpl.findByCreatedByAndLastSyncedTime(savingsListEntity);
	  } 
	  return null; }
	  
	  
	
	  
	  
		@PostMapping(value = "/updateSavingsSyncFromServer/", produces = "application/json")
		public ResponseEntity<?>  updateSavingsSyncFromServer(@RequestBody AckHolder ackHolder){
			if(null != ackHolder ) {
				System.out.println(" Ack List : "+ ackHolder.getMrefnolist());
				LOGGER.info("updating sync from  info");
				LOGGER.debug("List is {}", ackHolder);
				savingsListServicesImpl.updateSyncFromCore(ackHolder.getMrefnolist());
				
			}
			return null;
		}
	  
	  
	 
}
