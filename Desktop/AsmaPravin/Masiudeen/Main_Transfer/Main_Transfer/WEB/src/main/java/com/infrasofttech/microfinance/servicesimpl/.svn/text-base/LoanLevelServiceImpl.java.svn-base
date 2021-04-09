package com.infrasofttech.microfinance.servicesimpl;

import java.util.ArrayList;
import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import com.infrasofttech.microfinance.entityBeans.master.LoanLevelMasterEntity;
import com.infrasofttech.microfinance.entityBeans.master.holder.LoanLevelHolder;
import com.infrasofttech.microfinance.repository.LoanLevelRepository;
import com.infrasofttech.microfinance.services.LoanLevelService;

@Service
@Transactional
public class LoanLevelServiceImpl implements LoanLevelService {

	
	@Autowired
	LoanLevelRepository loanlevelrepo;

	@Override
	public ResponseEntity<?> getLoanLevel() {
		
		
		try {
			List<LoanLevelMasterEntity> loanLevelList=loanlevelrepo.findAll(Sort.by(Sort.Direction.DESC,"mrefno"));
			if(loanLevelList.isEmpty()) 
				return ResponseEntity.notFound().build();
			return new ResponseEntity<List<LoanLevelMasterEntity>>(loanLevelList,new HttpHeaders(),HttpStatus.OK);
		}catch(Exception e) {
			//logger.error("No Record Found."+e.getMessage());
			return new ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY);
		}
		// TODO Auto-generated method stub
	}

	@Override
	public List<LoanLevelMasterEntity> findByPrdCd(String prdCd) {
		try {
			List<LoanLevelMasterEntity> loanLevelList=loanlevelrepo.findByPrdCd(prdCd);
				return loanLevelList;
		}catch(Exception e) {
			//logger.error("No Record Found."+e.getMessage());
			return new ArrayList<LoanLevelMasterEntity>();
		}
	}
	
	@Transactional
	@Override
	public ResponseEntity<?> addList(LoanLevelMasterEntity loanMasterEntity) {
		LoanLevelMasterEntity loanEnt = loanlevelrepo.findByProdCd(loanMasterEntity.getMprdcd());
		LoanLevelHolder hld = new LoanLevelHolder();
		try {			
			if(loanEnt == null) {	
			
				loanlevelrepo.save(loanMasterEntity);
				hld.setMerror(200);
				hld.setMerrormsg("Record Saved Successfully");
				return new ResponseEntity<Object>(hld,new HttpHeaders(),HttpStatus.OK);	
			}
			else {
				hld.setMerror(409);
				hld.setMerrormsg("Record Alredy Exists");
				return new ResponseEntity<Object>(hld,new HttpHeaders(),HttpStatus.OK);
			}
		} catch (Exception e) {
			
			return new ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY);
		}
		
		
	}

	@Override
	@Transactional
	public ResponseEntity<?> updateByMref(LoanLevelMasterEntity loanMasterEntity) {
			try {
				if(loanMasterEntity !=null) {
				LoanLevelHolder hld =new LoanLevelHolder();
				
					loanlevelrepo.save(loanMasterEntity);
					
					hld.setMerror(200);
					hld.setMerrormsg("Record Update Sucessfully");
					
					return new ResponseEntity<Object>(hld,new HttpHeaders(),HttpStatus.OK);
			}		
		
		  } catch (Exception e) { 
			 e.printStackTrace();
		}		 
			 return new ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY); 
	}

	@Override
	public ResponseEntity<?> deleteByMref(List<Integer> mrefno) {		
	
		LoanLevelHolder hld =new LoanLevelHolder();
		try {			
				hld.setMerror(200);
				hld.setMerrormsg("Record Deleted Sucessfully");
				loanlevelrepo.deleteByBulk(mrefno);
				return new ResponseEntity<Object>(hld,new HttpHeaders(),HttpStatus.OK);
		
		} catch (Exception e) {			
			e.printStackTrace();
		}
		return new ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY);	
	}

	@Override
	public ResponseEntity<?> findByRecByMref(LoanLevelMasterEntity loanEntity) {
		
			LoanLevelMasterEntity loanEnt = loanlevelrepo.findRecByMrefNo(loanEntity.getMrefno());
			LoanLevelHolder hld = new LoanLevelHolder();
			try {
			if(loanEnt == null) {
				hld.setMerror(0);
				hld.setMerrormsg("null");
				return new ResponseEntity<Object> (hld,new HttpHeaders(),HttpStatus.OK);
			}
			else {
				hld.setMerror(200);
				hld.setMerrormsg("Mref Number Already Exists");
				return new ResponseEntity<Object> (hld,new HttpHeaders(),HttpStatus.OK);
			}
		
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return new ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY);
		}
			
		
	}
	
	
	
}
