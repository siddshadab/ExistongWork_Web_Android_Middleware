package com.infrasofttech.microfinance.repository;

import org.springframework.stereotype.Repository;

import com.infrasofttech.microfinance.entityBeans.master.CentersFoundationEntity;
import com.infrasofttech.microfinance.entityBeans.master.GroupsFoundationEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.http.ResponseEntity;

import java.lang.String;
import java.time.LocalDateTime;
import java.util.List;
import java.lang.Long;

@Repository
public interface GroupsFoundationsRepository extends JpaRepository<GroupsFoundationEntity, Long> {  

	// List<GroupsFoundationEntity> findByAgentUserName(String agentUserName);
	// @Query(value="SELECT * FROM groups_foundation where agent_user_name
	// =?1",nativeQuery = true)
	/*
	 * List<GroupsFoundationEntity> findByAgentUserName(String agentUserName);
	 * List<GroupsFoundationEntity> findByGroupNumberAndAgentUserName(Long
	 * groupnumber, String agentusername);
	 */ List<GroupsFoundationEntity> findByMcreatedby(String mcreatedby);
	 
	 @Query(value = "Select * from  mgd009011  WHERE mcreatedby = ?1  ",nativeQuery = true)
		List<GroupsFoundationEntity> findByMcreatedBy(String mcreatedby);
	 
	 @Query(value = "Select * from  mgd009011  WHERE mcreatedby = ?1  AND mlbrcode= ?2",nativeQuery = true)
		List<GroupsFoundationEntity> findByMcreatedByAndMlbrCode(String mcreatedby, int mLbrcode);
	 
	 @Modifying
	    @Query(value = "UPDATE mgd009011 SET mgroupid=?2, missynctocoresys=1 WHERE mrefno = ?1  ",nativeQuery = true)
	    int updateGroupsFoundation( int mrefno, int mgroupid);
	 
	 @Modifying
	    @Query(value="SELECT * FROM  mgd009011 where missynctocoresys =?1 AND mrefcenterid !=0 ",nativeQuery = true)
	    List<GroupsFoundationEntity> findDataByisDataSynced(int isdataSynced);
	 
	 @Modifying
	    @Query(value = "UPDATE mgd009011 SET merrormessage = ?2,mlastupdatedt =?3 ,missynctocoresys=2 WHERE mrefno = ?1  ",nativeQuery = true)
	    int updateGroupsErrorfromOmni( int mGroupRefNo, String updateErrorFromOmni,LocalDateTime updatedDt);
		
	 @Query(value="SELECT * FROM  mgd009011  WITH (NOLOCK) where trefno=?1 AND mcreatedby = ?2 AND mrefno =?3 AND missynctocoresys =?4 ",nativeQuery = true)
	 GroupsFoundationEntity findByTrefAndMcreatedByAndIsSynced(long groupNumberOfTab,String usrCode , int mrefno,int isdataSynced);
		//findBymcreated
	 
	 @Modifying
	    @Query(value = "UPDATE mgd009011 SET mcenterid = ?2, mlastupdatedt =?3  WHERE mrefno = ?1  ",nativeQuery = true)
	    int updateCenterInGroupDetails(int mrefno,int centerNumberOfCore,LocalDateTime updatedDateTime);



	 @Query(value = "Select * from  mgd009011  WHERE mrefno = ?1 ",nativeQuery = true)
		GroupsFoundationEntity findBymrefno(int mrefno);
	 
	 
	 

	 @Modifying
	    @Query(value = "UPDATE mgd009011 SET mgroupid=?2, missynctocoresys=1 , mcenterid = ?3 WHERE mrefno = ?1  ",nativeQuery = true)
	    int updateGroupsFoundationWithCenterID( int mrefno, int mgroupid,int mcenterid);
	 
}
