package com.infrasofttech.microfinance.services;

import java.util.List;

import org.springframework.http.ResponseEntity;

import com.infrasofttech.microfinance.entityBeans.master.BranchMasterEntity;
import com.infrasofttech.microfinance.entityBeans.master.holder.BranchMasterHolder;
import com.infrasofttech.microfinance.entityBeans.master.holder.DeleteBranchHolder;

public interface BranchMasterService {

	public ResponseEntity<?> getAllBranchMasterData();
	
	public ResponseEntity<?> getBranchMasterDataOnMlbrCd(int mlbrcd);
	
	public BranchMasterEntity getBranchMasterEntityDataOnMlbrCd(int mlbrcd);
	
	public ResponseEntity<?> addList(BranchMasterEntity branchMasterEntity);
	
	public ResponseEntity<?> updateBranch(BranchMasterEntity branchMasterEntity);
	
	public ResponseEntity<?> deleteBranch( DeleteBranchHolder deleteBranch );
	
	public ResponseEntity<?> getBranchCd();
	
	public ResponseEntity<?> findRecByLbrCode(BranchMasterEntity branchMasterEntity);
}
