package com.infrasofttech.microfinance.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.infrasofttech.microfinance.entityBeans.master.CGT1Entity;
import com.infrasofttech.microfinance.entityBeans.master.CustomerLoanCashFlowEntity;
import com.infrasofttech.microfinance.entityBeans.master.SavingsListEntity;
import com.infrasofttech.microfinance.services.CustomerLoanCashFlowServices;
import com.infrasofttech.microfinance.servicesimpl.CustomerLoanCashFlowServiceImpl;

@RestController
@RequestMapping("/CustomerLoanCashFlow")
public class CustomerLoanCashFlowController {
	
	
	@Autowired
	CustomerLoanCashFlowServiceImpl  customerLoanCashFlowServiceImpl ;
	
	@Autowired
	CustomerLoanCashFlowServices customerCashFlowServices;
	
	@PostMapping(value = "/add", produces = "application/json")
	public ResponseEntity<?>  addlist(@RequestBody List<CustomerLoanCashFlowEntity> cashFlowEntity){
		System.out.println(cashFlowEntity);
		if(null != cashFlowEntity)
			return customerLoanCashFlowServiceImpl.addList(cashFlowEntity);
		return null;
	}
	

	
	 @PostMapping(value = "/getData/",produces = "application/json") 
	 public ResponseEntity<?> getCashflowList(@RequestBody CustomerLoanCashFlowEntity  cashFlowEntity){
		 
	  if(null != cashFlowEntity.getMcreatedby()) {
		  
		  System.out.println(cashFlowEntity.getMlastsynsdate()!=null?  cashFlowEntity.getMlastsynsdate():"printng yha aa gya");
	    return customerCashFlowServices.findByCreatedByAndLastSyncedTime(cashFlowEntity);
	  } 
	  return null; 
	  }
	
	


}
