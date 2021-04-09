package com.infrasofttech.microfinance.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.infrasofttech.microfinance.entityBeans.master.CGT1Entity;
import com.infrasofttech.microfinance.entityBeans.master.ImageMasterEntity;
import com.infrasofttech.microfinance.entityBeans.master.LoanImageEntity;

public interface LoanImageRepository extends JpaRepository<LoanImageEntity, Long> {
	

	@Query(value="SELECT * FROM  loan_image_entity WITH (NOLOCK) where  mloanmrefno = ?1 AND mloantrefno = ?2 ",nativeQuery = true)
	List<LoanImageEntity> getLoanImagesByLoanmrefNo(int loanmrefno,int mloantrefno);
	
	
	

}
