package com.infrasofttech.microfinance.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.infrasofttech.microfinance.entityBeans.CountriesEntity;
import com.infrasofttech.microfinance.entityBeans.StatesEntity;
import java.lang.Long;
import java.util.List;

@Repository
public interface StatesRepository extends JpaRepository<StatesEntity, Long>{
	
	//StatesEntity findByStatesID(Long statesid);
	
	/*
	 * List<StatesEntity> findByStatesID(String statesname); StatesEntity
	 * findByStatesID(Long statesid);
	 */

}
