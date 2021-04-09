package com.infrasofttech.microfinance.services;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.http.ResponseEntity;
import com.infrasofttech.microfinance.entityBeans.master.DisbursedListEntity;

public interface DisbursedListService {

	public ResponseEntity<?> getAllCustomerLoanData();
	
	public 	ResponseEntity<List<DisbursedListEntity>> addList(List<DisbursedListEntity> disbursedList);
	
	public ResponseEntity<?> findByCreatedByOrRouteTo(String createdby,LocalDateTime lastUpdateDt);
	
	public ResponseEntity<?> findByCreatedByOrMrouteToAndLastSyncedTime(DisbursedListEntity disbursedEntity);	

	public int updateErrorfromOmni(int mrefno,String errorFromOmni,int mRetry);
	

	public int updateStatus(List<DisbursedListEntity> disbursedList);
	
	public List<DisbursedListEntity> isDataSynced(int  isDataSynced, int disbursmentStatus);
	
	
	public DisbursedListEntity finfByMleadsid(String mleadsid);
	
	public DisbursedListEntity findByMrefno(int mrefno);
	public int updateStatus(DisbursedListEntity disbursedList) ;
	
	
	
	
}
