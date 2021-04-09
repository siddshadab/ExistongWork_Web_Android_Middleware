package com.infrasofttech.microfinance.controller.fields;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.infrasofttech.microfinance.entityBeans.fields.VillageArrangmentsScreenFieldsEntity;
import com.infrasofttech.microfinance.entityBeans.fields.VillageBasicScreenFieldsEntity;
import com.infrasofttech.microfinance.services.fields.VillageArrangmentsScreenFieldsServices;
import com.infrasofttech.microfinance.services.fields.VillageBasicsScreenFieldsServices;

@RestController
@RequestMapping("/VillageArrangmentsScreenFields")
public class VillageArrangmentsScreenFieldsController {

	
	@Autowired
	VillageArrangmentsScreenFieldsServices villageArrangmentsScreenFieldsServices;
	
	@PostMapping(value = "/addFields", produces = "application/json")
	public ResponseEntity<?>  addlist(@RequestBody VillageArrangmentsScreenFieldsEntity entity){
		if(null != entity)
			return villageArrangmentsScreenFieldsServices.addVillageArrangmentsScreenFields(entity);
		return null;
	}
	
	
	@GetMapping(value = "/getAllArrangmentsScreenFields", produces = "application/json")
	public ResponseEntity<?> getAll(){
		return villageArrangmentsScreenFieldsServices.getAllArrangmentsScreenFields();
	}
	
}
