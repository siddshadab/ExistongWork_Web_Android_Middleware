package com.infrasofttech.microfinance.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.infrasofttech.microfinance.entityBeans.CountriesEntity;
import com.infrasofttech.microfinance.entityBeans.master.holder.AddressMasterHolder;
import com.infrasofttech.microfinance.services.CountriesServices;
import com.infrasofttech.microfinance.servicesimpl.CountriesServiceImpl;

@CrossOrigin(origins = "*", allowedHeaders = "*")
@RestController
@RequestMapping("/countries")
public class CountriesController {
	
	
	
	
	@Autowired 
	CountriesServiceImpl countries;
	
	@Autowired
	CountriesServices countryService;
	
	
	@GetMapping(value = "/getlistOfData", produces = "application/json")
	public ResponseEntity<?> getAll(){
		return countries.getCountries();
	}


	
//	  @GetMapping(value = "/get/{countryid}", produces = "application/json")
//	  public ResponseEntity<?> getCountries(@PathVariable String countryid){
//		  	return countries.getCountries(countryid); 
//		  	}
//	 

	@PostMapping(value = "/add", produces = "application/json")
	public ResponseEntity<?> addCountries(@RequestBody CountriesEntity contries){
		if(null != contries)
			return countryService.addCountries(contries);
		return null;
	}
	
	
	@PostMapping(value="/edit",produces="application/json")
	public ResponseEntity<?> editCountries(@RequestBody CountriesEntity countries){
		if(null!=countries) {
			return countryService.editCountries(countries);
		}
		return null;
	}
	
//	@PostMapping(value="/delete",produces ="applicatioin/json")
//	public ResponseEntity<?> deleteCountries(@RequestBody CountriesEntity countries){
//		if(null !=countries) {
//			return countryService.deleteCountries(countries);
//		}			
//		return null;
//	}
	
	@PostMapping(value="/delete",produces="application/json")
	public ResponseEntity<?> bulkDelete(@RequestBody AddressMasterHolder addressHolder){
		if(null != addressHolder) {
			return countryService.bulkDelete(addressHolder);
		}
		return null;
	}
	
}
