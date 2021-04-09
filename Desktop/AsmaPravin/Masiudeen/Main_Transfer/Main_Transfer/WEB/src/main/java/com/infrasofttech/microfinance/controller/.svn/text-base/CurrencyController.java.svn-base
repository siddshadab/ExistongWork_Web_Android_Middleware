package com.infrasofttech.microfinance.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.infrasofttech.microfinance.services.CurrencyServices;

@CrossOrigin(origins = "*", allowedHeaders = "*")
@RestController
@RequestMapping("/currencyMaster")
public class CurrencyController {

	@Autowired
	CurrencyServices service;
	
	@GetMapping(value="/getAll",produces="application/json")
	public ResponseEntity<?> getAllCurrencyCd(){
		System.out.println("aaya");
		return service.getAllCurrCd(); 
	}
}
