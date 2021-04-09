package com.infrasofttech.microfinance.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.infrasofttech.microfinance.services.LoanCycleWiseLimitService;

@RestController
@RequestMapping("/loanLimit")
public class LoanCycleWiseLimitController {
	
	@Autowired
	LoanCycleWiseLimitService loanCycleWiseService;
	
	
	@GetMapping(value = "/getLoanCycleWiseLimit/", produces = "application/json")
	public ResponseEntity<?>  getAllInsertOffsetData() {
		return loanCycleWiseService.getLoanLimts();
	}

}
