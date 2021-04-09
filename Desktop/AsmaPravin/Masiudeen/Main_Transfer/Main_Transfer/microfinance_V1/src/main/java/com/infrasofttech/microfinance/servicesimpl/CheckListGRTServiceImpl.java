package com.infrasofttech.microfinance.servicesimpl;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import com.infrasofttech.microfinance.entityBeans.master.CheckListCGT1Entity;
import com.infrasofttech.microfinance.entityBeans.master.CheckListGRTEntity;
import com.infrasofttech.microfinance.repository.CheckListCGT1Repository;
import com.infrasofttech.microfinance.repository.CheckListGRTRepository;
import com.infrasofttech.microfinance.services.CheckListCGT1Service;
import com.infrasofttech.microfinance.services.CheckListGRTService;



@Service
@Transactional
public class CheckListGRTServiceImpl implements CheckListGRTService {
	

	@Autowired
	CheckListGRTRepository repo;

	@Override
	public ResponseEntity<?> getAllCheckListGRTData() {
		try {
			List<CheckListGRTEntity> checkList=repo.findAll();
			if(checkList.isEmpty()) 
				return ResponseEntity.notFound().build();
			return new ResponseEntity<List<CheckListGRTEntity>>(checkList,new HttpHeaders(),HttpStatus.OK);
		}catch(Exception e) {			
			return new ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY);
		}
	}
	
	@Transactional
	@Override
	public ResponseEntity<?> addList(List<CheckListGRTEntity> checkList) {
    try {	 
			
			return new ResponseEntity<Object>(repo.saveAll(checkList),new HttpHeaders(),HttpStatus.CREATED);
		} catch (Exception e) {
			//logger.error("Error While Persisting Object"+e.getMessage());
			return new ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY);
		}
	}

}
