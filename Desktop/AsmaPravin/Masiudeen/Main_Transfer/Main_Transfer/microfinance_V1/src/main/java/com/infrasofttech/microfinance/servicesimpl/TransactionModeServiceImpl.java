package com.infrasofttech.microfinance.servicesimpl;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import com.infrasofttech.microfinance.entityBeans.master.SubLookupMasterEntity;
import com.infrasofttech.microfinance.entityBeans.master.TransactionModeEntity;
import com.infrasofttech.microfinance.repository.ProductRepository;
import com.infrasofttech.microfinance.repository.TransactionModeRepository;
import com.infrasofttech.microfinance.services.TransactionModeService;

@Service
@Transactional
public class TransactionModeServiceImpl implements TransactionModeService {

	@Autowired
	TransactionModeRepository repo;
	
	
	@Override
	public ResponseEntity<?> getAllTransactionModeData() {
		try {
			List<TransactionModeEntity> transactionModeList=repo.findAll();
			if(transactionModeList.isEmpty()) 
				return ResponseEntity.notFound().build();
			return new ResponseEntity<List<TransactionModeEntity>>(transactionModeList,new HttpHeaders(),HttpStatus.OK);
		}catch(Exception e) {
			//logger.error("No Record Found."+e.getMessage());
			return new ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY);
		}
	}

}
