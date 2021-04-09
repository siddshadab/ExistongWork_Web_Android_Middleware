package com.infrasofttech.microfinance.services;

import java.util.List;

import org.springframework.http.ResponseEntity;

import com.infrasofttech.microfinance.entityBeans.master.TDReceiptsEntity;

public interface TDReceiptsServices {
	
	public ResponseEntity<?> addList(List<TDReceiptsEntity> svng);

	public List<TDReceiptsEntity> isDataSynced(int  isDataSynced);
	public int updateTDReceiptsErrorfromOmni(int mCustRefNo,String errorFromOmni) ;

	ResponseEntity<?> findByCreatedByAndLastSyncedTime(TDReceiptsEntity tDReceiptsEntity);

}
