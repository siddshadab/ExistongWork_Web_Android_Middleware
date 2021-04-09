package com.infrasofttech.microfinance.servicesimpl;

import java.util.ArrayList;
import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import com.infrasofttech.microfinance.entityBeans.master.LoanLevelMasterEntity;
import com.infrasofttech.microfinance.entityBeans.master.ProductEntity;
import com.infrasofttech.microfinance.repository.LoanLevelRepository;
import com.infrasofttech.microfinance.repository.ProductRepository;
import com.infrasofttech.microfinance.services.LoanLevelService;
import com.infrasofttech.microfinance.services.ProductService;

@Service
@Transactional
public class LoanLevelServiceImpl implements LoanLevelService {

	
	@Autowired
	LoanLevelRepository loanlevelrepo;

	@Override
	public ResponseEntity<?> getLoanLevel() {
		
		
		try {
			List<LoanLevelMasterEntity> loanLevelList=loanlevelrepo.findAll();
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
	
	
	
}
