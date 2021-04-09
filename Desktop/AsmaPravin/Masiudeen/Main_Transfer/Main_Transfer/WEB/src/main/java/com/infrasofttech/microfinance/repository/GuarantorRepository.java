package com.infrasofttech.microfinance.repository;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.infrasofttech.microfinance.entityBeans.master.GuarantorEntity;


@Repository
public interface GuarantorRepository  extends JpaRepository<GuarantorEntity, Long> {

	@Modifying
    @Query(value="SELECT DISTINCT mloanmrefno FROM md045038 WHERE missynctocoresys = ?1 AND mloanmrefno <> 0 ",nativeQuery = true)
    List<BigDecimal> findDataByisDataSynced(int dataSync);
	
	@Modifying
    @Query(value = "UPDATE md045038 SET missynctocoresys=1 WHERE mloanmrefno = ?1  ",nativeQuery = true)
    int updateStatus(int mloanmrefno);
	
	@Modifying
    @Query(value = "UPDATE md045038 SET missynctocoresys=2 WHERE mloanmrefno = ?1  ",nativeQuery = true)
    int updateErrorStatus( int mloanmrefno);
	
	@Modifying
	@Query(value = "UPDATE md045038 SET mleadsid= ?1 , mlastupdatedt = ?4 WHERE mloanmrefno = ?2 AND mloantrefno = ?3  ",nativeQuery = true)
	int updateLeadsIdFromLoanMrefTref( String mleadsId,int mloanmrefno,int mloantrefno,LocalDateTime mlastUpdatDt);
	
	@Modifying
    @Query(value = "UPDATE md045038 SET missynctocoresys=1 , mleadsid= ?2 WHERE mloanmrefno = ?1  ",nativeQuery = true)
    int updateStatusAndLeadid( int mloanmrefno,String mleadsId);
	
	
	@Modifying
    @Query(value="SELECT a.mleadsid as mleads, * FROM md045038 a , mD045011 b WHERE a.mloanmrefno = b.mrefno AND b.mleadsid <> ''  AND a.mloanmrefno = ?1 ",nativeQuery = true)
    List<GuarantorEntity> findDataByMloanRefoJoin(BigDecimal mloanmrefno);
     	
	@Query(value="SELECT * FROM  md045038  WITH (NOLOCK) where mcreatedby=?1 AND mlastupdatedt > ?2",nativeQuery = true)
	List<GuarantorEntity> findByCreatedbyAndDateTime(String mcreatedby,LocalDateTime lastsynsdate);
	
	@Query(value="SELECT  * FROM  md045038  WITH (NOLOCK) where mcreatedby=?1 order BY mlastupdatedt  desc ",nativeQuery = true)
	List<GuarantorEntity> findByCreatedby(String mcreatedby);
}
