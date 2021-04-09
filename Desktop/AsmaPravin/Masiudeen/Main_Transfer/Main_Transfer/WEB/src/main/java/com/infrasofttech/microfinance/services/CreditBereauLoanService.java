package com.infrasofttech.microfinance.services;

import java.util.List;

import javax.validation.Valid;

import org.springframework.http.ResponseEntity;

import com.infrasofttech.microfinance.entityBeans.master.CreditBereauLoanEntity;
import com.infrasofttech.microfinance.entityBeans.master.CustomerCompositePrimaryEntity;
import com.infrasofttech.microfinance.entityBeans.master.CustomerFamilyDetailsEntity;
import com.infrasofttech.microfinance.entityBeans.master.CustomerLoanEntity;
import com.infrasofttech.microfinance.entityBeans.master.ProspectCompositePrimaryEntity;
import com.infrasofttech.microfinance.entityBeans.master.ProspectCompositePrimaryEntityAdhaar;

public interface CreditBereauLoanService {
	
	public ResponseEntity<?> getAllCreditBereauLoanData();
	
	
	
	/*public int updateCustomerLoan(long loanNumberOfTab,String LoanNumberOfCore);*/

	public 	ResponseEntity<?> addList(CreditBereauLoanEntity prospect);
	
	public  ResponseEntity<?> getByAdhaarNoAndAgentUserName( long adhaarNo,String agentUserName);
	
	
	ResponseEntity<?> addLoanDetails(@Valid List<CreditBereauLoanEntity> entity,
			ProspectCompositePrimaryEntity prospectId);

}
