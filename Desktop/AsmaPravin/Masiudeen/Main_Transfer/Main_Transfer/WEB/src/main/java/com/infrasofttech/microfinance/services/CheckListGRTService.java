package com.infrasofttech.microfinance.services;

import java.util.List;

import org.springframework.http.ResponseEntity;

import com.infrasofttech.microfinance.entityBeans.master.CheckListGRTEntity;

public interface CheckListGRTService {
	
	public ResponseEntity<?> getAllCheckListGRTData();
	
	public ResponseEntity<?> addList(List<CheckListGRTEntity> checkList);

}
