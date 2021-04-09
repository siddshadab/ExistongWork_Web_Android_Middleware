package com.infrasofttech.microfinance.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.infrasofttech.microfinance.entityBeans.master.ProspectCreationEntity;
import com.infrasofttech.microfinance.entityBeans.master.CustomerEntity;
import com.infrasofttech.microfinance.entityBeans.master.ProspectCompositePrimaryEntity;
import java.lang.String;
import java.time.LocalDateTime;



@Repository
public interface ProspectCreationRepository extends JpaRepository<ProspectCreationEntity, Long> { 

	//ProspectCreationEntity findByCompositeProspectId(ProspectCompositePrimaryEntity compositeprospectid);	

	@Query(value="SELECT * FROM  md970555 WITH (NOLOCK) where mcreatedby =?1",nativeQuery = true)
	List<ProspectCreationEntity> findByAgentUserName(String agentUserName);
	@Query(value="SELECT * FROM  md970555 WITH (NOLOCK) where routedto =?1 AND is_data_synced = ?2 AND prospect_status = 4",nativeQuery = true)
	List<ProspectCreationEntity> findByRoutedToAndIsDatSynced(String routedTo, int isDataSynced);
	@Query(value="SELECT * FROM  md970555 WITH (NOLOCK) where routedto =?1 AND is_data_synced = ?2 AND (prospect_status = 5 OR prospect_status = 6)",nativeQuery = true)
	List<ProspectCreationEntity> findDataNocChecked(String routedTo, int isDataSynced); 
	@Query(value="SELECT * FROM  md970555 WITH (NOLOCK) where segmentIdentifier  =?1,mcreatedby = ?2",nativeQuery = true)
	List<ProspectCreationEntity> findByisDatasyncedToCoreSystem(long segmentIdentifier,String agentUserName);
	
	//List<ProspectCreationEntity> findByRoutedTo(String routedto);
	
	@Modifying
	@Query(value="UPDATE md970555  SET prospect_status = ?3 ,updated_by = ?4 WHERE adhaar_No = ?1 AND mcreatedby = ?2",nativeQuery = true)
    int updateProspect(Long adhaarNo,String agentUserName,int prospectStatus,String routedTo);
	@Modifying
	@Query(value ="UPDATE md970555  SET is_data_synced = ?3  WHERE adhaar_No = ?1 AND agent_user_name = ?2",nativeQuery = true)
    int updateIsDataSynced(Long adhaarNo,String agentUserName,int isDataSynced);
	
	
	
	

	@Query(value="SELECT * FROM  md970555 WITH (NOLOCK) where (mcreatedby  =?2 OR mroutedto = ?2) AND (mlastupdatedt > ?1 OR mlastsynsdate > ?1 )",nativeQuery = true)
	//@Query(value="SELECT * FROM  md970555 where  mroutedto = ?2",nativeQuery = true)
	List<ProspectCreationEntity> getProspectList(LocalDateTime lastSynsTime,String userName);
	
	
	
	@Query(value="SELECT * FROM  md970555 WITH (NOLOCK) where mcreatedby  =?1 OR mroutedto = ?1",nativeQuery = true)
	List<ProspectCreationEntity> getAllProspectData(String userName);
	
	
	@Modifying
	@Query(value ="UPDATE md970555  SET  mprospectstatus = ?2 ,mlastupdateby = ?3 ,mlastupdatedt = ?4 , mlastsynsdate = ?5 WHERE mrefno =  ?1",nativeQuery = true)
	int updateNocCheckResult(int mrefno,  int mprospectstatus, String mlastupdateby,LocalDateTime mlastUpdatedt,LocalDateTime lastSynsDate);

	@Query(value="SELECT * FROM  md970555 WITH (NOLOCK) where mcreatedby  =?1 ",nativeQuery = true)
	List<ProspectCreationEntity> getProspectFromCreatedBy(String userName);
	
	
	@Query(value="SELECT * FROM  md970555  WITH (NOLOCK) where mcreatedby  =?1  AND mProspectstatus= ?2",nativeQuery = true)
	List<ProspectCreationEntity> getprspctfrmcrtdByAndprspctstatus(String userName, int prospectStatus);
	
	@Query(value="SELECT * FROM  md970555 WITH (NOLOCK) where mcreatedby  =?1 AND  (mlastupdatedt > ?2 OR mlastsynsdate > ?2 )",nativeQuery = true)
	List<ProspectCreationEntity> getProspectFromCreatedByAndLastSyncedDate(String userName, LocalDateTime lastSyncedDate);
	
	
	@Query(value="SELECT * FROM  md970555 WITH (NOLOCK) where mcreatedby  =?1  AND mProspectstatus= ?2  AND  (mlastupdatedt > ?3 OR mlastsynsdate > ?3 )",nativeQuery = true)
	List<ProspectCreationEntity> getprspctfrmcrtdByAndprspctstatusAndLastSyncedDate(String userName, int prospectStatus, LocalDateTime lastSyncedDate);
	
	
	
}
