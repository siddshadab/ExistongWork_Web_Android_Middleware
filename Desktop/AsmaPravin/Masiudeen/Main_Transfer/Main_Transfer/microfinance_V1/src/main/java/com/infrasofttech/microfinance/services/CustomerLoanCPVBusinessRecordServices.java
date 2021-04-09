package com.infrasofttech.microfinance.services;

import java.util.List;

import org.springframework.http.ResponseEntity;

import com.infrasofttech.microfinance.entityBeans.master.CustomerLoanCashFlowEntity;

public interface CustomerLoanCPVBusinessRecordServices {
	
public ResponseEntity<?> getAllCashFlowData();
	
	public ResponseEntity<?> addList(List<CustomerLoanCashFlowEntity> cashFlowEntity);
	public List<CustomerLoanCashFlowEntity> isDataSynced(int isDataSyncToCoreSys);
	
	public void updatemisSynctocoreSys(int misSyncToCoreSys,int mrefno);
	
	public void updateMerrorMessage(int misSyncToCoreSys,int mrefno,String merrormessage);
}
