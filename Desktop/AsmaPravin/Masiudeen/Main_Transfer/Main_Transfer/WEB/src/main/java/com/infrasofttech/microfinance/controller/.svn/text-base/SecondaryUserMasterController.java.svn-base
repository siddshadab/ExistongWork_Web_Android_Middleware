package com.infrasofttech.microfinance.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.infrasofttech.microfinance.entityBeans.master.SecondaryUserMasterEntity;
import com.infrasofttech.microfinance.services.SecondaryUserMasterServices;

@CrossOrigin(origins = "*", allowedHeaders = "*")
@RestController
@RequestMapping("/secondaryUserMaster")
public class SecondaryUserMasterController {
	
	
	@Autowired
	SecondaryUserMasterServices services;
	
	@GetMapping(value = "/getAll", produces = "application/json")
	public ResponseEntity<?>  getAllSecondaryUser() {
		return services.getAllSecondaryUser();
	}
	
	@PostMapping(value="/add", produces="application/json")
	public ResponseEntity<?> addSecondaryUser(@RequestBody SecondaryUserMasterEntity secondaryEntity){
		if(null != secondaryEntity) {
			return services.addSecondaryUser(secondaryEntity);			
		}
		return null;
	}
	
	@PostMapping(value="/edit", produces="application/json")
	public ResponseEntity<?> editSecondaryUser(@RequestBody SecondaryUserMasterEntity secondaryEntity){
		if(null != secondaryEntity) {
			return services.editSecondaryUser(secondaryEntity);			
		}
		return null;
	}
	
	@PostMapping(value="/delete", produces="application/json")
	public ResponseEntity<?> deleteSecondaryUser(@RequestBody SecondaryUserMasterEntity secondaryEntity){
		if(null != secondaryEntity) {
			return services.deleteSecondaryUser(secondaryEntity);			
		}
		return null;
	}

}
