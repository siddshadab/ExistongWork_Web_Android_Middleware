package com.infrasofttech.microfinance.servicesimpl;



import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import com.infrasofttech.microfinance.entityBeans.master.BranchMasterEntity;
import com.infrasofttech.microfinance.entityBeans.master.LookupMasterEntity;
import com.infrasofttech.microfinance.entityBeans.master.holder.BranchMasterHolder;
import com.infrasofttech.microfinance.entityBeans.master.holder.DeleteBranchHolder;
import com.infrasofttech.microfinance.repository.BranchMasterRepository;
import com.infrasofttech.microfinance.repository.BranchMasterRepository.BrnachMasterHolderInterface;
import com.infrasofttech.microfinance.services.BranchMasterService;


@Service
@Transactional
public class BranchMasterServiceImpl implements BranchMasterService {

	
	@Autowired
	BranchMasterRepository repo;
	
	
	@Override
	public ResponseEntity<?> getAllBranchMasterData() {
		try {
			List<BranchMasterEntity> branchMasterRepository=repo.findAll(Sort.by(Sort.Direction.DESC,"mformatndt"));
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

	@Override
	public ResponseEntity<?> addList(BranchMasterEntity branchMasterEntity) {
		BranchMasterEntity branchEnt = repo.findByMpbrcode(branchMasterEntity.getMpbrcode());		

		DeleteBranchHolder hld = new DeleteBranchHolder();
		try {
			if(branchEnt == null) {	
				repo.save(branchMasterEntity);
				hld.setMerror(200);
				hld.setMerrormsg("Record Added Successfully");
				
				return new ResponseEntity<Object>(hld,new HttpHeaders(),HttpStatus.CREATED);									
			}else {				
				hld.setMerror(200);
				hld.setMerrormsg("Record Already Exists");
				return new ResponseEntity<Object>(hld,HttpStatus.CONFLICT);		
			}			
		} catch (Exception e) {			
			return new ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY);
		}
	}

	@Override
	public ResponseEntity<?> updateBranch(BranchMasterEntity branchMasterEntity) {
		
		DeleteBranchHolder hld = new DeleteBranchHolder();
		
		try {
			hld.setMerror(200);
			hld.setMerrormsg("Record Updated Successfully");
			repo.save(branchMasterEntity);
			return new ResponseEntity<Object>(hld,new HttpHeaders(),HttpStatus.OK);
		
		  } catch (Exception e) { 
			  return new ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY); 
		}	
	}

	@Transactional
	@Override
	public ResponseEntity<?> deleteBranch( DeleteBranchHolder deleteBranch ){
		
			try {
				DeleteBranchHolder hld = new DeleteBranchHolder();

				if(deleteBranch!=null) {				
					hld.setMerror(200);
					hld.setMerrormsg("Record Deleted Successfully");
					repo.deleteByBulk(deleteBranch.getMpbrcode());
					return new ResponseEntity<Object>(hld,new HttpHeaders(),HttpStatus.OK);
				} 
				
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			return new ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY); 
		}		


	@Override
	public ResponseEntity<?> getBranchCd() {		
				
		List<BrnachMasterHolderInterface> branchObj = repo.findByBranchCd();	
	
		try {					
			if(branchObj==null)
				return ResponseEntity.notFound().build(); 				
			return new ResponseEntity<Object>(branchObj,HttpStatus.OK);				
		} catch (Exception e) {				
			e.printStackTrace();
			return new ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY);
		}			
			
	}

	@Override
	public ResponseEntity<?> findRecByLbrCode(BranchMasterEntity branchMasterEntity) {

		try {
			BranchMasterEntity brnEnt = repo.findByMpbrcode(branchMasterEntity.getMpbrcode());
			DeleteBranchHolder hld = new DeleteBranchHolder();
			if(brnEnt == null) {
				hld.setMerror(0);
				hld.setMerrormsg("null");
				return new ResponseEntity<Object>(hld,new HttpHeaders(),HttpStatus.OK);			
			}else {
				hld.setMerror(200);
				hld.setMerrormsg("Branch Code Already Exists");
				return new ResponseEntity<Object>(hld,new HttpHeaders(),HttpStatus.OK);
			}
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return new ResponseEntity<>(new HttpHeaders(),HttpStatus.UNPROCESSABLE_ENTITY);
		}

	}
	
}
