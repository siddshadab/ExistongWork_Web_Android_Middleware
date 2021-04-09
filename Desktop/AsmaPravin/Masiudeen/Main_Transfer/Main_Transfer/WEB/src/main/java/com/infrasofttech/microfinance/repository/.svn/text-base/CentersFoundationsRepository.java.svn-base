package com.infrasofttech.microfinance.repository;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.infrasofttech.microfinance.entityBeans.master.CentersFoundationEntity;

@Repository
public interface CentersFoundationsRepository extends JpaRepository<CentersFoundationEntity, Long> {

	/*
	 * List<CentersFoundationEntity> findByCenterNameAndAgentUserNameAndId(String
	 * centername,String agentUserName,Long id); List<CentersFoundationEntity>
	 * findByAgentUserName(String agentUserName);
	 */

	List<CentersFoundationEntity> findByMrefno(int mrefno);

	@Query(value = "Select * from  md001006  WHERE mcreatedby = ?1  ", nativeQuery = true)
	List<CentersFoundationEntity> findByMcreatedBy(String mcreatedby);

	List<CentersFoundationEntity> findByMcenternameAndMrefno(String mcentername, int mrefno);

	@Query(value = "Select * from  md001006  WHERE mcreatedby = ?1  AND mlbrcode= ?2", nativeQuery = true)
	List<CentersFoundationEntity> findByMcreatedByAndMlbrCode(String mcreatedby, int mLbrcode);

	@Modifying
	@Query(value = "SELECT * FROM  md001006 where missynctocoresys =?1", nativeQuery = true)
	List<CentersFoundationEntity> findDataByisDataSynced(int isdataSynced);

	@Modifying
	@Query(value = "UPDATE md001006 SET mcenterid=?2, missynctocoresys=1 WHERE mrefno = ?1  ", nativeQuery = true)
	int updateCentersFoundation(int mrefno, int mcenterid);

	@Modifying
	@Query(value = "UPDATE md001006 SET merrormessage = ?2,mlastupdatedt =?3  WHERE mrefno = ?1  ", nativeQuery = true)
	int updateCentersErrorfromOmni(int mCenterRefNo, String updateErrorFromOmni, LocalDateTime updatedDt);

	@Query(value = "SELECT * FROM  md001006  WITH (NOLOCK) where trefno=?1 AND mcreatedby = ?2 AND mrefno =?3 AND missynctocoresys =?4 ", nativeQuery = true)
	CentersFoundationEntity findByTrefAndMcreatedByAndIsSynced(long centerNumberOfTab, String usrCode, int mrefno,
			int isdataSynced);
	// findBymcreated

}
