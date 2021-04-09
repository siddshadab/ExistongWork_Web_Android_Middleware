package com.infrasofttech.microfinance.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.infrasofttech.microfinance.entityBeans.master.BranchMasterEntity;
import com.infrasofttech.microfinance.entityBeans.master.CGT1Entity;
import com.infrasofttech.microfinance.entityBeans.master.CustomerEntity;

public interface BranchMasterRepository extends JpaRepository<BranchMasterEntity, Long> {
	
	
	@Query(value="SELECT * FROM  md001003  where mpbrcode =?1 ",nativeQuery = true)
	BranchMasterEntity findByMpbrcode(int mpbrcode);
	
	
	@Query(value=" SELECT count(distinct(mpbrcode)) FROM  md001003   ",nativeQuery = true)
	int findDistinctLbrCodeCount();
	
}
