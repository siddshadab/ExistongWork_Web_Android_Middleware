package com.infrasofttech.microfinance.controller;

import java.util.ArrayList;
import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.infrasofttech.microfinance.entityBeans.master.BranchMasterEntity;
import com.infrasofttech.microfinance.entityBeans.master.UserMasterEntity;
import com.infrasofttech.microfinance.entityBeans.master.holder.DeleteBranchHolder;
import com.infrasofttech.microfinance.services.BranchMasterService;
import com.infrasofttech.microfinance.servicesimpl.BranchMasterServiceImpl;

@CrossOrigin(origins = "*", allowedHeaders = "*")
@RestController
@RequestMapping("/branchMaster")
public class BranchMasterController {

	
	@Autowired
	BranchMasterServiceImpl branchMasterServiceImpl;
	
	@Autowired
	BranchMasterService branchMasterService;
	
	
	@GetMapping(value = "/branchMasterAll", produces = "application/json")
	public ResponseEntity<?> getAllBranchMasterData(){
		return branchMasterServiceImpl.getAllBranchMasterData();
	}
	

	@PostMapping(value = "/branchMasterOnMpbrCode", produces = "application/json")
	public ResponseEntity<?>  getBrnMasterDataOnMlbrCd(@RequestBody BranchMasterEntity branchMasterEntity){
//		System.out.println(" branchMasterOnMpbrCode "+branchMasterServiceImpl.getBranchMasterDataOnMlbrCd(branchMasterEntity.getMpbrcode()).toString());
				return branchMasterServiceImpl.getBranchMasterDataOnMlbrCd(branchMasterEntity.getMpbrcode());
		
	}
	
	@PostMapping(value="/add" , produces="application/json")
	public ResponseEntity<?> addList(@RequestBody BranchMasterEntity branchMasterEntity){
		System.out.println("branchMasterEntityzxxxxxxxxxxxxxxxxxxxx"+branchMasterEntity);
		if(null!= branchMasterEntity)
			return branchMasterService.addList(branchMasterEntity);
		
		return null;
	}

	@GetMapping(value = "/getbranchCode", produces = "application/json")
	public ResponseEntity<?>  getBranchMasterDataOnMlbrCd(@RequestBody BranchMasterEntity branchMasterEntity){
		System.out.println("geting branch dataxxxxxxxxxxxx"+branchMasterEntity);	
		return branchMasterServiceImpl.getBranchMasterDataOnMlbrCd(branchMasterEntity.getMpbrcode());
		
	}
	
	@PostMapping(value="/update" , produces="application/json")
	public ResponseEntity<?> updateBranch(@RequestBody BranchMasterEntity branchMasterEntity){
		System.out.println("branchMasterEntityzxxxxxxxxxxxxxxxxxxxx"+branchMasterEntity);
		if(null!= branchMasterEntity)
			return branchMasterService.updateBranch(branchMasterEntity);
		
		return null;
	}
	
	@Transactional
	@PostMapping(value="/delete" , produces="application/json")
	public ResponseEntity<?> deleteBranch(@RequestBody DeleteBranchHolder deleteBranch ){
		
		System.out.println("branchMasterEntityzxxxxxxxxxxxxxxxxxxxx"+deleteBranch);
		if(null!= deleteBranch)
			return branchMasterService.deleteBranch(deleteBranch);
		return null;
		
	}
	
	@GetMapping(value="/getBranchCdDesc", produces="application/json")
	public ResponseEntity<?> getBranchCd(){
		return branchMasterService.getBranchCd();
	}
	
	@PostMapping(value="/findRecByLbrCode",produces= "application/json")
	public ResponseEntity<?> findRecByUsrCd(@RequestBody BranchMasterEntity branchMasterEntity){
		return branchMasterService.findRecByLbrCode(branchMasterEntity);
	}
}
