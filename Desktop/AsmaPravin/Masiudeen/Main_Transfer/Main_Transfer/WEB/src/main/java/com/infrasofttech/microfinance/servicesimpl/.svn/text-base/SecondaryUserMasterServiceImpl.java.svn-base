package com.infrasofttech.microfinance.servicesimpl;

import java.util.List;

import javax.transaction.Transactional;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import com.infrasofttech.microfinance.entityBeans.master.SecondaryUserMasterEntity;
import com.infrasofttech.microfinance.repository.SecondaryUserMasterRepository;
import com.infrasofttech.microfinance.services.SecondaryUserMasterServices;

@Transactional
@Service
public class SecondaryUserMasterServiceImpl implements SecondaryUserMasterServices {

	@Autowired
	SecondaryUserMasterRepository repo;
	
	
	@Override
	public ResponseEntity<?> getAllSecondaryUser() {
		List<SecondaryUserMasterEntity> secondaryList = repo.findAll(Sort.by(Sort.Direction.DESC,"mcreateddt"));
		
		try {
			if(secondaryList.isEmpty()) 
				return ResponseEntity.notFound().build();		
			return new ResponseEntity<Object>(secondaryList,new HttpHeaders(),HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			return new ResponseEntity<>(new HttpHeaders(),HttpStatus.UNPROCESSABLE_ENTITY);
		}
	}

	@Override
	public ResponseEntity<?> addSecondaryUser(SecondaryUserMasterEntity secondaryEntity) {
		
		try {
			SecondaryUserMasterEntity secEnt = repo.findDataByUsrCode(secondaryEntity.getMusrcode());
			
			if(secEnt == null) {
				secondaryEntity.setMerrorcode(200);
				secondaryEntity.setMerrormessage("Record Added Succesfully");
				repo.save(secondaryEntity);
				return new ResponseEntity<Object>(secondaryEntity,new HttpHeaders(),HttpStatus.OK);
			}else {
				secondaryEntity.setMerrorcode(200);
				secondaryEntity.setMerrormessage("Record Already Exists");
				return new ResponseEntity<Object>(secondaryEntity,new HttpHeaders(),HttpStatus.OK);			
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return new ResponseEntity<>(new HttpHeaders(),HttpStatus.UNPROCESSABLE_ENTITY);

		}
		
		
	}

	@Override
	public ResponseEntity<?> editSecondaryUser(SecondaryUserMasterEntity secondaryEntity) {
		
		try {			
			if(secondaryEntity != null) {
				secondaryEntity.setMerrorcode(200);
				secondaryEntity.setMerrormessage("Record Updated Succesfully");
				repo.save(secondaryEntity);
				return new ResponseEntity<Object>(secondaryEntity,new HttpHeaders(),HttpStatus.OK);
			}else {
				secondaryEntity.setMerrorcode(200);
				secondaryEntity.setMerrormessage("Something Went Wrong");
				return new ResponseEntity<Object>(secondaryEntity,new HttpHeaders(),HttpStatus.OK);			
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return new ResponseEntity<>(new HttpHeaders(),HttpStatus.UNPROCESSABLE_ENTITY);

		}
	}

	@Override
	public ResponseEntity<?> deleteSecondaryUser(SecondaryUserMasterEntity secondaryEntity) {
		// TODO Auto-generated method stub
		return null;
	}

}
