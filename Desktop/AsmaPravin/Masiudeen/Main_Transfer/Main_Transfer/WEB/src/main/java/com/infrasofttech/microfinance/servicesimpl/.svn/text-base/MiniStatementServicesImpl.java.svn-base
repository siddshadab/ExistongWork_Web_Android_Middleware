package com.infrasofttech.microfinance.servicesimpl;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import com.infrasofttech.microfinance.entityBeans.master.CustomerEntity;
import com.infrasofttech.microfinance.entityBeans.master.MiniStatementEntity;
import com.infrasofttech.microfinance.entityBeans.master.SavingsListEntity;
import com.infrasofttech.microfinance.repository.MiniStatementRepository;
import com.infrasofttech.microfinance.repository.SavingsListRepository;
import com.infrasofttech.microfinance.services.MiniStatementServices;
import com.infrasofttech.microfinance.services.SavingsListServices;

@Service
@Transactional
public class MiniStatementServicesImpl implements MiniStatementServices {

	@Autowired
	MiniStatementRepository repo;

	  @Transactional 
	  @Override
	
       	public ResponseEntity<?> findByProductAccIdAndLbrCode(MiniStatementEntity miniStatementEntity) {
		  try {
			  List<MiniStatementEntity> miniStatList;

			  miniStatList=repo.findByProductAccIdAndLbrCode(miniStatementEntity.getMprdacctid(), miniStatementEntity.getMlbrcode()); 
			  if(miniStatList.isEmpty())
			  return ResponseEntity.notFound().build(); 
			  
			  return new ResponseEntity<List<MiniStatementEntity>> (miniStatList,new HttpHeaders(),HttpStatus.OK);
			  }
		          catch(Exception e) {
				  return new  ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY);
				  }
	}


	
		
	 

}
