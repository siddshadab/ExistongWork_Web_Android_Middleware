package com.infrasofttech.microfinance.controller.fields;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.infrasofttech.microfinance.entityBeans.fields.VillageBasicScreenFieldsEntity;
import com.infrasofttech.microfinance.services.fields.VillageBasicsScreenFieldsServices;

@RestController
@RequestMapping("/VillageBasicsScreenFields")
public class VillageBasicsScreenFieldsController {

	
	@Autowired
	VillageBasicsScreenFieldsServices villageBasicsScreenFieldsServices;
	
	@PostMapping(value = "/addFields", produces = "application/json")
	public ResponseEntity<?>  addlist(@RequestBody VillageBasicScreenFieldsEntity entity){
		if(null != entity)
			return villageBasicsScreenFieldsServices.addVillageBasicsScreenFields(entity);
		return null;
	}
	
	
	@GetMapping(value = "/getAllBasicsScreenFields", produces = "application/json")
	public ResponseEntity<?> getAll(){
		return villageBasicsScreenFieldsServices.getAllBasicsScreenFields();
	}
	
}
