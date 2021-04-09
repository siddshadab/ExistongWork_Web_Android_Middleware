package com.infrasofttech.microfinance.services;



import org.springframework.http.ResponseEntity;

import java.time.LocalDateTime;
import java.util.List;

import com.infrasofttech.microfinance.entityBeans.master.CentersFoundationEntity;
import com.infrasofttech.microfinance.entityBeans.master.GroupsFoundationEntity;


public interface GroupsFoundationService {
	
	
	public ResponseEntity<?> getAllUsersData();

	public ResponseEntity<?> addList(List<GroupsFoundationEntity> group);	

	/*
	 * public ResponseEntity<?> getDataUserByAgentUserName(String agentUserName);
	 */
	public ResponseEntity<?> getDataByCreatedBy(String mCreatedBy);
	
	public ResponseEntity<?> getDataByMcreatedByAndMlbrCode(String mCreatedBy, int mLbrcode);
	
	public List<GroupsFoundationEntity> isDataSynced(int  isDataSynced);

	//public ResponseEntity<?>  getDataByGroupNumberAndCenterCodeAndAgentUserName(Long groupNumber,Long centerCode,String agentUserName);
	public int updateGroupsErrorfromOmni(int mGroupRefNo, String errorFromOmni);
	
	public GroupsFoundationEntity findByTrefAndMcreatedByAndIsSynced(int trefNo, String mCreatedBy, int mrefno,
			int isSynced);
	
	public int updateCenterInGroupDetails(int mrefno,int centerNumberOfCore,LocalDateTime updatedDateTime);

}
