package com.infrasofttech.microfinance.services;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.http.ResponseEntity;

import com.infrasofttech.microfinance.entityBeans.master.CustomerLoanEntity;
import com.infrasofttech.microfinance.entityBeans.master.DailyLoanCollectedEntity;

public interface DailyLoanCollectedServices {

	public 	ResponseEntity<?> addList(List<DailyLoanCollectedEntity> dailyLoanCollected);
	

	public List<DailyLoanCollectedEntity> isDataSyncedToCoreSys(int isDataSynced) ;
	//ResponseEntity<?> findByCreatedByAndLbr(DailyLoanCollectedEntity dailyLoanCollectedEntity);
	
	public void updateStatus(List<DailyLoanCollectedEntity> dailyLoanCollectedEntity);
	
	public int dedupCheck(DailyLoanCollectedEntity dedupcheckEntity);
	
	public List<DailyLoanCollectedEntity> getDuplicateLoanCollections(String mprdacctid, LocalDateTime mcreateddt) ;

	
}
