package com.infrasofttech.microfinance.servicesimpl;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import com.infrasofttech.microfinance.entityBeans.master.TDOffsetInterestSlabEntity;
import com.infrasofttech.microfinance.entityBeans.master.TDParameterEntity;
import com.infrasofttech.microfinance.repository.TDOffsetInterestSlabRepository;
import com.infrasofttech.microfinance.repository.TDParameterRepository;
import com.infrasofttech.microfinance.services.TDParameterService;

@Transactional
@Service
public class TDParameterServiceImpl implements TDParameterService {

	@Autowired
	TDParameterRepository repo;
	
	@Override
	public ResponseEntity<?> getAllTDParameterData() {
		// TODO Auto-generated method stub
		try {
			List<TDParameterEntity> dbEntity = repo.findAll();
			if(null == dbEntity)
				return ResponseEntity.notFound().build();
			return new ResponseEntity<Object>(dbEntity,new HttpHeaders(),HttpStatus.OK);
		}catch(Exception e) {
			//logger.error("No Record Found."+e.getMessage());
			return new ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY);
		}
	}

	
	
}
