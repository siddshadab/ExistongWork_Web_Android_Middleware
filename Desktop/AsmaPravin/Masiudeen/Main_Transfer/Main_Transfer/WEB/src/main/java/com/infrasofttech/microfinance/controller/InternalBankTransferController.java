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
	
	

}
