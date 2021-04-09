package com.infrasofttech.microfinance.servicesimpl;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import com.infrasofttech.microfinance.entityBeans.CountriesEntity;
import com.infrasofttech.microfinance.entityBeans.master.CentersFoundationEntity;
import com.infrasofttech.microfinance.repository.CountriesRepository;
import com.infrasofttech.microfinance.services.CountriesServices;

@Service
@Transactional
public class CountriesServiceImpl implements CountriesServices{

	@Autowired
	CountriesRepository repo;
	
	public ResponseEntity<?> addCountries(CountriesEntity contries) {
		try {	 
			
			return new ResponseEntity<Object>(repo.save(contries),new HttpHeaders(),HttpStatus.CREATED);
		} catch (Exception e) {
			//logger.error("Error While Persisting Object"+e.getMessage());
			return new ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY);
		}
	}

	@Override
	public ResponseEntity<?> getCountries() {
		try {
			List<CountriesEntity> countryList=repo.findAll();
			if(countryList.isEmpty()) 
				return ResponseEntity.notFound().build();
			return new ResponseEntity<List<CountriesEntity>>(countryList,new HttpHeaders(),HttpStatus.OK);
		}catch(Exception e) {
			//logger.error("No Record Found."+e.getMessage());
			return new ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY);
		}
		
		
	}
	
	
	/*
	 * @Override public ResponseEntity<?> getCountries(String countryName) { try {
	 * List<CountriesEntity> dbEntity = repo.findByCountryName(countryName); if(null
	 * == dbEntity) return ResponseEntity.notFound().build(); return new
	 * ResponseEntity<Object>(dbEntity,new HttpHeaders(),HttpStatus.OK);
	 * }catch(Exception e) { //logger.error("No Record Found."+e.getMessage());
	 * return new ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY); } }
	 */
	
	
}
