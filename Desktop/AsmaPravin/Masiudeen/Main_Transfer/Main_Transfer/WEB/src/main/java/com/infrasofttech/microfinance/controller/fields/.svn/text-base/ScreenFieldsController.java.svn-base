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
import com.infrasofttech.microfinance.entityBeans.fields.ScreenFieldsEntity;
import com.infrasofttech.microfinance.services.fields.VillageArrangmentsScreenFieldsServices;
import com.infrasofttech.microfinance.services.fields.VillageBasicsScreenFieldsServices;
import com.infrasofttech.microfinance.services.fields.ScreenFieldsServices;

@RestController
@RequestMapping("/ScreenFields")
public class ScreenFieldsController {

	
	@Autowired
	ScreenFieldsServices ScreenFieldsServices;
	
	@PostMapping(value = "/addFields", produces = "application/json")
	public ResponseEntity<?>  addlist(@RequestBody ScreenFieldsEntity entity){
		if(null != entity)
			return ScreenFieldsServices.addScreenFields(entity);
		return null;
	}
	
	
	@GetMapping(value = "/getAllScreenFields", produces = "application/json")
	public ResponseEntity<?> getAll(){
		return ScreenFieldsServices.getAllScreenFields();
	}
	
}
