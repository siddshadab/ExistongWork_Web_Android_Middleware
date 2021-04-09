package com.infrasofttech.microfinance.services;

import java.util.List;

import org.springframework.http.ResponseEntity;

import com.infrasofttech.microfinance.entityBeans.master.CGT1Entity;
import com.infrasofttech.microfinance.entityBeans.master.CustomerLoanCashFlowEntity;
import com.infrasofttech.microfinance.entityBeans.master.SavingsListEntity;

public interface CustomerLoanCashFlowServices {

	public ResponseEntity<?> getAllCashFlowData();
	
	public ResponseEntity<?> addList(List<CustomerLoanCashFlowEntity> cashFlowEntity);
	
	public List<CustomerLoanCashFlowEntity> isDataSynced(int isDataSyncToCoreSys);
	
	public void updatemisSynctocoreSys(int misSyncToCoreSys,int mrefno,String merrormessage);
	
	public void updateMerrorMessage(int misSyncToCoreSys,int mrefno,String merrormessage);
	
	
	public void updateMleadsIdfromMrefTref(String mleadsid,int mloanmrefno,int mloantrefno);
	
	ResponseEntity<?> findByCreatedByAndLastSyncedTime(CustomerLoanCashFlowEntity cashFlowEntity);

}
