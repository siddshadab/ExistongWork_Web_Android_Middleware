package com.infrasofttech.microfinance.repository;

import java.time.LocalDateTime;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.infrasofttech.microfinance.entityBeans.master.TDOffsetInterestSlabEntity;


@Repository
public interface TDOffsetInterestSlabRepository  extends JpaRepository<TDOffsetInterestSlabEntity, Long> {

	@Query(value="Select * from md009027 where maccttype=?1 and meffdate=?2 and mlbrcode=?3 and mprdcd=?4 and msrno=?5",nativeQuery=true)
	TDOffsetInterestSlabEntity findByPrmEntity(int maccttype,LocalDateTime meffdate,int mlbrcode,String mprdcd,int msrno);
	
	@Query(value="DELETE from md009027 where maccttype=?1 and meffdate=?2 and mlbrcode=?3 and mprdcd=?4 and msrno=?5",nativeQuery=true)
	public void deleteByPrm(int maccttype,LocalDateTime meffdate,int mlbrcode,String mprdcd,int msrno);
}
