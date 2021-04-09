package com.infrasofttech.microfinance.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.infrasofttech.microfinance.servicesimpl.CustomerServiceImpl;
import com.infrasofttech.microfinance.servicesimpl.TransactionModeServiceImpl;

@RestController
@RequestMapping("/transactionModeData")
public class TransactionModeController {
	
	@Autowired
	TransactionModeServiceImpl transactionModeService;
	
	
	@GetMapping(value = "/getlistOfTransactionMode", produces = "application/json")
	public ResponseEntity<?> getAll(){
		System.out.println("init");
		return transactionModeService.getAllTransactionModeData();
	}

}
