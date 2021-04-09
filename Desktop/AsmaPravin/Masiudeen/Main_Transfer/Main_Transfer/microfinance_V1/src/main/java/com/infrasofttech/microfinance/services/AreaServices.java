package com.infrasofttech.microfinance.services;

import javax.validation.Valid;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import com.infrasofttech.microfinance.entityBeans.DistrictsEntity;
import com.infrasofttech.microfinance.entityBeans.SubDistrictsEntity;

@Service
public interface AreaServices {

	/*
	 * public ResponseEntity<?> addSubDistricts(@Valid SubDistrictsEntity entity,
	 * Long districts);
	 */
		
	public ResponseEntity<?> getArea();
	public ResponseEntity<?> getArea(int lbrcd);

}
