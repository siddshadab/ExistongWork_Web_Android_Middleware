package com.infrasofttech.microfinance.services;

import java.util.List;

import org.springframework.http.ResponseEntity;

import com.infrasofttech.microfinance.entityBeans.master.LoanApprovalLimitCompositeEntity;
import com.infrasofttech.microfinance.entityBeans.master.holder.LoanApprovalLimitHolder;

public interface LoanApprovalLimitServices {

	public ResponseEntity<?> getAllLoanApprovalLimitData() ;

	public ResponseEntity<Object> getAllData();
	
	public ResponseEntity<?> AddLoanLimit(LoanApprovalLimitHolder loanHolder);
	
	public ResponseEntity<?> updateLoanLimit(LoanApprovalLimitHolder loanHolder);
	
	public ResponseEntity<?> deleteLoanLimit(List<LoanApprovalLimitCompositeEntity> code);
	
	public ResponseEntity<?> findRecByPrmKey(LoanApprovalLimitHolder loanHolder);
}
