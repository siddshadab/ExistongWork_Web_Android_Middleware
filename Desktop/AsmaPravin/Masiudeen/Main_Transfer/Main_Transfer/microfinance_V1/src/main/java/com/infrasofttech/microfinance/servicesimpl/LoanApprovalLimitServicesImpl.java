package com.infrasofttech.microfinance.servicesimpl;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import com.infrasofttech.microfinance.entityBeans.CountriesEntity;
import com.infrasofttech.microfinance.entityBeans.master.InterestOffsetEntity;
import com.infrasofttech.microfinance.entityBeans.master.InterestSlabEntity;
import com.infrasofttech.microfinance.entityBeans.master.LoanApprovalLimitEntity;
import com.infrasofttech.microfinance.entityBeans.master.LoanCycleParameterPrimaryEntity;
import com.infrasofttech.microfinance.entityBeans.master.LoanCycleParameterSecondaryEntity;
import com.infrasofttech.microfinance.entityBeans.master.LookupMasterEntity;
import com.infrasofttech.microfinance.repository.InterestOffsetRepository;
import com.infrasofttech.microfinance.repository.InterestSlabRepository;
import com.infrasofttech.microfinance.repository.LoanApprovalLimitRepository;
import com.infrasofttech.microfinance.repository.LoanCycleParameterPrimaryRepository;
import com.infrasofttech.microfinance.repository.LoanCycleParameterSecondaryRepository;
import com.infrasofttech.microfinance.repository.LookupMasterRepository;
import com.infrasofttech.microfinance.services.InterestOffsetServices;
import com.infrasofttech.microfinance.services.InterestSlabServices;
import com.infrasofttech.microfinance.services.LoanApprovalLimitServices;
import com.infrasofttech.microfinance.services.LoanCycleParameterPrimaryServices;
import com.infrasofttech.microfinance.services.LoanCycleParameterSecondaryServices;
import com.infrasofttech.microfinance.services.LookupMasterServices;

@Transactional
@Service
public class LoanApprovalLimitServicesImpl implements LoanApprovalLimitServices{

	@Autowired
	LoanApprovalLimitRepository repo;




	@Override
	public ResponseEntity<?> getAllLoanApprovalLimitData() {
		try {
			
			return new ResponseEntity<Object>("",new HttpHeaders(),HttpStatus.OK);
		}catch(Exception e) {
			//logger.error("No Record Found."+e.getMessage());
			return new ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY);
		}
	}
	
	
	public ResponseEntity<?> getDataByMlbrCodeAndUSerCode(int lbrcd,String usercd,int mgrpcd){
		try {
			System.out.println(lbrcd);
			System.out.println(usercd);
			System.out.println(mgrpcd);
			List<LoanApprovalLimitEntity> dbEntity = repo.findByMlbrCodeAndUserCd(lbrcd,mgrpcd,usercd);
			
			System.out.println("Returning");
			if(null == dbEntity) {
				System.out.println("Null found in repository");
				return ResponseEntity.notFound().build();
				
			}
				
			System.out.println(dbEntity);
			return new ResponseEntity<Object>(dbEntity,new HttpHeaders(),HttpStatus.OK);
		}catch(Exception e) {
			
			//logger.error("No Record Found."+e.getMessage());
			return new ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY);
		}
	}
	
	
}
