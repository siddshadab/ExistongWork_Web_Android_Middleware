package com.infrasofttech.microfinance.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.infrasofttech.microfinance.entityBeans.master.LoanApprovalLimitEntity;

import com.infrasofttech.microfinance.entityBeans.master.holder.LoanApprovalLimitHolder;
import com.infrasofttech.microfinance.services.LoanApprovalLimitServices;
import com.infrasofttech.microfinance.servicesimpl.LoanApprovalLimitServicesImpl;

@CrossOrigin(origins = "*", allowedHeaders = "*")
@RestController
@RequestMapping("/LoanApprovalLimitController")
public class LoanApprovalLimitController {
	
	
	
	@Autowired 
	LoanApprovalLimitServicesImpl loanApprovalLimitServicesImpl;

	@Autowired
	LoanApprovalLimitServices loanApprovalLimitService;
	
	@GetMapping(value = "/getAllLoanApprovalLimit", produces = "application/json")
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

	  @GetMapping(value = "/getAll", produces = "application/json")
		public ResponseEntity<Object>  getAllData() {
			return loanApprovalLimitService.getAllData();
		}
	  
	  @PostMapping(value = "/add", produces={ MediaType.APPLICATION_JSON_UTF8_VALUE })
		public ResponseEntity<?>  AddLoanLimit(@RequestBody LoanApprovalLimitHolder loanHolder) {
			if(loanHolder!=null) {
				return loanApprovalLimitService.AddLoanLimit(loanHolder);
			}
			return null;
		  
		}
	  
	  @PostMapping(value = "/update", produces={ MediaType.APPLICATION_JSON_UTF8_VALUE })
		public ResponseEntity<?>  updateLoanLimit(@RequestBody LoanApprovalLimitHolder loanHolder) {
			if(loanHolder!=null) {
				return loanApprovalLimitService.updateLoanLimit(loanHolder);
			}
			return null;
		  
		}
	  
	  @PostMapping(value = "/delete", produces={ MediaType.APPLICATION_JSON_UTF8_VALUE })
		public ResponseEntity<?>  deleteLoanLimit(@RequestBody LoanApprovalLimitHolder loanHolder) {
			System.out.println("laonAprroval"+loanHolder);
		  if(loanHolder!=null) {
				return loanApprovalLimitService.deleteLoanLimit(loanHolder.getCode());
			}
			return null;
		  
		}
	  
	  @PostMapping(value = "/findRecByPrmKey", produces={ MediaType.APPLICATION_JSON_UTF8_VALUE })
	  public ResponseEntity<?> findRecByPrmKey(@RequestBody LoanApprovalLimitHolder loanHolder){
		  if(loanHolder !=null) {
			  return loanApprovalLimitService.findRecByPrmKey(loanHolder);
		  }
		  return null;
	  }
}
