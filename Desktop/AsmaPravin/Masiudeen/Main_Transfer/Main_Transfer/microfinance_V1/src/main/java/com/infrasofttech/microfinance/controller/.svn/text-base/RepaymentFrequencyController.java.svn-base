package com.infrasofttech.microfinance.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.infrasofttech.microfinance.servicesimpl.RepaymentFrequencyServiceImpl;

@RestController
@RequestMapping("/repaymentFrequencyData")
public class RepaymentFrequencyController {
	
	@Autowired
	RepaymentFrequencyServiceImpl  repaymentFrequencyService; 
	
	@GetMapping(value = "/getlistOfrepaymentFrequency", produces = "application/json")
	public ResponseEntity<?> getAll(){
		return repaymentFrequencyService.getAllRepaymentFrequencyData();
	}

}
