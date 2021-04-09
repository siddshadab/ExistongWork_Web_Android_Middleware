package com.infrasofttech.microfinance.servicesimpl;

import java.util.List;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import com.infrasofttech.microfinance.entityBeans.CountriesEntity;
import com.infrasofttech.microfinance.entityBeans.StatesEntity;
import com.infrasofttech.microfinance.repository.CountriesRepository;
import com.infrasofttech.microfinance.repository.StatesRepository;
import com.infrasofttech.microfinance.services.StatesServices;


@Service
public class StatesServicesImpl implements StatesServices{

	
	@Autowired
	StatesRepository repo;
	
	
	@Override
	public ResponseEntity<?> getStates() {
		try {
			List<StatesEntity> stateList=repo.findAll();
			if(stateList.isEmpty()) 
				return ResponseEntity.notFound().build();
			return new ResponseEntity<List<StatesEntity>>(stateList,new HttpHeaders(),HttpStatus.OK);
		}catch(Exception e) {
			//logger.error("No Record Found."+e.getMessage());
			return new ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY);
		}
		
	//	return new ResponseEntity<Object>(repo.save(entity),new HttpHeaders(),HttpStatus.CREATED);
		
		
	}

}
