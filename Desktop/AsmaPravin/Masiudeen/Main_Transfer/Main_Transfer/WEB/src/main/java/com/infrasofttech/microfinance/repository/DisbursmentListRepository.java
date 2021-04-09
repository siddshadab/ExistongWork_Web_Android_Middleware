package com.infrasofttech.microfinance.repository;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.infrasofttech.microfinance.entityBeans.master.CustomerEntity;
import com.infrasofttech.microfinance.entityBeans.master.DisbursmentListEntity;
import com.infrasofttech.microfinance.entityBeans.master.LookupMasterEntity;
import com.infrasofttech.microfinance.entityBeans.master.SavingsListEntity;
import com.infrasofttech.microfinance.entityBeans.master.SystemParameterEntity;
import com.infrasofttech.microfinance.entityBeans.master.UserMasterEntity;


@Repository
public interface DisbursmentListRepository  extends JpaRepository<DisbursmentListEntity, Long> {


		
	  @Query(value="SELECT * FROM  md009243 where mcreatedby=?1 ",nativeQuery = true)
	  List<DisbursmentListEntity> findByCreatedby(String mcreatedby);
		 
	  @Query(
	  value="SELECT * FROM  md009243 where mcreatedby=?1 AND mcreateddt > ?2 OR mlastupdatedt > ?2",nativeQuery = true)
	  List<DisbursmentListEntity>findByCreatedbyAndDateTime(String mcreatedby,LocalDateTime lastsynsdate);
	  
	  

	 
}
