package com.infrasofttech.microfinance.controller;

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
import com.infrasofttech.microfinance.entityBeans.master.DisbursedListEntity;
import com.infrasofttech.microfinance.entityBeans.master.InternalBankTransferEntity;
import com.infrasofttech.microfinance.entityBeans.master.holder.AckHolder;
import com.infrasofttech.microfinance.entityBeans.master.holder.CIFHolderBean;
import com.infrasofttech.microfinance.entityBeans.master.holder.InternalBankTransferHolderBean;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.servicesImpl.CIFServiceImpl;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.servicesImpl.InternalBankTransferServiceImpl;

@RestController
@RequestMapping("/internalBankTransfer")
public class InternalBankTransferController {
	
	@Autowired
	InternalBankTransferServiceImpl internalBankTransferServiceImpl;
	
	
	
	
	@PostMapping(value = "/doTransaction",produces = "application/json")
	public ResponseEntity<?> getCifDetailList(@RequestBody InternalBankTransferHolderBean internalBankTransferHolder){
		
		System.out.println("Aya");
		System.out.println(internalBankTransferHolder);
		try {
			if(internalBankTransferHolder != null && internalBankTransferHolder.getMlbrcode() != 0) {
				System.out.println("Going to do internal transaction ");
				internalBankTransferServiceImpl.omniSoapServicesInternalBankTransfer(internalBankTransferHolder);
				return new ResponseEntity<InternalBankTransferHolderBean>(internalBankTransferHolder,new HttpHeaders(),HttpStatus.OK);}
		}

		catch(Exception e) {
			System.out.println("Kuch Exception aaya");
			return new  ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY);
		}

		return null;
		}
	
	
	@PostMapping(value = "/add", produces = "application/json")
	public ResponseEntity<?>  addlist(@RequestBody List<InternalBankTransferEntity> internalBankTransferList){

		if (null != internalBankTransferList)
			return internalBankTransferServiceImpl.addList(internalBankTransferList);
		else {
			
			return null;
		}
		
		
	}
	
	
	
	
	@PostMapping(value = "/updateSyncFromServer/", produces = "application/json")
	public ResponseEntity<?>  updateCustomerSyncFromServer(@RequestBody AckHolder ackHolder){
		System.out.println("enter kia");
		if(null != ackHolder ) {
			//System.out.println(ackHolder);
			internalBankTransferServiceImpl.updateSyncFromCore(ackHolder.getMrefnolist());
		}
		return null;
	}
	
	
	
	
	
	@PostMapping(value = "/getInternalBankTransferResponse/", produces = "application/json")
	public ResponseEntity<?>  getInternalBankTransferResponse(@RequestBody InternalBankTransferEntity internalBankTransferEntity){
	
		if(null != internalBankTransferEntity.getMcreatedby()) {
			System.out.println(internalBankTransferEntity.getMlastsynsdate()!=null?internalBankTransferEntity.getMlastsynsdate():"printng chu ");
			System.out.println("Yhan khatam hua");
			return internalBankTransferServiceImpl.findModifiedData(internalBankTransferEntity);
		}
		return null;
	}
	

}
