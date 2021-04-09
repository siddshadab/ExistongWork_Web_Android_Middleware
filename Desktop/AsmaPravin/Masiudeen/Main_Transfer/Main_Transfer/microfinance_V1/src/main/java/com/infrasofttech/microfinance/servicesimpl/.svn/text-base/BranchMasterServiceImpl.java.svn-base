package com.infrasofttech.microfinance.servicesimpl;



import java.util.ArrayList;
import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import com.infrasofttech.microfinance.entityBeans.master.BranchMasterEntity;
import com.infrasofttech.microfinance.entityBeans.master.CGT1Entity;
import com.infrasofttech.microfinance.repository.BranchMasterRepository;
import com.infrasofttech.microfinance.repository.CGT1Repository;
import com.infrasofttech.microfinance.services.BranchMasterService;


@Service
@Transactional
public class BranchMasterServiceImpl implements BranchMasterService {

	
	@Autowired
	BranchMasterRepository repo;
	
	
	@Override
	public ResponseEntity<?> getAllBranchMasterData() {
		try {
			List<BranchMasterEntity> branchMasterRepository=repo.findAll();
			if(branchMasterRepository.isEmpty()) 
				return ResponseEntity.notFound().build();
			return new ResponseEntity<List<BranchMasterEntity>>(branchMasterRepository,new HttpHeaders(),HttpStatus.OK);
		}catch(Exception e) {			
			return new ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY);
		}
	}

	@Override
	public ResponseEntity<?> getBranchMasterDataOnMlbrCd(int mlbrcd) {
		try {
			
			List<BranchMasterEntity> branchMasterEntityList = new ArrayList<BranchMasterEntity>();
			BranchMasterEntity branchMasterRepository=repo.findByMpbrcode(mlbrcd);
			branchMasterEntityList.add(branchMasterRepository);
			if(branchMasterEntityList.isEmpty()) 
				return ResponseEntity.notFound().build();
			return new ResponseEntity<List<BranchMasterEntity>>(branchMasterEntityList,new HttpHeaders(),HttpStatus.OK);
		}catch(Exception e) {			
			return new ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY);
		}
	}
	
	
	@Override
	public BranchMasterEntity getBranchMasterEntityDataOnMlbrCd(int mlbrcd) {
		try {
			BranchMasterEntity branchMasterRepository=repo.findByMpbrcode(mlbrcd);
		
			return branchMasterRepository;
		}catch(Exception e) {			
			return null;
		}
	}
	
}
