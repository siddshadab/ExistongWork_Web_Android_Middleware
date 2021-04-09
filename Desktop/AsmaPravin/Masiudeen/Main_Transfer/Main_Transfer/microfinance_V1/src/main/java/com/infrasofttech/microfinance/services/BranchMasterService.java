package com.infrasofttech.microfinance.services;

import java.util.List;

import org.springframework.http.ResponseEntity;

import com.infrasofttech.microfinance.entityBeans.master.BranchMasterEntity;
import com.infrasofttech.microfinance.entityBeans.master.CGT1Entity;
import com.infrasofttech.microfinance.entityBeans.master.holder.Cgt1HolderBean;

public interface BranchMasterService {

	public ResponseEntity<?> getAllBranchMasterData();
	
	public ResponseEntity<?> getBranchMasterDataOnMlbrCd(int mlbrcd);
	
	public BranchMasterEntity getBranchMasterEntityDataOnMlbrCd(int mlbrcd);
}
