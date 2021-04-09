package com.infrasofttech.microfinance.services;

import java.util.List;

import org.springframework.http.ResponseEntity;

import com.infrasofttech.microfinance.entityBeans.master.holder.LoanCyclePrimarySecondaryHolder;

public interface LoanCyclePrimarySecondaryService {
	
	ResponseEntity<?> getLoanCycle();
	
	ResponseEntity<?> addLoanCycle(LoanCyclePrimarySecondaryHolder loanCycle);
	
	ResponseEntity<?> editLoanCyclePrimary(LoanCyclePrimarySecondaryHolder loanCycle);
	
	ResponseEntity<?> editLoanCycleSecondary(LoanCyclePrimarySecondaryHolder loanCycle);
	
	ResponseEntity<?> deleteLoanCycle(List<LoanCyclePrimarySecondaryHolder> code);	

	ResponseEntity<?> addLoanCycleSecondary(LoanCyclePrimarySecondaryHolder loanCycle);
	
	ResponseEntity<?> deleteLoanCycleData(LoanCyclePrimarySecondaryHolder loanCycle);
}
