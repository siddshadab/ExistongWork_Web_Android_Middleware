package com.infrasofttech.microfinance.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;

import com.infrasofttech.microfinance.entityBeans.master.CustomerLoanEntity;
import com.infrasofttech.microfinance.entityBeans.master.LoanLevelMasterEntity;
import com.infrasofttech.microfinance.entityBeans.master.ProductEntity;

public interface LoanLevelRepository  extends JpaRepository<LoanLevelMasterEntity, Long> {
	
	
	
	@Query(value="SELECT  * FROM  loan_level_master  WITH (NOLOCK) where mprdcd = ?1 ",nativeQuery = true)
	List<LoanLevelMasterEntity> findByPrdCd(String mprdcd);
	
	@Query(value="SELECT  * FROM  loan_level_master  WITH (NOLOCK) where mprdcd = ?1 ",nativeQuery = true)
	LoanLevelMasterEntity findByProdCd(String mprdcd);
	
	@Modifying
	@Query(value="DELETE  FROM  loan_level_master where mrefno = ?1 ",nativeQuery = true)
	public void deleteByMrefNo(int mrefno);
	
	
	@Query(value="select * from loan_level_master where mrefno =?1", nativeQuery = true)
	public LoanLevelMasterEntity findRecByMrefNo(int mrefno);
	
	//multiple delete
	
	@Modifying
	@Query(value="Delete  FROM  loan_level_master where mrefno IN (?1) ",nativeQuery = true)
	public void deleteByBulk(List<Integer> mrefno);

	@Query(value="Select * from loan_level_master mrefno IN (?1) ",nativeQuery= true)
	public List<LoanLevelMasterEntity> getDataByLbrCode(List<Integer> mrefno);
}


