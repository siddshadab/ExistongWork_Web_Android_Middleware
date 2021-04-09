package com.infrasofttech.microfinance.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.infrasofttech.microfinance.entityBeans.master.CGT1Entity;

public interface CGT1Repository extends JpaRepository<CGT1Entity, Long> {
	
	List<CGT1Entity> findByLoanmrefnoAndLoantrefno(int loanmrefno, int loantrefno);
	// findb

}
