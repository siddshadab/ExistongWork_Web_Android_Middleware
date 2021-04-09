package com.infrasofttech.microfinance.servicesimpl;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import com.infrasofttech.microfinance.entityBeans.CountriesEntity;
import com.infrasofttech.microfinance.entityBeans.master.LookupMasterEntity;
import com.infrasofttech.microfinance.repository.LookupMasterRepository;
import com.infrasofttech.microfinance.services.LookupMasterServices;

@Transactional
@Service
public class LookupMasterServicesImpl implements LookupMasterServices{

	@Autowired
	LookupMasterRepository repo;
	
	@Override
	public ResponseEntity<?> getAllLookupData() {
		try {
			List<LookupMasterEntity> dbEntity = repo.findAll();
			if(null == dbEntity)
				return ResponseEntity.notFound().build();
			return new ResponseEntity<Object>(dbEntity,new HttpHeaders(),HttpStatus.OK);
		}catch(Exception e) {
			//logger.error("No Record Found."+e.getMessage());
			return new ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY);
		}
	}

/*	@Override
	public ResponseEntity<?> getAllSubLookupData() {
		try {
			List<LookupMasterEntity> dbEntity = repo.findAll();
			if(null == dbEntity)
				return ResponseEntity.notFound().build();
			return new ResponseEntity<Object>(dbEntity,new HttpHeaders(),HttpStatus.OK);
		}catch(Exception e) {
			//logger.error("No Record Found."+e.getMessage());
			return new ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY);
		}
	}*/
	
	
	
}
