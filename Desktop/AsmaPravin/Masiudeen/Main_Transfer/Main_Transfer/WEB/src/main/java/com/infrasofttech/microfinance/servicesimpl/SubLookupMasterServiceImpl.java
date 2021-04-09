package com.infrasofttech.microfinance.servicesimpl;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import com.infrasofttech.microfinance.entityBeans.master.CustomerEntity;
import com.infrasofttech.microfinance.entityBeans.master.LookupMasterEntity;
import com.infrasofttech.microfinance.entityBeans.master.SubLookupMasterEntity;
import com.infrasofttech.microfinance.repository.SubLookupMasterRepository;
import com.infrasofttech.microfinance.services.SubLookupMasterServices;

@Service
@Transactional
public class SubLookupMasterServiceImpl implements SubLookupMasterServices {

	@Autowired
	SubLookupMasterRepository repo;
	
	
	@Override
	public ResponseEntity<?> getAllLookupData() {
		try {
			List<SubLookupMasterEntity> dbEntity = repo.findAll();
			if(null == dbEntity)
				return ResponseEntity.notFound().build();
			return new ResponseEntity<Object>(dbEntity,new HttpHeaders(),HttpStatus.OK);
		}catch(Exception e) {
			//logger.error("No Record Found."+e.getMessage());
			return new ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY);
		}
	}
	
	

	
	
}
