package com.infrasofttech.microfinance.servicesimpl;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import com.infrasofttech.microfinance.entityBeans.master.CheckListEntity;
import com.infrasofttech.microfinance.repository.CheckListRepository;
import com.infrasofttech.microfinance.services.CheckListService;



@Service
@Transactional
public class CheckListServiceImpl implements CheckListService {
	

	@Autowired
	CheckListRepository repo;

	@Override
	public ResponseEntity<?> getAllCheckListData() {
		try {
			List<CheckListEntity> checkList=repo.findAll();
			if(checkList.isEmpty()) 
				return ResponseEntity.notFound().build();
			return new ResponseEntity<List<CheckListEntity>>(checkList,new HttpHeaders(),HttpStatus.OK);
		}catch(Exception e) {			
			return new ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY);
		}
	}
	
	@Transactional
	@Override
	public ResponseEntity<?> addList(List<CheckListEntity> checkList) {
    try {	 
			
			return new ResponseEntity<Object>(repo.saveAll(checkList),new HttpHeaders(),HttpStatus.CREATED);
		} catch (Exception e) {
			//logger.error("Error While Persisting Object"+e.getMessage());
			return new ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY);
		}
	}

}
