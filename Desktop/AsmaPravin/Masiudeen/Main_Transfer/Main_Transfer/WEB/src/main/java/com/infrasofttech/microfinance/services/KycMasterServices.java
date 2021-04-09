package com.infrasofttech.microfinance.services;

import java.util.List;

import org.springframework.http.ResponseEntity;

import com.infrasofttech.microfinance.entityBeans.master.KycMasterEntity;
import com.infrasofttech.microfinance.entityBeans.master.SavingsListEntity;

public interface KycMasterServices {

	public ResponseEntity<?> getAllKycMasterData();

	public ResponseEntity<?> addList(List<KycMasterEntity> kycMasterEntity);

	public List<KycMasterEntity> isDataSynced(int isDataSyncToCoreSys);

	public void updatemisSynctocoreSys(int misSyncToCoreSys, int mrefno);

	public void updateMerrorMessage(int misSyncToCoreSys, int mrefno, String merrormessage);
	
	ResponseEntity<?> findByCreatedByAndLastSyncedTime(KycMasterEntity kycMasterEntity);
	
	public void updateMleadsIdfromMrefTref(String mleadsid,int mloanmrefno,int mloantrefno);
}
