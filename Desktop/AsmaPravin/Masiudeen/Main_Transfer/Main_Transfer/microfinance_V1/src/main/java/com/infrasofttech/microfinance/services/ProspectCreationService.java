package com.infrasofttech.microfinance.services;

import java.time.LocalDateTime;
import java.util.List;
import org.springframework.http.ResponseEntity;

import com.infrasofttech.microfinance.entityBeans.master.ProspectCreationEntity;
import com.infrasofttech.microfinance.entityBeans.master.holder.ProspectHolderBean;


public interface ProspectCreationService {
	
	
	public ResponseEntity<?> getAllProspectData();

	ResponseEntity<?> addList(List<ProspectCreationEntity> prospect);
	ResponseEntity<?> addProspectListByHolder(List<ProspectHolderBean> prospectList);
	
	/*public List<ProspectCreationEntity> getListProspectList(LocalDateTime lastUpdateDt,String agentName);*/

	ResponseEntity<?> addProspectCheckedResult(List<ProspectHolderBean> prospectList);
	public ResponseEntity<?> getProspect(LocalDateTime lastUpdateDt, String agentName);


}
