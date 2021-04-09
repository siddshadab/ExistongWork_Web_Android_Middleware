package com.infrasofttech.microfinance.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.infrasofttech.microfinance.entityBeans.master.holder.InternalBankTransferHolderBean;
import com.infrasofttech.microfinance.entityBeans.master.holder.TDClosureHolder;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.servicesImpl.TDClosureDetailsServiceImpl;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.servicesImpl.TDClosureServiceImpl;

@RestController
@RequestMapping("/TDClosure")
public class TDClosureController {
	
	@Autowired
	TDClosureDetailsServiceImpl tdServiceClosuredetaislImpl;
	
	@Autowired
	TDClosureServiceImpl tdServiceClosurelImpl;
	
	
	@PostMapping(value = "/getTDDetails",produces = "application/json")
	public ResponseEntity<?> getTDDetails(@RequestBody TDClosureHolder tdClosreHolder){
		
		System.out.println("Aya");
		System.out.println(tdClosreHolder);
		try {
			if(tdClosreHolder != null && tdClosreHolder.getMlbrcode() != 0) {
				System.out.println("Going to get TD Details");
				tdServiceClosuredetaislImpl.getTDClosureDetails(tdClosreHolder);
				return new ResponseEntity<TDClosureHolder>(tdClosreHolder,new HttpHeaders(),HttpStatus.OK);}
		}

		catch(Exception e) {
			System.out.println("Kuch Exception aaya");
			return new  ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY);
		}

		return null;
		}
	
	@PostMapping(value = "/postTDClosure",produces = "application/json")
	public ResponseEntity<?> postTDClosure(@RequestBody TDClosureHolder tdClosreHolder){
		
		System.out.println("Aya TD Closure m");
		System.out.println(tdClosreHolder);
		try {
			if(tdClosreHolder != null && tdClosreHolder.getMlbrcode() != 0) {
				System.out.println("Going to Close TD");
				tdServiceClosurelImpl.omniRequestCloseTD(tdClosreHolder);
				return new ResponseEntity<TDClosureHolder>(tdClosreHolder,new HttpHeaders(),HttpStatus.OK);}
		}

		catch(Exception e) {
			System.out.println("Kuch Exception aaya");
			return new  ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY);
		}

		return null;
		}

}
