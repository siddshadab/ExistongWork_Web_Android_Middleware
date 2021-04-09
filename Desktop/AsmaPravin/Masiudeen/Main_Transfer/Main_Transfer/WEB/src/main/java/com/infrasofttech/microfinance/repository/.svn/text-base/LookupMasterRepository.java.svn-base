package com.infrasofttech.microfinance.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.infrasofttech.microfinance.entityBeans.master.LookupMasterEntity;


@Repository
public interface LookupMasterRepository  extends JpaRepository<LookupMasterEntity, Long> {
	
	 @Query(value="SELECT * FROM  md001002 where mcodetype=?1",nativeQuery =true) 
	 List<LookupMasterEntity> findByMcodeType(int mcodetype);

	 @Query(value="SELECT * FROM  md001002 where mcode=?1 and mcodetype=?2",nativeQuery =true) 
	 LookupMasterEntity findByMcode(String mcode,int mcodetype);
	 
	 @Modifying
	 @Query(value="Delete From md001002 where mcode=?1 AND mcodetype=?2",nativeQuery=true)
	 void deleteByMcode(String mcode,int mcodetype);
	 
	 @Query(value="SELECT * FROM  md001002 ORDER BY mcodetype",nativeQuery =true) 
	 List<LookupMasterEntity> getSpecificLookup();
	 
	 @Query(value="SELECT mcode,mcodetype FROM  md001002",nativeQuery =true) 
	 List<Object> findByCode();
	 
	 @Query(value="select * from md001002 where mcodetype=?1",nativeQuery= true)
	 List<LookupMasterEntity> findByCodeType(int mcodetype);
	 
	 
	 //multiple delete
	 
	 @Modifying
	 @Query(value="Delete  FROM  md001002  where  mcode IN (?1) and mcodetype IN (?2) ",nativeQuery = true)
	 void deleteByBulk(String mcode,int mcodetype);
}
