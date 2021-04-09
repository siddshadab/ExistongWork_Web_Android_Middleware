package com.infrasofttech.microfinance.services;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import java.util.List;
import com.infrasofttech.microfinance.entityBeans.master.CentersFoundationEntity;
import com.infrasofttech.microfinance.entityBeans.master.CustomerEntity;
import com.infrasofttech.microfinance.entityBeans.master.SavingsListEntity;


public interface CentersFoundationService {
	
	
	public ResponseEntity<?> getAllUsersData();

	public ResponseEntity<?> addList(List<CentersFoundationEntity> centerList);

	/*
	 * public ResponseEntity<?> getDataUserByAgentUserName(String agentUserName);
	 */
	/*
	 * public ResponseEntity<?> getDataUserByAgentUserNameAndIdAndCenterName(String
	 * centername, String agentUserName, Long id);
	 */
	public ResponseEntity<?> getDataByCreatedBy(String mCreatedBy);

	public ResponseEntity<?> getDataUserByMcenterNameAndMrefno(String mcentername, int mrefno);
	
	public ResponseEntity<?> getDataByMcreatedByAndMlbrCode(String mCreatedBy, int mLbrcode);
	
	public List<CentersFoundationEntity> isDataSynced(int  isDataSynced);

	public int updateCentersErrorfromOmni(int mCenterRefNo, String errorFromOmni);
	
	public CentersFoundationEntity findByTrefAndMcreatedByAndIsSynced(int trefNo, String mCreatedBy, int mrefno,
			int isSynced);
}
