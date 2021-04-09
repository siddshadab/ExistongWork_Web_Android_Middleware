package com.infrasofttech.microfinance.servicesimpl;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import com.infrasofttech.microfinance.entityBeans.master.LoanCycleParameterSecondaryEntity;
import com.infrasofttech.microfinance.entityBeans.master.LoanCycleWiseLimitEntity;
import com.infrasofttech.microfinance.repository.LoanCycleWiseLimitRepository;
import com.infrasofttech.microfinance.services.LoanCycleWiseLimitService;


@Service
@Transactional
public class LoanCycleWiseLimitServiceImpl implements LoanCycleWiseLimitService {

	@Autowired
	LoanCycleWiseLimitRepository loanCycleLimitRepo;
	
	@Override
	public ResponseEntity<?> getLoanLimts() {
		// TODO Auto-generated method stub
		try {
			List<LoanCycleWiseLimitEntity> dbEntity = loanCycleLimitRepo.getLoanCycleLimit();
			if(null == dbEntity)
				return ResponseEntity.notFound().build();
			return new ResponseEntity<Object>(dbEntity,new HttpHeaders(),HttpStatus.OK);
		}catch(Exception e) {
			//logger.error("No Record Found."+e.getMessage());
			return new ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY);
		}
		
	}

}
