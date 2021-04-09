package com.infrasofttech.microfinance.services;

import org.springframework.http.ResponseEntity;
import java.util.List;

import com.infrasofttech.microfinance.entityBeans.master.CustomerLoanCPVBusinessRecordEntity;
import com.infrasofttech.microfinance.entityBeans.master.KycMasterEntity;

public interface CustomerLoanCPVBusinessRecordService {	
	

	public ResponseEntity<?> addList(List<CustomerLoanCPVBusinessRecordEntity> group);	

	public List<CustomerLoanCPVBusinessRecordEntity> isDataSynced(int  isDataSynced);
	
	public void updateMleadsIdfromMrefTref(String mleadsid, int mloanmrefno, int mloantrefno);
	
	ResponseEntity<?> findByCreatedByAndLastSyncedTime(CustomerLoanCPVBusinessRecordEntity cpvEntity);

}
