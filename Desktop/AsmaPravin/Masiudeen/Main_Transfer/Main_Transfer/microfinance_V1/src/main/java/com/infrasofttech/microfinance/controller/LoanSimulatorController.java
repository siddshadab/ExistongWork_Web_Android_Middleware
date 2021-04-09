package com.infrasofttech.microfinance.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.infrasofttech.microfinance.entityBeans.master.GRTEntity;
import com.infrasofttech.microfinance.entityBeans.master.holder.CIFSavingAuthHolder;
import com.infrasofttech.microfinance.entityBeans.master.holder.LoanSimulatorHolder;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.servicesImpl.LoanSimulatorServiceImpl;

@RestController
@RequestMapping("/LoanSimulator")
public class LoanSimulatorController {

	@Autowired
	LoanSimulatorServiceImpl loanRepaymentServiceImpl ;
	
	@PostMapping(value = "/getLoanSimulatorDetails", produces = "application/json")
	public ResponseEntity<?>  getLoanSimulatorDetails(@RequestBody LoanSimulatorHolder loanSimObj){
		if(null != loanSimObj) {
			try {
				//return loanRepaymentServiceImpl.getLoanSimulatorDetails(null);	
				return new ResponseEntity<List<LoanSimulatorHolder>>(loanRepaymentServiceImpl.getLoanSimulatorDetails(loanSimObj),new HttpHeaders(),HttpStatus.OK);
			}catch(Exception e) {
				return new  ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY);
			}
			
		}
			
		return null;
	}
}
