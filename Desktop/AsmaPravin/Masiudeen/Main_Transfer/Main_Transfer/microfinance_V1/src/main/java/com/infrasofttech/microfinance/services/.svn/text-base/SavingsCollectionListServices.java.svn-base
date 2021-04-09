package com.infrasofttech.microfinance.services;

import java.util.List;

import org.springframework.http.ResponseEntity;

import com.infrasofttech.microfinance.entityBeans.master.SavingsListEntity;
import com.infrasofttech.microfinance.entityBeans.master.SavingsCollectionListEntity;

public interface SavingsCollectionListServices {

	public ResponseEntity<?> addList(List<SavingsCollectionListEntity> svng);
	public int updateSavingsCollectionErrorfromOmni(int mCustRefNo, String errorFromOmni);
	public List<SavingsCollectionListEntity> isDataSynced(int isDataSynced, int mmoduletype, String mcashflow);
	public void updateStatus(List<SavingsCollectionListEntity> listBean);
	int updateSavingsCollectionPrdAcctid(int msvngaccmrefno, String prdacctid);

	
}
