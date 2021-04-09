package com.infrasofttech.microfinance.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.infrasofttech.microfinance.entityBeans.master.GRTEntity;

public interface GRTRepository extends JpaRepository<GRTEntity, Long> {

	List<GRTEntity> findByLoanmrefnoAndLoantrefno(int loanmrefno, int loantrefno);
}
