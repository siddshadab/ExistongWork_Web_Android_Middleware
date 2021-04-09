package com.infrasofttech.microfinance.repository;

import java.time.LocalDateTime;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.infrasofttech.microfinance.entityBeans.master.LicenseMasterEntity;

public interface LicenseMasterRepository extends JpaRepository<LicenseMasterEntity , Long>  {
	
	
	
	@Query(value="SELECT  top 1 * FROM  license_master  WITH (NOLOCK) ",nativeQuery = true)
	LicenseMasterEntity  findLicenseKey();
	
	
	
	@Query(value="SELECT  CURRENT_TIMESTAMP ",nativeQuery = true)
	LocalDateTime  getCurrentTime();
	
	
	

}
