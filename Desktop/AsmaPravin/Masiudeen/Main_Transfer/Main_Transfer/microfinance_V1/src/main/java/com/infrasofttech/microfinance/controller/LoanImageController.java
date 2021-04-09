package com.infrasofttech.microfinance.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.infrasofttech.microfinance.entityBeans.master.LoanImageEntity;
import com.infrasofttech.microfinance.entityBeans.master.holder.Cgt1HolderBean;
import com.infrasofttech.microfinance.servicesimpl.CGT1ServiceImpl;
import com.infrasofttech.microfinance.servicesimpl.LoanImageServiceImpl;

@RestController
@RequestMapping("/CustomerLoanImage")
public class LoanImageController {
	
	@Autowired
	LoanImageServiceImpl loanImageServiceImpl;

	@PostMapping(value = "/addCustomerLoanImage", produces = "application/json")
	public ResponseEntity<?>  addCgt1ListByHolder(@RequestBody List<LoanImageEntity> loanImageList){
		
		try {
			return loanImageServiceImpl.addLoanImageBuHolder(loanImageList);
		}catch(Exception e ) {
			
			return null;
		}
			
		
	}
	
	@PostMapping(value = "/getLoanImage", produces = "application/json")
	public ResponseEntity<?>  getLoanImage(@RequestBody LoanImageEntity loanImageList){
		
		try {
			return loanImageServiceImpl.getLoanByloanmrefnoandLoanTrefNo(loanImageList);
		}catch(Exception e ) {
			e.printStackTrace();
			return null;
		}
			
		
	}
	
	
	
	
}
