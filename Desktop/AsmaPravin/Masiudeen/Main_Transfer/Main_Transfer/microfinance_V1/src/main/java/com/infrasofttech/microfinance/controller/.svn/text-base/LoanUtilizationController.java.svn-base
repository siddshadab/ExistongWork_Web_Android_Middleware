package com.infrasofttech.microfinance.controller;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.infrasofttech.microfinance.entityBeans.master.LoanUtilizationEntity;
import com.infrasofttech.microfinance.entityBeans.master.CustomerEntity;
import com.infrasofttech.microfinance.servicesimpl.LoanUtilizationServiceImpl;
import com.infrasofttech.microfinance.servicesimpl.ProductServiceImpl;
import com.infrasofttech.microfinance.servicesimpl.TransactionModeServiceImpl;

@RestController
@RequestMapping("/LoanUtilizationController")
public class LoanUtilizationController {
	
	@Autowired
	LoanUtilizationServiceImpl LoanUtilizationService;
	
	@PostMapping(value = "/add", produces = "application/json")
	public ResponseEntity<?>  addlist(@RequestBody List<LoanUtilizationEntity> loanUtilList){
		if(null != loanUtilList)
			return LoanUtilizationService.addList(loanUtilList);
		return null;
	}

}
