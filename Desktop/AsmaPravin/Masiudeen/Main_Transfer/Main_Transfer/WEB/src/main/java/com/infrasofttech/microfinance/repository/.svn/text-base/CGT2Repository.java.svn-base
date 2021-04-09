package com.infrasofttech.microfinance.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.infrasofttech.microfinance.entityBeans.master.CGT2Entity;

public interface CGT2Repository extends JpaRepository<CGT2Entity, Long> {
	List<CGT2Entity> findByLoanmrefnoAndLoantrefno(int loanmrefno, int loantrefno);

}
