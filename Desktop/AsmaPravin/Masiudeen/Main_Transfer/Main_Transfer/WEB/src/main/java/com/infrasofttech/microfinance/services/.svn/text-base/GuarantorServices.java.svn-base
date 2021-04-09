package com.infrasofttech.microfinance.services;

import java.math.BigDecimal;
import java.util.List;

import org.springframework.http.ResponseEntity;

import com.infrasofttech.microfinance.entityBeans.master.GuarantorEntity;


public interface GuarantorServices {

	public ResponseEntity<?> addList(List<GuarantorEntity> grntr);

	public List<BigDecimal> isDataSynced(int  isDataSynced);
	
	public void updateMleadsIdfromMrefTref(String mleadsid, int mloanmrefno, int mloantrefno);
	
	public List<GuarantorEntity> findDataByMloanRefoJoin(BigDecimal mloanmrefno);
	
	ResponseEntity<?> findByCreatedByAndLastSyncedTime(GuarantorEntity guarantorEntity);
	
//	public ResponseEntity<?> add1List(GuarantorEntity grntr);
}
