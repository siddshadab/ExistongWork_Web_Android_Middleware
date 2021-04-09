package com.infrasofttech.microfinance.services;

import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.http.ResponseEntity;
import java.util.List;

import com.infrasofttech.microfinance.entityBeans.master.GroupsFoundationEntity;
import com.infrasofttech.microfinance.entityBeans.master.SocialAndEnvironmentalEntity;
import com.infrasofttech.microfinance.entityBeans.master.TradeAndNeighbourRefCheckEntity;


public interface SocialAndEnvironmentalService {	
	

	public ResponseEntity<?> addList(List<SocialAndEnvironmentalEntity> group);	
	
	public List<SocialAndEnvironmentalEntity> isDataSynced(int  isDataSynced);
	
	public void updateMleadsIdfromMrefTref(String mleadsid, int mloanmrefno, int mloantrefno);

	ResponseEntity<?> findByCreatedByAndLastSyncedTime(SocialAndEnvironmentalEntity socialEnvEntity);
}
