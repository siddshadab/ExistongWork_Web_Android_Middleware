package com.infrasofttech.microfinance.servicesimpl;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import com.infrasofttech.microfinance.entityBeans.master.CheckListCGT2Entity;
import com.infrasofttech.microfinance.repository.CheckListCGT2Repository;
import com.infrasofttech.microfinance.services.CheckListCGT2Service;



@Service
@Transactional
public class CheckListCGT2ServiceImpl implements CheckListCGT2Service {
	

	@Autowired
	CheckListCGT2Repository repo;

	@Override
	public ResponseEntity<?> getAllCheckListCGT2Data() {
		try {
			List<CheckListCGT2Entity> checkList=repo.findAll();
			if(checkList.isEmpty()) 
				return ResponseEntity.notFound().build();
			return new ResponseEntity<List<CheckListCGT2Entity>>(checkList,new HttpHeaders(),HttpStatus.OK);
		}catch(Exception e) {			
			return new ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY);
		}
	}
	
	@Transactional
	@Override
	public ResponseEntity<?> addList(List<CheckListCGT2Entity> checkList) {
    try {	 
			
			return new ResponseEntity<Object>(repo.saveAll(checkList),new HttpHeaders(),HttpStatus.CREATED);
		} catch (Exception e) {
			//logger.error("Error While Persisting Object"+e.getMessage());
			return new ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY);
		}
	}

}
