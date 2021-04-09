package com.infrasofttech.microfinance.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.infrasofttech.microfinance.entityBeans.master.LoanApprovalLimitEntity;
import com.infrasofttech.microfinance.servicesimpl.LoanApprovalLimitServicesImpl;


@RestController
@RequestMapping("/LoanApprovalLimitController")
public class LoanApprovalLimitController {
	
	
	
	@Autowired 
	LoanApprovalLimitServicesImpl loanApprovalLimitServicesImpl;


	
	@GetMapping(value = "/getAllLoanApprovalLimit/", produces = "application/json")
	public ResponseEntity<?>  getAllInsertOffsetData() {
		return loanApprovalLimitServicesImpl.getAllLoanApprovalLimitData();
	}
	
	  @PostMapping(value = "/getLoanApprovalLimitByMlbrCodeAndUserCd", produces =
			  "application/json")	 
			public ResponseEntity<?>  getDataByMlbrCode(@RequestBody LoanApprovalLimitEntity loanApprovalLimit){
		  System.out.println(" yerdd  "+ loanApprovalLimit.getLoanApprovalLimitCompositeEntity().getmlbrcode()+
							loanApprovalLimit.getLoanApprovalLimitCompositeEntity().getmusercd()+loanApprovalLimit.getLoanApprovalLimitCompositeEntity().getmgrpcd());
				if(null != loanApprovalLimit) {
					return loanApprovalLimitServicesImpl.getDataByMlbrCodeAndUSerCode(loanApprovalLimit.getLoanApprovalLimitCompositeEntity().getmlbrcode(),
							loanApprovalLimit.getLoanApprovalLimitCompositeEntity().getmusercd(),loanApprovalLimit.getLoanApprovalLimitCompositeEntity().getmgrpcd());
				}
				return null;
			}

}
