package com.infrasofttech.microfinance.services;

import java.util.List;

import org.springframework.http.ResponseEntity;

import com.infrasofttech.microfinance.entityBeans.master.CurrentLocationMasterEntity;
import com.infrasofttech.microfinance.entityBeans.master.CustomerLoanEntity;
import com.infrasofttech.microfinance.entityBeans.master.PathTrackerMasterEntity;

public interface CurrentLocationMasterService {

	
	public ResponseEntity<?> add(CurrentLocationMasterEntity currentLocationMasterEntity);
	public ResponseEntity<?> addPathTracker(PathTrackerMasterEntity pathTrackerMasterEntity);
}
