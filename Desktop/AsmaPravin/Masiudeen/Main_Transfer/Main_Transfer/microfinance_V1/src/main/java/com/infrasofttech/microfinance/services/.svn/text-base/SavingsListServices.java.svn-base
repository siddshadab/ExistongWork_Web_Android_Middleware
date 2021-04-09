package com.infrasofttech.microfinance.services;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.http.ResponseEntity;

import com.infrasofttech.microfinance.entityBeans.master.CustomerEntity;
import com.infrasofttech.microfinance.entityBeans.master.SavingsListEntity;
import com.infrasofttech.microfinance.entityBeans.master.SpeedoMeterEntity;

public interface SavingsListServices {

	
	public ResponseEntity<?> addList(List<SavingsListEntity> svng);

	public List<SavingsListEntity> isDataSynced(int  isDataSynced);
	public int updateSavingsErrorfromOmni(int mCustRefNo,String errorFromOmni,LocalDateTime lastSynsdate) ;
	
	public int updateSavingsCustNo(int mcustmrefno,int mcustno) ;
	
	public int updateSavingsErrorfromOmni(int mCustRefNo,String errorFromOmni, int mretry) ;
	

	ResponseEntity<?> findByCreatedByAndLastSyncedTime(SavingsListEntity savingsListEntity);

	
}
