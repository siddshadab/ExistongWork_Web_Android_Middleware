package com.infrasofttech.microfinance.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.infrasofttech.microfinance.services.LoanLevelService;

@RestController
@RequestMapping("/loanlevel")
public class LoanLevelController {
	
	@Autowired 
	LoanLevelService loanLevelService;
	
	@GetMapping(value = "/getloanlevel", produces = "application/json")
	public ResponseEntity<?>  getLoanLevel(){
	
			return loanLevelService.getLoanLevel();
	

	}
	
}
