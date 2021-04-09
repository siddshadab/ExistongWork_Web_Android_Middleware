package com.infrasofttech.microfinance.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.infrasofttech.microfinance.entityBeans.CountriesEntity;
import com.infrasofttech.microfinance.servicesimpl.CountriesServiceImpl;

@RestController
@RequestMapping("/countries")
public class CountriesController {
	
	
	
	
	@Autowired 
	CountriesServiceImpl countries;

	@PostMapping(value = "/add", produces = "application/json")
	public ResponseEntity<?> addData(@RequestBody CountriesEntity contries){
		if(null != contries)
			return countries.addCountries(contries);
		return null;
	}
	
	@GetMapping(value = "/getlistOfData", produces = "application/json")
	public ResponseEntity<?> getAll(){
		return countries.getCountries();
	}


	/*
	 * @GetMapping(value = "/get/{countryName}", produces = "application/json")
	 * public ResponseEntity<?> getCountries(@PathVariable String countryName){
	 * return countries.getCountries(countryName); }
	 */

}
