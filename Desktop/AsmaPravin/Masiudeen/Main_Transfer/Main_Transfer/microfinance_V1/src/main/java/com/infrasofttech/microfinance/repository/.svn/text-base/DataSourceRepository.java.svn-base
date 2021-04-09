package com.infrasofttech.microfinance.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.infrasofttech.microfinance.entityBeans.master.BranchMasterEntity;
import com.infrasofttech.microfinance.entityBeans.master.DataSourceMasterEntity;

public interface DataSourceRepository extends JpaRepository<DataSourceMasterEntity, Long> { 

	@Query(value="SELECT * FROM  data_source_master  where msystemid =?1 ",nativeQuery = true)
	DataSourceMasterEntity findByMsystemid(String msystemid);
	
}
