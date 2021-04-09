package com.infrasofttech.microfinance.repository;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;

import com.infrasofttech.microfinance.entityBeans.master.SocialAndEnvironmentalEntity;

public interface SocialAndEnvironmentalRepository extends JpaRepository<SocialAndEnvironmentalEntity, Long> {
	
	@Modifying
    @Query(value="SELECT * FROM  md045802 where missynctocoresys =?1 AND mloanmrefno != 0 ",nativeQuery = true)
    List<SocialAndEnvironmentalEntity> findDataByisDataSynced(int isdataSynced);
	
	@Modifying
    @Query(value = "UPDATE md045802 SET missynctocoresys=1 WHERE mrefno = ?1  ",nativeQuery = true)
    int updateStatus(int mrefno);
	
	@Modifying
    @Query(value = "UPDATE md045802 SET missynctocoresys=2 , merrormessage = ?2 WHERE mrefno = ?1  ",nativeQuery = true)
    int updateErrorStatus( int mrefno, String merrormessage);
	
	@Modifying
	@Query(value = "UPDATE md045802 SET mleadsid= ?1 , mlastupdatedt = ?4 WHERE mloanmrefno = ?2 AND mloantrefno = ?3  ",nativeQuery = true)
	int updateLeadsIdFromLoanMrefTref( String mleadsId,int mloanmrefno,int mloantrefno,LocalDateTime mlastUpdatDt);
	
	@Modifying
    @Query(value = "UPDATE md045802 SET missynctocoresys=1 , mleadsid= ?2 WHERE mrefno = ?1  ",nativeQuery = true)
    int updateStatusAndLeadid( int mrefno,String mleadsId);
	
	@Query(value="SELECT * FROM  md045802  WITH (NOLOCK) where mcreatedby=?1  AND mlastupdatedt > ?2",nativeQuery = true)
	List<SocialAndEnvironmentalEntity> findByCreatedbyAndDateTime(String mcreatedby,LocalDateTime lastsynsdate);
	
	@Query(value="SELECT  * FROM  md045802  WITH (NOLOCK) where mcreatedby=?1 order BY mlastupdatedt  desc",nativeQuery = true)
	List<SocialAndEnvironmentalEntity> findByCreatedby(String mcreatedby);

}
