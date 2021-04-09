package com.infrasofttech.microfinance.services;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import com.infrasofttech.microfinance.entityBeans.CountriesEntity;
import com.infrasofttech.microfinance.entityBeans.master.holder.AddressMasterHolder;

@Service
public interface CountriesServices {

	
	public ResponseEntity<?> addCountries(CountriesEntity contries);
	
	public ResponseEntity<?> getCountries();	
	
	public ResponseEntity<?> editCountries(CountriesEntity contries);
	
	//public ResponseEntity<?> deleteCountries(CountriesEntity contries);
	
	public ResponseEntity<?> bulkDelete(AddressMasterHolder addressMasterHolder);
}
