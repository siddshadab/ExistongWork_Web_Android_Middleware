package com.infrasofttech.microfinance.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.infrasofttech.microfinance.entityBeans.master.SystemParameterEntity;


@Repository
public interface SystemParameterRepository  extends JpaRepository<SystemParameterEntity, Long> {

	
	@Query(value = "Select * from  md001004  WHERE mcode= ?1 and mlbrcode = 0",nativeQuery = true)
	SystemParameterEntity findByCode(String mcode);
	

	
}
