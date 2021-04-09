package com.infrasofttech.microfinance.servicesimpl;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import com.infrasofttech.microfinance.entityBeans.master.CurrencyEntity;
import com.infrasofttech.microfinance.repository.CurrencyRepository;
import com.infrasofttech.microfinance.services.CurrencyServices;

@Service
@Transactional
public class CurrencyMasterServiceImpl implements CurrencyServices {

	@Autowired 
	CurrencyRepository repo;
	
	@Override
	public ResponseEntity<?> getAllCurrCd() {
		
//		try {
			List<CurrencyEntity> curr=repo.findAll();
//			if(curr.isEmpty()) 
//				return ResponseEntity.notFound().build();
			return new ResponseEntity<Object>(curr,new HttpHeaders(),HttpStatus.OK);
//		}catch(Exception e) {			
//			return new ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY);
//		}
	
	}

	
	
}
