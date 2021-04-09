package com.infrasofttech.microfinance.services;

import org.springframework.http.ResponseEntity;
import java.util.List;
import com.infrasofttech.microfinance.entityBeans.master.DeviationFormEntity;
import com.infrasofttech.microfinance.entityBeans.master.TradeAndNeighbourRefCheckEntity;

public interface DeviationFormService {	

	public ResponseEntity<?> addList(List<DeviationFormEntity> group);	

	public List<DeviationFormEntity> isDataSynced(int  isDataSynced);
	
	public void updateMleadsIdfromMrefTref(String mleadsid, int mloanmrefno, int mloantrefno);

	ResponseEntity<?> findByCreatedByAndLastSyncedTime(DeviationFormEntity deviationEntity);
}
