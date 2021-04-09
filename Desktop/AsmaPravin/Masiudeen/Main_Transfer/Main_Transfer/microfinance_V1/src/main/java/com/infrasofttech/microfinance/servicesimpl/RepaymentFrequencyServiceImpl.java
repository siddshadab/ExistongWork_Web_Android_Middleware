package com.infrasofttech.microfinance.servicesimpl;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import com.infrasofttech.microfinance.entityBeans.master.RepaymentFrequencyEntity;
import com.infrasofttech.microfinance.entityBeans.master.TransactionModeEntity;
import com.infrasofttech.microfinance.repository.RepaymentFrequencyRepository;
import com.infrasofttech.microfinance.services.RepaymentFrequencyService;



@Service
@Transactional
public class RepaymentFrequencyServiceImpl implements RepaymentFrequencyService {

	@Autowired
	RepaymentFrequencyRepository repo;
	
	
	@Override
	public ResponseEntity<?> getAllRepaymentFrequencyData() {
		try {
			List<RepaymentFrequencyEntity> repaymentFrequencyList=repo.findAll();
			if(repaymentFrequencyList.isEmpty()) 
				return ResponseEntity.notFound().build();
			return new ResponseEntity<List<RepaymentFrequencyEntity>>(repaymentFrequencyList,new HttpHeaders(),HttpStatus.OK);
		}catch(Exception e) {
			//logger.error("No Record Found."+e.getMessage());
			return new ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY);
		}
	}

}
