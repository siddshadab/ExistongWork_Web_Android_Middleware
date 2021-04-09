package com.infrasofttech.microfinance.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.infrasofttech.microfinance.entityBeans.DistrictsEntity;
import com.infrasofttech.microfinance.entityBeans.SubDistrictsEntity;

public interface SubDistrictsRepository extends JpaRepository<SubDistrictsEntity, Long> {
	
	/*
	 * List<SubDistrictsEntity> findBySubDistrictsID(String subDistrictsname);
	 * SubDistrictsEntity findBySubDistrictsID(Long subDistrictsid);
	 */

}
