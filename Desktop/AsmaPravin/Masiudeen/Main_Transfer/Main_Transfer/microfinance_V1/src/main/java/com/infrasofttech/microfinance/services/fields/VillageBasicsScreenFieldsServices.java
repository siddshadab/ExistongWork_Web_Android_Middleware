package com.infrasofttech.microfinance.services.fields;

import org.springframework.http.ResponseEntity;

import com.infrasofttech.microfinance.entityBeans.fields.VillageBasicScreenFieldsEntity;

public interface VillageBasicsScreenFieldsServices {

	
	public ResponseEntity<?> getAllBasicsScreenFields();
	public ResponseEntity<?> addVillageBasicsScreenFields(VillageBasicScreenFieldsEntity entity);
	
}
