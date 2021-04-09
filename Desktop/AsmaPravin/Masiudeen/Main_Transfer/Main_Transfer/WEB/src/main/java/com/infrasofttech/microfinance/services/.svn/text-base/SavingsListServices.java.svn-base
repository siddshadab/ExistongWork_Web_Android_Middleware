package com.infrasofttech.microfinance.services;

import java.util.List;

import org.springframework.http.ResponseEntity;

import com.infrasofttech.microfinance.entityBeans.master.CustomerEntity;
import com.infrasofttech.microfinance.entityBeans.master.SavingsListEntity;
import com.infrasofttech.microfinance.entityBeans.master.SpeedoMeterEntity;

public interface SavingsListServices {

	
	public ResponseEntity<?> addList(List<SavingsListEntity> svng);

	public List<SavingsListEntity> isDataSynced(int  isDataSynced);
	public int updateSavingsErrorfromOmni(int mCustRefNo,String errorFromOmni) ;
	
	public int updateSavingsCustNo(int mcustmrefno,int mcustno) ;
	

	ResponseEntity<?> findByCreatedByAndLastSyncedTime(SavingsListEntity savingsListEntity);

	
}
