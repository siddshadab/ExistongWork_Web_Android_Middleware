package com.infrasofttech.microfinance.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.infrasofttech.microfinance.entityBeans.master.CurrentLocationMasterEntity;


@Repository
public interface CurrentLocationMasterRepository extends JpaRepository<CurrentLocationMasterEntity, String> {

	@Query(value="SELECT * FROM  currentlocation_master  where mreportinguser =?1 ",nativeQuery = true)
	List<CurrentLocationMasterEntity> findBySuperUser(String superUuser);    
    


}
