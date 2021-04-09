package com.infrasofttech.microfinance.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.infrasofttech.microfinance.entityBeans.master.TDOffsetInterestSlabEntity;
import com.infrasofttech.microfinance.entityBeans.master.TDParameterEntity;

public interface TDParameterRepository extends JpaRepository<TDParameterEntity, Long>  {

	
}
