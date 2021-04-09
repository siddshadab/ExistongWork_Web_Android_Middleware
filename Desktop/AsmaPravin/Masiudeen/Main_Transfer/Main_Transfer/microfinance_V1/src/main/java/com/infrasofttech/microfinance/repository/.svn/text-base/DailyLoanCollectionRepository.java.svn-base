package com.infrasofttech.microfinance.repository;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.infrasofttech.microfinance.entityBeans.master.CustomerEntity;
import com.infrasofttech.microfinance.entityBeans.master.DailyLoanCollectionEntity;
import com.infrasofttech.microfinance.entityBeans.master.LookupMasterEntity;
import com.infrasofttech.microfinance.entityBeans.master.SystemParameterEntity;


@Repository
public interface DailyLoanCollectionRepository  extends JpaRepository<DailyLoanCollectionEntity, Long> {

	
	//@Query(value="SELECT * FROM  focollectionsheet where mlbrcode=?2 AND mcreatedby = ?1 AND mcreateddt =?3 AND mlastupdatedt=?3",nativeQuery = true)	
	@Query(value="SELECT * FROM  focollectionsheet where mlbrcode=?2 AND mcreatedby = ?1",nativeQuery = true)
	  List<DailyLoanCollectionEntity> findByCreatedByAndLbr(String getMcreatedby,int getMlbrcode,LocalDateTime updatedDtOrCreatedDt);
	
}
