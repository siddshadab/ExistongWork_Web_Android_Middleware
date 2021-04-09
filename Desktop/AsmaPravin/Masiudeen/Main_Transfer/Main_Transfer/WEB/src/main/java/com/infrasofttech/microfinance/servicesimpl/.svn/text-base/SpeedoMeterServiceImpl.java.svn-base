package com.infrasofttech.microfinance.servicesimpl;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import com.infrasofttech.microfinance.entityBeans.master.SpeedoMeterEntity;
import com.infrasofttech.microfinance.repository.SpeedoMeterRepository;
import com.infrasofttech.microfinance.services.SpeedoMeterService;



@Service
@Transactional
public class SpeedoMeterServiceImpl implements SpeedoMeterService {	

	@Autowired
	SpeedoMeterRepository repo;
	
	
	@Transactional
	@Override
	public ResponseEntity<?> addList(List<SpeedoMeterEntity> spmetr) {
    try {	 
			
			return new ResponseEntity<Object>(repo.saveAll(spmetr),new HttpHeaders(),HttpStatus.CREATED);
		} catch (Exception e) {
			//logger.error("Error While Persisting Object"+e.getMessage());
			return new ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY);
		}
	}

}
