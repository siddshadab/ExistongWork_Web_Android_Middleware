package com.infrasofttech.microfinance.services;

import java.util.List;

import org.springframework.http.ResponseEntity;
import com.infrasofttech.microfinance.entityBeans.master.DisbursedListEntity;

public interface DisbursedListService {

	public ResponseEntity<?> getAllCustomerLoanData();
	
	public 	ResponseEntity<?> addList(List<DisbursedListEntity> disbursedList);
	
	public ResponseEntity<?> findByCreatedByOrRouteTo(String createdby,String routeto);
	
	public ResponseEntity<?> findByCreatedByOrMrouteToAndLastSyncedTime(DisbursedListEntity disbursedEntity);	

	public int updateErrorfromOmni(int mrefno,String errorFromOmni,int mRetry);
	

	public int updateStatus(List<DisbursedListEntity> disbursedList);
	
	public List<DisbursedListEntity> isDataSynced(int  isDataSynced, int disbursmentStatus);
	
	
	
	
}
