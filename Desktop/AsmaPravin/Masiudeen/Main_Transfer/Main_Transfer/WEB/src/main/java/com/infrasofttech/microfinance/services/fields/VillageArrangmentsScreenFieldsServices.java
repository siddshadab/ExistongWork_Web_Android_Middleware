package com.infrasofttech.microfinance.services.fields;

import org.springframework.http.ResponseEntity;

import com.infrasofttech.microfinance.entityBeans.fields.VillageArrangmentsScreenFieldsEntity;

public interface VillageArrangmentsScreenFieldsServices {

	
	public ResponseEntity<?> getAllArrangmentsScreenFields();
	public ResponseEntity<?> addVillageArrangmentsScreenFields(VillageArrangmentsScreenFieldsEntity entity);
	
}
