package com.infrasofttech.microfinance.services;

import java.util.List;

import javax.validation.Valid;

import org.springframework.http.ResponseEntity;

import com.infrasofttech.microfinance.entityBeans.master.CreditBereauResultMasterEntity;
import com.infrasofttech.microfinance.entityBeans.master.CustomerCompositePrimaryEntity;
import com.infrasofttech.microfinance.entityBeans.master.CustomerFamilyDetailsEntity;
import com.infrasofttech.microfinance.entityBeans.master.CustomerLoanEntity;
import com.infrasofttech.microfinance.entityBeans.master.ProspectCompositePrimaryEntity;

public interface CreditBereauResultMasterService {
	
	
public ResponseEntity<?> getAllCreditBereauResultData();
	
	
	
	/*public int updateCustomerLoan(long loanNumberOfTab,String LoanNumberOfCore);*/

	public 	ResponseEntity<?> addList(List<CreditBereauResultMasterEntity> customer);
	
	public  ResponseEntity<?> getByAdhaarNoAndAgentUserName( long adhaarNo,String agentUserName);
	
	public  ResponseEntity<?> getByRoutedTo(String agentUserName);
	
	ResponseEntity<?> addResultDetails(@Valid CreditBereauResultMasterEntity entity,
			ProspectCompositePrimaryEntity prospectId);
	


}
