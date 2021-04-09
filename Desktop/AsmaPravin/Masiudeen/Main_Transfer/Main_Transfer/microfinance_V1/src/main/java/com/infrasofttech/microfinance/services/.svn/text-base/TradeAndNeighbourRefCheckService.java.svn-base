package com.infrasofttech.microfinance.services;

import org.springframework.http.ResponseEntity;
import java.util.List;

import com.infrasofttech.microfinance.entityBeans.master.CustomerLoanCPVBusinessRecordEntity;
import com.infrasofttech.microfinance.entityBeans.master.SocialAndEnvironmentalEntity;
import com.infrasofttech.microfinance.entityBeans.master.TradeAndNeighbourRefCheckEntity;

public interface TradeAndNeighbourRefCheckService {	
	

	public ResponseEntity<?> addList(List<TradeAndNeighbourRefCheckEntity> group);	

	public List<TradeAndNeighbourRefCheckEntity> isDataSynced(int  isDataSynced);

	public void updateMleadsIdfromMrefTref(String mleadsid, int mloanmrefno, int mloantrefno);
	
	ResponseEntity<?> findByCreatedByAndLastSyncedTime(TradeAndNeighbourRefCheckEntity trcNrcEntity);

}
