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
import com.infrasofttech.microfinance.entityBeans.master.LookupMasterEntity;
import com.infrasofttech.microfinance.repository.InterestOffsetRepository;
import com.infrasofttech.microfinance.repository.InterestSlabRepository;
import com.infrasofttech.microfinance.repository.LookupMasterRepository;
import com.infrasofttech.microfinance.services.InterestOffsetServices;
import com.infrasofttech.microfinance.services.InterestSlabServices;
import com.infrasofttech.microfinance.services.LookupMasterServices;

@Transactional
@Service
public class InterestOffsetServicesImpl implements InterestOffsetServices{

	@Autowired
	InterestOffsetRepository repo;




	@Override
	public ResponseEntity<?> getAllInterestOffsetData() {
		try {
			List<InterestOffsetEntity> dbEntity = repo.findAll();
			if(null == dbEntity)
				return ResponseEntity.notFound().build();
			return new ResponseEntity<Object>(dbEntity,new HttpHeaders(),HttpStatus.OK);
		}catch(Exception e) {
			//logger.error("No Record Found."+e.getMessage());
			return new ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY);
		}
	}
	
	
	
}
