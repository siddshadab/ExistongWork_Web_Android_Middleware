package com.infrasofttech.microfinance.repository;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.infrasofttech.microfinance.entityBeans.master.CustomerEntity;
import com.infrasofttech.microfinance.entityBeans.master.LookupMasterEntity;
import com.infrasofttech.microfinance.entityBeans.master.MiniStatementEntity;
import com.infrasofttech.microfinance.entityBeans.master.SavingsListEntity;
import com.infrasofttech.microfinance.entityBeans.master.SystemParameterEntity;


@Repository
public interface MiniStatementRepository  extends JpaRepository<MiniStatementEntity, Long> {

	  @Query(value="SELECT * FROM  md009040 where mprdacctid=?1 AND mlbrcode= ?2 ",nativeQuery = true) 
	  List<MiniStatementEntity> findByProductAccIdAndLbrCode(String mprdacctid, int mlbrcode);
	 
}
