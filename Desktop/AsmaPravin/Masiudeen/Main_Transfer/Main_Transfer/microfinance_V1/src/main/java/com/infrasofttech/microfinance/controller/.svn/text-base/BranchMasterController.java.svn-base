package com.infrasofttech.microfinance.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.infrasofttech.microfinance.entityBeans.master.BranchMasterEntity;
import com.infrasofttech.microfinance.entityBeans.master.CGT1Entity;
import com.infrasofttech.microfinance.entityBeans.master.holder.Cgt1HolderBean;
import com.infrasofttech.microfinance.servicesimpl.BranchMasterServiceImpl;
import com.infrasofttech.microfinance.servicesimpl.CGT1ServiceImpl;


@RestController
@RequestMapping("/branchMaster")
public class BranchMasterController {

	
	@Autowired
	BranchMasterServiceImpl branchMasterServiceImpl;
	
	
	@GetMapping(value = "/branchMasterAll", produces = "application/json")
	public ResponseEntity<?> getAllBranchMasterData(){
		return branchMasterServiceImpl.getAllBranchMasterData();
	}
	

	@PostMapping(value = "/branchMasterOnMpbrCode", produces = "application/json")
	public ResponseEntity<?>  getBranchMasterDataOnMlbrCd(@RequestBody BranchMasterEntity branchMasterEntity){
//		/System.out.println(" branchMasterOnMpbrCode "+branchMasterServiceImpl.getBranchMasterDataOnMlbrCd(branchMasterEntity.getMpbrcode()).toString());
				return branchMasterServiceImpl.getBranchMasterDataOnMlbrCd(branchMasterEntity.getMpbrcode());
		
	}

	
}
