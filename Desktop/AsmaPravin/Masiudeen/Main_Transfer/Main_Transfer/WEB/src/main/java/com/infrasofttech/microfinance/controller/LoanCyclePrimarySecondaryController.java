package com.infrasofttech.microfinance.controller;

import java.util.List;

import javax.persistence.EntityNotFoundException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.infrasofttech.microfinance.entityBeans.master.holder.LoanCyclePrimarySecondaryHolder;
import com.infrasofttech.microfinance.services.LoanCyclePrimarySecondaryService;


@CrossOrigin(origins = "*", allowedHeaders = "*")
@RestController
@RequestMapping("/loanCycle")
public class LoanCyclePrimarySecondaryController {
	
	@Autowired
	LoanCyclePrimarySecondaryService loanService;
	
	
	@GetMapping(value="/getLoanCycle", produces="application/json")
	public ResponseEntity<?> getLoanCycle(){
		return loanService.getLoanCycle();
	}	
	
	@PostMapping(value = "/addLoanCycle",produces ="application/json" )
	public ResponseEntity<?> addLoanCycle(@RequestBody LoanCyclePrimarySecondaryHolder loanCycle){
		System.out.println("iske andar aaya");
		if(loanCycle !=null)
			return loanService.addLoanCycle(loanCycle);
		return null;
	}
	
	@PostMapping(value = "/addLoanCycleSecondary",produces ="application/json" )
	public ResponseEntity<?> addLoanCycleSecondary(@RequestBody LoanCyclePrimarySecondaryHolder loanCycle){
		System.out.println("iske andar aaya");
		if(loanCycle !=null)
			return loanService.addLoanCycleSecondary(loanCycle);
		return null;
	}

	@PostMapping(value = "/editLoanCyclePrimary", produces = "application/json")
	public ResponseEntity<?> editLoanCyclePrimary(@RequestBody LoanCyclePrimarySecondaryHolder loanCycle){
		if(loanCycle !=null)
			return loanService.editLoanCyclePrimary(loanCycle);		
		return null;
	}
	
	@PostMapping(value = "/editLoanCycleSecondary", produces = "application/json")
	public ResponseEntity<?> editLoanCycleSecondary(@RequestBody LoanCyclePrimarySecondaryHolder loanCycle){
		if(loanCycle !=null)
			return loanService.editLoanCycleSecondary(loanCycle);		
		return null;
	}
	
	
	@PostMapping(value = "/delete", produces = "application/json")
	public ResponseEntity<?> deleteLoanCycleData(@RequestBody LoanCyclePrimarySecondaryHolder loanCycle){
		if(loanCycle !=null)
			return loanService.deleteLoanCycleData(loanCycle);
		return null;
	}
	
	
	@PostMapping(value = "/bulkDelete", produces = "application/json")
	public ResponseEntity<?> deleteLoanCycle(@RequestBody List<LoanCyclePrimarySecondaryHolder> loanCycleHolder) {
		if(loanCycleHolder !=null) {
			
			return loanService.deleteLoanCycle(loanCycleHolder);
		}
		return null;
	}
	
}
